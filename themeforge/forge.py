#!/usr/bin/env python3
"""themeforge — render a full HyDE theme (every layer) from one TOML token file.

    forge.py build  <slug|all>     render into themeforge/build/<Name>/
    forge.py install <slug|all>    build + symlink into ~/.config/hyde/themes + install GTK/Kvantum

Template syntax (templates/**/*.tpl):
    {{ palette.accent }}                   raw token
    {{ palette.accent | hypr }}            colour filters: hex css rasi hypr rgb
    {{ palette.bg | a:0.5 | css }}         alpha, lighten:0.1, darken:0.1, mix:palette.red:0.3
    {% if fx %} ... {% else %} ... {% endif %}   (not nestable; fx = glass effects enabled)
"""
from __future__ import annotations

import colorsys
import os
import re
import shutil
import subprocess
import sys
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent
TOKENS = ROOT / "tokens"
TEMPLATES = ROOT / "templates"
THEMES_SRC = ROOT / "build"          # generated artefacts (gitignored); the installer rebuilds them on any machine
HOME = Path.home()
THEMES_LIVE = HOME / ".config" / "hyde" / "themes"
GTK_DIR = HOME / ".local" / "share" / "themes"

# ── colour model ────────────────────────────────────────────────────────────
Color = tuple[float, float, float, float]  # r,g,b 0-255, a 0-1


def parse(s: str) -> Color:
    s = s.lstrip("#")
    if len(s) == 6:
        s += "ff"
    r, g, b, a = (int(s[i:i + 2], 16) for i in (0, 2, 4, 6))
    return (r, g, b, a / 255)


def is_color(v) -> bool:
    return isinstance(v, str) and re.fullmatch(r"#[0-9a-fA-F]{6}([0-9a-fA-F]{2})?", v) is not None


def _hex2(x: float) -> str:
    return f"{max(0, min(255, round(x))):02x}"


def f_hex(c: Color) -> str:
    return _hex2(c[0]) + _hex2(c[1]) + _hex2(c[2])


def f_css(c: Color) -> str:
    return f"rgba({round(c[0])}, {round(c[1])}, {round(c[2])}, {round(c[3], 3):g})"


def f_hash(c: Color) -> str:
    return "#" + f_hex(c)


def f_rasi(c: Color) -> str:
    return "#" + f_hex(c) + _hex2(c[3] * 255)


def f_hypr(c: Color) -> str:
    return "rgba(" + f_hex(c) + _hex2(c[3] * 255) + ")"


def f_rgb(c: Color) -> str:
    return f"{round(c[0])},{round(c[1])},{round(c[2])}"


def hls_shift(c: Color, dl: float) -> Color:
    h, l, s = colorsys.rgb_to_hls(c[0] / 255, c[1] / 255, c[2] / 255)
    l = max(0.0, min(1.0, l + dl))
    r, g, b = colorsys.hls_to_rgb(h, l, s)
    return (r * 255, g * 255, b * 255, c[3])


def mix(a: Color, b: Color, t: float) -> Color:
    return tuple(a[i] + (b[i] - a[i]) * t for i in range(4))  # type: ignore[return-value]


def ramp(c: Color, n: int = 9) -> list[Color]:
    """Dark→light ramp whose 5th step is exactly `c` (so `2xa5` == the token accent in theme mode)."""
    h, l0, s = colorsys.rgb_to_hls(c[0] / 255, c[1] / 255, c[2] / 255)
    lo, hi, mid = min(0.16, l0 * 0.6), 0.93, 4
    out = []
    for i in range(n):
        l = lo + (l0 - lo) * i / mid if i <= mid else l0 + (hi - l0) * (i - mid) / (n - 1 - mid)
        r, g, b = colorsys.hls_to_rgb(h, l, s)
        out.append((r * 255, g * 255, b * 255, 1.0))
    return out


def surface_ramp(p: dict) -> list[Color]:
    """pry1 ramp = the neutral surface/text scale, in the slots HyDE's own templates expect:
    xa1 surface/button, xa2 hover, xa3 separator/light, xa4 disabled text, xa9 primary text."""
    t2, t = parse(p["text2"]), parse(p["text"])
    return [parse(p["raised"]), parse(p["raised2"]), parse(p["separator"]), parse(p["text3"]),
            mix(parse(p["text3"]), t2, 0.5), mix(parse(p["text3"]), t2, 0.85), t2, mix(t2, t, 0.5), t]


