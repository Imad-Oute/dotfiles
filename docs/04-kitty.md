# 04 · Kitty (terminal emulator)

Kitty is the terminal *window* — the GPU-accelerated surface that draws text,
handles fonts, padding, and (with the compositor) transparency. Everything else in
the screenshot (prompt, tabs, colors) runs *inside* kitty; kitty just provides the
canvas.

## The include chain

Kitty config is layered. `kitty.conf` (yours) pulls in HyDE's base and the
generated theme:

```
kitty.conf  (✅ yours, tracked)
   └─ include hyde.conf      (⚠️ HyDE base: font, padding, font_size)
        └─ include theme.conf (⛔ wallbash-generated colors — never edit)
```

Later settings override earlier ones, so anything you put in `kitty.conf` *after*
the `include hyde.conf` line wins. That's the whole strategy: inherit HyDE's
sensible base, override only what you care about.

### hyde.conf (HyDE base — for reference, don't edit)

```ini
font_family CaskaydiaCove Nerd Font Mono
font_size 9.0
window_padding_width 25
cursor_trail 1
enable_audio_bell no
include theme.conf
```

### theme.conf (generated — never edit)

Wallbash writes the 16 ANSI colors + background/foreground/cursor here every time
the wallpaper changes. Editing it is pointless; it'll be overwritten. To change
terminal colors, change the theme/wallpaper (see [02-theming-pipeline.md](02-theming-pipeline.md)).

## kitty.conf — your overrides explained

```ini
include hyde.conf            # inherit HyDE base + generated theme

# ── Opacity: see the IMPORTANT note below ──
background_opacity     1.0   # kept at 1.0 ON PURPOSE (Hyprland owns transparency)
dynamic_background_opacity yes  # lets you live-adjust with ctrl+shift+a then +/-

window_padding_width   18    # a bit tighter than HyDE's 25

# ── Tabs OFF, because tmux draws tabs ──
tab_bar_style          hidden

cursor_shape           block
cursor_blink_interval  0     # steady cursor
scrollback_lines       10000
confirm_os_window_close 0
```

### ⚠️ The opacity gotcha (read this)

There are **two** opacity controls and they **multiply**:

1. **Hyprland** sets kitty to `0.80` via a window rule in
   `windowrules.conf` (`opacity 0.80 $& 0.80 $& 1, match:class ^(kitty)$`).
2. **Kitty** has its own `background_opacity`.

If both are < 1, the effective opacity is their product (e.g. `0.80 × 0.92 ≈ 0.74`)
— too washed out. The convention here: **Hyprland owns transparency, kitty stays at
`1.0`.** To make the terminal more/less see-through, edit the `0.80` in
[`windowrules.conf`](03-hyprland.md#window-rules), not kitty.

**Why this split:** the *blur* behind the terminal is a compositor effect — kitty
can't blur on its own. Since Hyprland already has to be involved for blur, letting
it also own opacity keeps it in one place and avoids the multiply trap.

### Why tabs are hidden

You run **tmux** inside kitty, and tmux draws its own tab bar (the colored
`worktrunk / tmux / nu` pills). Kitty's native tab bar stacked on top would be
redundant and ugly, so `tab_bar_style hidden`. If you ever use kitty *without*
tmux, set it back to `powerline`.

## Fonts

HyDE sets **CaskaydiaCove Nerd Font Mono** at size 9. Also installed:
**JetBrainsMono Nerd Font** (the glyph shapes in the reference screenshot). To
switch, uncomment in `kitty.conf`:

```ini
font_family   JetBrainsMono Nerd Font
font_size     11.0
```

A **Nerd Font is mandatory** for the prompt and tmux bar to render icons (git
branch, folders, powerline separators) instead of tofu boxes. Installed Nerd Fonts:

```bash
fc-list | grep -i nerd        # list them
```

## Live tweaking without reload

- `ctrl+shift+a` then `+` / `-` — adjust opacity on the fly (needs
  `dynamic_background_opacity yes`).
- `ctrl+shift+f5` — reload `kitty.conf` without restarting.
- `ctrl+shift+,` (kitty's font increase) — bump font size live.

## Common tasks

**"Terminal is too transparent."** → raise `0.80` toward `1.0` in
`windowrules.conf`, then `hyprctl reload`.

**"Icons show as boxes."** → font isn't a Nerd Font, or the wrong variant. Ensure
`font_family` is a `… Nerd Font` (not the plain font).

**"I want kitty tabs back (no tmux)."** → set `tab_bar_style powerline` in
`kitty.conf`.

🔗 Kitty config reference: https://sw.kovidgoyal.net/kitty/conf/
