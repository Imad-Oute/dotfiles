# 02 · Theming Pipeline (HyDE + wallbash)

This is the part of the setup that feels magic: pick a wallpaper, and the bar,
terminal, notifications, launcher, GTK/Qt apps, and even Firefox all recolor to
match it within a second. This guide explains the machinery so you can predict and
control it.

## The big idea

HyDE separates **theme** (a curated bundle: wallpapers + base colors + layout
choices) from **wallbash** (an engine that derives a live palette from whatever
wallpaper is currently shown). Most apps get their colors from wallbash, *templated*
from the current wallpaper, so the whole desktop is internally consistent.

```
            ┌──────────────┐
 wallpaper ─▶│   wallbash    │── extracts a 16-ish color palette
            └──────┬───────┘
                   │ fills in templates (.dcol / .theme files)
       ┌───────────┼───────────┬───────────┬───────────┐
       ▼           ▼           ▼           ▼           ▼
   kitty/      waybar/      dunst       rofi        firefox
 theme.conf   colors.css   (colors)   (colors)   (userChrome)
       │           │           │           │           │
       └───────────┴─── all regenerated, never hand-edited ──┘
```

## Theme vs wallpaper vs wallbash mode

Three different knobs, often confused:

- **Theme** (`Super+Shift+T`) — switches the whole bundle. This repo ships four:
  *Claude Dark*, *Neural*, *Phantom*, *Entropy*. Each lives in
  `.config/hyde/themes/<Name>/` and contains `.theme` files (hypr/kitty/waybar/rofi
  layout + base palette) plus a `wallpapers/` folder.
- **Wallpaper** (`Super+Shift+W` to select, `Super+Alt+→/←` to cycle) — changes the
  image *within* the current theme. Triggers wallbash to re-derive colors.
- **Wallbash mode** (`Super+Shift+R`) — controls *how* wallbash picks colors from
  the wallpaper (e.g. vibrant vs. muted, dark vs. auto).

## The four shipped themes

| Theme | Base bg | Accent(s) | Intended vibe |
|---|---|---|---|
| **Claude Dark** | `#1A1110` | coral `#D97757` | Warm, Anthropic-flavored |
| **Neural** | `#07050F` | violet `#7B61FF`, cyan `#00D9FF` | AI/ML research |
| **Phantom** | `#060C14` | blue `#0078FF`, ice `#00C8FF` | Stealth / blue-team |
| **Entropy** | `#0A0A0F` | red `#FF4500`, purple `#6A0DAD` | Crypto / reverse-engineering |

Each theme directory contains:

```
.config/hyde/themes/<Name>/
├── hypr.theme       # Hyprland: gaps, borders, blur, animations base
├── kitty.theme      # Kitty base palette for this theme
├── waybar.theme     # Waybar layout/colors base
├── rofi.theme       # Rofi launcher styling
├── kvantum/         # Qt theming
├── logo/            # theme logo (used by fastfetch / about screens)
├── wall.set         # symlink to the currently-selected wallpaper
├── wall.hyprlock.png# lockscreen background
└── wallpapers/      # the image pool (NOT in git — see wallpapers.md)
```

⚠️ The `.theme` files here are *templates/inputs*. The **outputs** wallbash writes
(`~/.config/kitty/theme.conf`, `~/.config/waybar/colors.css`, etc.) are the ones
you must never edit by hand.

## How an app opts into wallbash

Two patterns:

1. **`.theme` files** (kitty, waybar, rofi, hypr) — shipped per-theme, define the
   base colors and layout. HyDE merges these with wallbash output.
2. **`.dcol` templates** (the "always" overrides) — e.g.
   `.config/hyde/wallbash/always/firefox.dcol`. A `.dcol` is a template with
   placeholders that wallbash fills with live palette values, regardless of theme.
   This is how Firefox's `userChrome.css` colors track the wallpaper.

If you want a *new* app to follow your wallpaper colors, you write a `.dcol`
template for it and drop it in the wallbash directory. (Advanced; see HyDE docs.)

## Practical recipes

**"I want to permanently change a theme's accent color."**
Edit the theme's `.theme` file (e.g. `themes/Neural/kitty.theme`) — that's an input,
safe to edit. Do **not** edit `~/.config/kitty/theme.conf` (output, regenerated).

**"My terminal colors look wrong after a theme switch."**
Re-trigger wallbash by re-selecting the wallpaper (`Super+Shift+W`), or run
`hyde-shell wallpaper` to regenerate. The fix is almost never editing a config file.

**"I added a wallpaper but it doesn't show in the picker."**
Drop the image in `.config/hyde/themes/<Theme>/wallpapers/`, then point `wall.set`
at it: `ln -sf <image> ~/.config/hyde/themes/<Theme>/wall.set`, and re-run the
wallpaper selector.

**"I want the terminal more/less transparent."**
That's compositor opacity, not a color. See
[`windowrules.conf`](03-hyprland.md#window-rules) — the `opacity` rule for `kitty`.
Don't fight it with kitty's `background_opacity` (they multiply). See [04-kitty.md](04-kitty.md).

## Where HyDE keeps its own copies

HyDE ships defaults in `~/.local/share/hyde/` (e.g. an upstream `config.toml`,
`hyprland.conf` fallback, keybinding templates). Your repo overrides selected
pieces in `~/.config/`. When HyDE updates and changes a template, it notifies you
and leaves a new template under `$XDG_DATA_HOME/hyde/templates/` for manual merge —
it won't clobber your customized version.

🔗 HyDE configuration docs: https://hydeproject.pages.dev/en/configuring/