# ── template engine ─────────────────────────────────────────────────────────
class Ctx:
    def __init__(self, tokens: dict):
        self.t = tokens
        tokens["meta"]["home"] = str(HOME)
        tokens["meta"]["sfx"] = "-dark" if tokens["meta"]["mode"] == "dark" else ""
        g = tokens["glass"]
        self.fx = g["blur_passes"] > 1 and g["window_active"] < 1.0

    def get(self, path: str):
        cur = self.t
        for part in path.split("."):
            cur = cur[part]
        return cur

    def render_value(self, expr: str) -> str:
        parts = [p.strip() for p in expr.split("|")]
        v = self.get(parts[0])
        if not is_color(v):
            return str(v)
        c = parse(v)
        fmt = f_hex
        num = lambda x: float(x) if re.fullmatch(r"-?[\d.]+", x) else float(self.get(x))
        for f in parts[1:]:
            name, _, arg = f.partition(":")
            if name == "a":
                c = (c[0], c[1], c[2], num(arg))
            elif name == "lighten":
                c = hls_shift(c, num(arg))
            elif name == "darken":
                c = hls_shift(c, -num(arg))
            elif name == "mix":
                other, _, t = arg.rpartition(":")
                c = mix(c, parse(self.get(other)), num(t))
            elif name in ("hex", "hash", "css", "rasi", "hypr", "rgb"):
                fmt = {"hex": f_hex, "hash": f_hash, "css": f_css, "rasi": f_rasi, "hypr": f_hypr, "rgb": f_rgb}[name]
            else:
                raise ValueError(f"unknown filter {name!r} in {{{{ {expr} }}}}")
        return fmt(c)

    def render(self, text: str) -> str:
        def pick(m: re.Match) -> str:
            body, _, other = m.group(2).partition("{% else %}")
            return body if (self.fx if m.group(1) == "fx" else not self.fx) else other

        # inline (single line) first, then multi-line blocks (which swallow their own trailing newline)
        text = re.sub(r"\{% if (fx|!fx) %\}([^\n]*?)\{% endif %\}", lambda m: pick(m).strip(), text)
        text = re.sub(r"\{% if (fx|!fx) %\}\n(.*?)\{% endif %\}\n?",
                      lambda m: pick(m).strip("\n") + "\n" if pick(m).strip() else "", text, flags=re.S)
        return re.sub(r"\{\{\s*([^}]+?)\s*\}\}", lambda m: self.render_value(m.group(1)), text)


# ── dcol palette (feeds HyDE's `always/*.dcol` templates with FIXED colours) ─
def make_dcol(t: dict) -> str:
    p = t["palette"]
    pry = [parse(p["base"]), parse(p["accent"]), parse(p["accent2"]), parse(p["accent_hi"])]
    txt = [parse(p["text"]), parse(p["on_accent"]), parse(p["on_accent"]), parse(p["text"])]
    lines = [f'dcol_mode="{t["meta"]["mode"]}"']
    for i, (c, tx) in enumerate(zip(pry, txt), start=1):
        lines += [
            f'dcol_pry{i}="{f_hex(c).upper()}"',
            f'dcol_pry{i}_rgba="rgba({round(c[0])},{round(c[1])},{round(c[2])},\\1)"',
            f'dcol_txt{i}="{f_hex(tx).upper()}"',
            f'dcol_txt{i}_rgba="rgba({round(tx[0])},{round(tx[1])},{round(tx[2])},\\1)"',
        ]
        for j, a in enumerate(surface_ramp(p) if i == 1 else ramp(c), start=1):
            lines += [
                f'dcol_{i}xa{j}="{f_hex(a).upper()}"',
                f'dcol_{i}xa{j}_rgba="rgba({round(a[0])},{round(a[1])},{round(a[2])},\\1)"',
            ]
    return "\n".join(lines) + "\n"



# ── Kvantum: recolour a shaped base theme into wallbash slots ───────────────
# The base SVG/kvconfig keeps the shapes (capsules, radii, gradients); every colour in it is replaced by a
# `#<wallbash_SLOT>` placeholder chosen by luminance against THIS theme's palette. HyDE substitutes the real
# values at deploy time, so Qt follows the palette (theme mode) while the geometry stays ours.
def _luma(c: Color) -> float:
    return (0.2126 * c[0] + 0.7152 * c[1] + 0.0722 * c[2]) / 255


