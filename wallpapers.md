# Wallpapers

Wallpapers are not tracked in git (binary files). Re-download from Wallhaven and drop into the appropriate theme folder, then re-run the symlink commands.

## Re-download

```bash
# Install wallhaven-dl or just use wget:
cd ~/.config/hyde/themes/<Theme>/wallpapers/
wget "https://w.wallhaven.cc/full/XX/wallhaven-XXXXXX.png"
```

Or browse directly: `https://wallhaven.cc/w/<ID>`

---

## Claude Dark

| ID | URL |
|---|---|
| 0w5exq | https://wallhaven.cc/w/0w5exq |
| 3k93lv | https://wallhaven.cc/w/3k93lv |
| 5weox9 | https://wallhaven.cc/w/5weox9 |
| 6ky95x | https://wallhaven.cc/w/6ky95x |
| 9d7j8k | https://wallhaven.cc/w/9d7j8k |
| dgxkx3 | https://wallhaven.cc/w/dgxkx3 |
| kwy6ed | https://wallhaven.cc/w/kwy6ed |
| lq2x8p | https://wallhaven.cc/w/lq2x8p |
| zxpvqo | https://wallhaven.cc/w/zxpvqo |

## Neural

| ID | URL |
|---|---|
| 0w5exq | https://wallhaven.cc/w/0w5exq |
| 3k93lv | https://wallhaven.cc/w/3k93lv |
| 6q98kw | https://wallhaven.cc/w/6q98kw |
| 9d7j8k | https://wallhaven.cc/w/9d7j8k |
| j83ew5 | https://wallhaven.cc/w/j83ew5 |

## Phantom

| ID | URL |
|---|---|
| 3k93lv | https://wallhaven.cc/w/3k93lv |
| 9d7j8k | https://wallhaven.cc/w/9d7j8k |
| kwy6ed | https://wallhaven.cc/w/kwy6ed |

## Glass

Generated (not downloaded): `themeforge/wallpapers.sh glass <dir>` — soft blurred colour meshes via ImageMagick, run
automatically by `install.sh`. Files: `glass_dark.png` (default desktop), `glass_night.png` (lockscreen),
`glass_light.png`, `glass_vivid.png`.

## BlackArch

Generated: `themeforge/wallpapers.sh blackarch <dir>` — black with a faint Arch-blue radial glow, a dim wordmark for the
lockscreen (needs the Inter font; falls back to the glow), and a pure-black void.
Files: `blackarch_glow.png` (desktop), `blackarch_word.png` (lockscreen), `blackarch_void.png`.

## Entropy

| ID | URL |
|---|---|
| 0w5exq | https://wallhaven.cc/w/0w5exq |
| 3k93lv | https://wallhaven.cc/w/3k93lv |
| 5weox9 | https://wallhaven.cc/w/5weox9 |
| 6ky95x | https://wallhaven.cc/w/6ky95x |
| 9d7j8k | https://wallhaven.cc/w/9d7j8k |
| dgxkx3 | https://wallhaven.cc/w/dgxkx3 |
| kwy6ed | https://wallhaven.cc/w/kwy6ed |
| lq2x8p | https://wallhaven.cc/w/lq2x8p |
| zxpvqo | https://wallhaven.cc/w/zxpvqo |

---

## After downloading — set active wallpaper

```bash
# Set wall.set (active wallpaper for theme)
ln -sf ~/.config/hyde/themes/<Theme>/wallpapers/<file>.png \
       ~/.config/hyde/themes/<Theme>/wall.set

# Set lockscreen wallpaper (can be same or different)
ln -sf ~/.config/hyde/themes/<Theme>/wallpapers/<file>.png \
       ~/.config/hyde/themes/<Theme>/wall.hyprlock.png
```