def kv_slots(t: dict):
    p = t["palette"]
    neutral = [("pry1", parse(p["base"]))] + [(f"1xa{i}", c) for i, c in enumerate(surface_ramp(p), 1)]
    accent = [(f"2xa{i}", c) for i, c in enumerate(ramp(parse(p["accent"])), 1)]
    return neutral, accent


def kv_recolor(text: str, t: dict) -> str:
    neutral, accent = kv_slots(t)
    cache: dict[str, str] = {}

    def pick(m: re.Match) -> str:
        h = m.group(0).lower()
        if h not in cache:
            c = parse(h)
            _, l, sat = colorsys.rgb_to_hls(c[0] / 255, c[1] / 255, c[2] / 255)
            if l < 0.02 or l > 0.98:
                cache[h] = m.group(0)                                   # pure black/white: keep
            else:
                pool = accent[3:8] if sat > 0.45 else neutral   # saturated → readable mid/bright accent steps
                slot = min(pool, key=lambda s: abs(_luma(s[1]) - _luma(c)))[0]
                cache[h] = f"#<wallbash_{slot}>"
        return cache[h]

    return re.sub(r"#[0-9a-fA-F]{6}\b", pick, text)


def build_kvantum(t: dict, out: Path) -> None:
    base = Path("/usr/share/Kvantum") / t["meta"].get("qt_base", "KvCurves")
    name = base.name
    if not base.is_dir():
        print(f"  ! Kvantum base {base} missing; skipping Qt layer")
        return
    ctx = Ctx(t)
    g, fx = t["glass"], ctx.fx
    kd = out / "kvantum"
    kd.mkdir(exist_ok=True)

    (kd / "kvantum.theme").write_text(
        "$HOME/.config/Kvantum/wallbash/wallbash.svg\n" + kv_recolor((base / f"{name}.svg").read_text(), t))

    cfg = kv_recolor((base / f"{name}.kvconfig").read_text(), t)
    b = lambda v: "true" if v else "false"
    # Material philosophy: the COMPOSITOR owns window glass (Hyprland opacity + blur on an opaque buffer, exactly
    # like kitty). Kvantum stays opaque for windows; only popup menus are translucent so Hyprland blurs them.
    over = {
        "comment": f"{t['meta']['name']} (themeforge; base {name})",
        "translucent_windows": "false", "blurring": "false", "popup_blurring": b(fx),
        "reduce_window_opacity": "0",
        "reduce_menu_opacity": str(round((1 - g["popup_alpha"]) * 100)) if fx else "0",
        "menu_blur_radius": str(g["blur_size"]), "tooltip_blur_radius": str(g["blur_size"]),
        "menu_shadow_depth": "9" if fx else "0", "tooltip_shadow_depth": "4" if fx else "0",
        "progressbar_thickness": "8" if fx else "4",
    }
    head, _, rest = cfg.partition("\n[GeneralColors]")
    for k, v in over.items():
        if re.search(rf"^{k}=", head, re.M):
            head = re.sub(rf"^{k}=.*$", f"{k}={v}", head, flags=re.M)
        else:
            head = head.replace("[%General]\n", f"[%General]\n{k}={v}\n", 1)
    # semantic colour roles (slots follow HyDE's conventions so they match its other templates)
    roles = {
        "window.color": "pry1", "base.color": "1xa1", "alt.base.color": "1xa1", "button.color": "1xa2",
        "light.color": "1xa3", "mid.light.color": "1xa3", "dark.color": "pry1", "mid.color": "1xa1",
        "highlight.color": "2xa5", "inactive.highlight.color": "2xa3", "tooltip.base.color": "pry1",
        "text.color": "txt1", "window.text.color": "txt1", "button.text.color": "txt1",
        "tooltip.text.color": "txt1", "disabled.text.color": "1xa4", "highlight.text.color": "txt2",
        "link.color": "2xa7", "link.visited.color": "3xa5",
    }
    gc, sep, tail = rest.partition("\n\n[")
    for k, slot in roles.items():
        line = f"{k}=#<wallbash_{slot}>"
        if re.search(rf"^{re.escape(k)}=", gc, re.M):
            gc = re.sub(rf"^{re.escape(k)}=.*$", line, gc, flags=re.M)
        else:
            gc += "\n" + line
    cfg = head + "\n[GeneralColors]" + gc + (sep + tail if sep else "")
    (kd / "kvconfig.theme").write_text("$HOME/.config/Kvantum/wallbash/wallbash.kvconfig\n" + cfg)


# ── build ───────────────────────────────────────────────────────────────────
# template path (relative to templates/)  →  output path (relative to theme dir)
FILES = {
    "hypr.theme.tpl": "hypr.theme",
    "kitty.theme.tpl": "kitty.theme",
    "rofi.theme.tpl": "rofi.theme",
    "waybar.theme.tpl": "waybar.theme",
    "tmux.theme.tpl": "tmux.theme",
    "vscode.theme.tpl": "vscode.theme",
}
TREES = {  # template dir → output dir
    "gtk": "gtk",
    "hyprlock": "hyprlock",
}


def load(slug: str) -> dict:
    return tomllib.loads((TOKENS / f"{slug}.toml").read_text())


def ensure_wallpapers(t: dict, out: Path) -> None:
    """Generate the theme's wallpapers with ImageMagick if missing (they are not committed)."""
    m = t["meta"]
    need = [m["wall"], m["lock"]]
    if all((out / "wallpapers" / n).exists() for n in need):
        return
    script = ROOT / "wallpapers.sh"
    if not shutil.which("magick") or not script.exists():
        print("  ! ImageMagick (magick) not found; skipping wallpaper generation")
        return
    subprocess.run(["bash", str(script), m["slug"], str(out / "wallpapers")], check=False)


def build(slug: str) -> Path:
    t = load(slug)
    ctx = Ctx(t)
    out = THEMES_SRC / t["meta"]["name"]
    out.mkdir(parents=True, exist_ok=True)
    (out / "wallpapers").mkdir(exist_ok=True)
    ensure_wallpapers(t, out)

    for tpl, dest in FILES.items():
        src = TEMPLATES / tpl
        if src.exists():
            (out / dest).write_text(ctx.render(src.read_text()))
    (out / "theme.dcol").write_text(make_dcol(t))
    build_kvantum(t, out)
    import vscode_theme
    vscode_theme.build_extension(t, out)

    for tdir, odir in TREES.items():
        base = TEMPLATES / tdir
        if not base.exists():
            continue
        for f in base.rglob("*"):
            if f.is_file():
                rel = f.relative_to(base)
                dst = out / odir / (rel.with_suffix("") if f.suffix == ".tpl" else rel)
                dst.parent.mkdir(parents=True, exist_ok=True)
                dst.write_text(ctx.render(f.read_text())) if f.suffix == ".tpl" else shutil.copy2(f, dst)
    print(f"built   {t['meta']['name']:<18} → {out}")
    return out


def install(slug: str) -> None:
    t = load(slug)
    m = t["meta"]
    out = build(slug)
    live = THEMES_LIVE / m["name"]
    # HyDE enumerates themes and deploys *.theme with `find -H -type d|f`; -H only follows the ROOT argument,
    # never symlinks inside it. So the theme dir must be a REAL dir holding REAL copies of every
    # *.theme / theme.dcol / kvantum file and wallpaper. GTK assets may be symlinked.
    if live.is_symlink():
        live.unlink()
    live.mkdir(parents=True, exist_ok=True)
    # The user's wallpaper choices are THEIRS: remember them before we touch anything and restore them afterwards.
    keep: dict[str, Path] = {}
    for name in ("wall.set", "wall.hyprlock.png"):
        link = live / name
        if link.is_symlink():
            tgt = Path(os.readlink(link))
            tgt = tgt if tgt.is_absolute() else link.parent / tgt
            if tgt.exists():
                keep[name] = tgt
    for p in list(live.iterdir()):          # clear stale links/copies we own; never touch a real wallpapers/ dir
        if p.name == "wallpapers" and p.is_dir() and not p.is_symlink():
            continue
        if p.is_symlink() or p.suffix in (".theme", ".dcol") or p.name == "kvantum":
            shutil.rmtree(p) if p.is_dir() and not p.is_symlink() else p.unlink()
    for f in out.iterdir():
        if f.suffix in (".theme", ".dcol"):
            shutil.copy2(f, live / f.name)
    if (out / "kvantum").is_dir():
        shutil.copytree(out / "kvantum", live / "kvantum")
    # wallpapers/ is a REAL directory so wallpapers you add (and HyDE's Super+Shift+W selector, which lists the
    # theme's wallpapers/ dir) live next to the generated ones. Generated files are copied in, never overwriting
    # a real file of the same name; nothing else in there is ever removed.
    wdir = live / "wallpapers"
    if wdir.is_symlink():
        wdir.unlink()
    wdir.mkdir(exist_ok=True)
    for g in (out / "wallpapers").iterdir():
        if g.is_file() and g.suffix.lower() in (".png", ".jpg", ".jpeg", ".webp", ".gif"):
            dst = wdir / g.name
            if dst.is_symlink():
                dst.unlink()
            if not dst.exists():
                shutil.copy2(g, dst)
    for name, key in (("wall.set", "wall"), ("wall.hyprlock.png", "lock")):
        target = keep.get(name) or wdir / m[key]
        if not target.exists() and key == "lock":
            target = wdir / m["wall"]                      # fall back to the desktop wallpaper
        if not target.exists():
            print(f"  ! missing wallpaper {target.name} for {name}")
            continue
        (live / name).symlink_to(target)
    # HyDE's wallpaper selector (Super+Shift+W) needs cached thumbnails for every wallpaper it lists: build them now
    if shutil.which("hyde-shell") and not os.environ.get("THEMEFORGE_SKIP_THUMBS"):
        subprocess.run(["hyde-shell", "wallpaper/cache.sh", "commence", "-t", m["name"]],
                       capture_output=True, timeout=600, check=False)
    # VS Code: install the generated theme extension + the hook script that selects it on theme switch
    hook = TEMPLATES / "bin" / "vscode-theme.py"
    hdst = HOME / ".local" / "lib" / "themeforge"
    hdst.mkdir(parents=True, exist_ok=True)
    shutil.copy2(hook, hdst / hook.name)
    vsix = out / "vscode" / f"themeforge-{m['slug']}.vsix"
    if vsix.exists() and shutil.which("code") and not os.environ.get("THEMEFORGE_SKIP_VSCODE"):
        r = subprocess.run(["code", "--install-extension", str(vsix), "--force"], capture_output=True, text=True, timeout=120)
        print(f"vscode  {m['name']}: " + ((r.stdout or r.stderr).strip().splitlines() or ["(no output)"])[-1])
    # Rofi launcher style (shared; adapts through theme.rasi variables + HyDE's rounding override)
    rs = TEMPLATES / "rofi" / "glass.rasi"
    rdst = HOME / ".local" / "share" / "rofi" / "themes"
    if rs.exists() and rdst.is_dir():
        shutil.copy2(rs, rdst / "glass.rasi")
        print(f"rofi    glass.rasi → {rdst}")
    # Lockscreen layout → ~/.config/hypr/hyprlock/<Theme>.conf (selectable via HyDE's hyprlock layout picker)
    lay = out / "hyprlock" / "layout.conf"
    if lay.exists():
        ldst = HOME / ".config" / "hypr" / "hyprlock"
        if ldst.is_dir():
            shutil.copy2(lay, ldst / f"{m['name']}.conf")
            print(f"lock    {m['name']}.conf → {ldst}")
    # GTK theme → ~/.local/share/themes/<gtk>
    gsrc = out / "gtk"
    if gsrc.exists():
        gdst = GTK_DIR / m["gtk"]
        gdst.mkdir(parents=True, exist_ok=True)
        for sub in gsrc.iterdir():
            d = gdst / sub.name
            if sub.is_dir():
                shutil.copytree(sub, d, dirs_exist_ok=True)
            else:
                shutil.copy2(sub, d)
        print(f"gtk     {m['gtk']} → {gdst}")
    print(f"linked  {m['name']} → {live}")


def main(argv: list[str]) -> int:
    if len(argv) < 3 or argv[1] not in ("build", "install"):
        print(__doc__)
        return 2
    slugs = [p.stem for p in sorted(TOKENS.glob("*.toml"))] if argv[2] == "all" else [argv[2]]
    for s in slugs:
        (build if argv[1] == "build" else install)(s)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
