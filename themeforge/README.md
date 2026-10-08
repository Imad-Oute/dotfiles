# themeforge

Renders complete HyDE themes from one token file each.

    python3 forge.py install all      # build + deploy every theme in tokens/
    python3 forge.py build glass      # build only (into build/<Name>/, gitignored)
    hyde-shell theme.switch.sh -s Glass

Themes: `Glass` (translucent material) and `BlackArch` (flat OLED). Edit `tokens/*.toml`, re-run, done.

## Modes (HyDE wallbash toggle)
- **theme** (`enableWallDcol=0`): the designed palette (`theme.dcol`) + all generated files.
- **auto / dark / light**: wallbash derives colours from the wallpaper. Kept in every mode: Hyprland material,
  GTK3/4 theme (imports the live wallbash palette), lockscreen layout (uses `$wallbash_*`).
  Only in theme mode: Waybar/kitty/rofi/tmux/Kvantum files (HyDE only deploys `*.theme` then).

## Editors & launcher
- **Neovim** (tracked in `../.config/nvim`: `colors/glass.lua`, `lua/themeforge/`): palette = HyDE's live wallbash file
  (`~/.cache/hyde/wallbash/nvim.json`, written by `always/themeforge-nvim.dcol` on every switch), so it follows the
  active HyDE theme *and* mode, and hot-reloads in open editors. Falls back to Glass colours. LazyVim loads it via
  `lua/plugins/theme.lua` (`colorscheme = "glass"`; set back to `catppuccin` to revert).
- **VS Code**: one generated extension per theme (`themeforge.themeforge-<slug>`); `vscode.theme` hook selects it on
  switch (theme mode only). Static palette from the tokens.
- **Rofi launcher**: `~/.local/share/rofi/themes/glass.rasi`, selected via `rofiStyle="glass"` in HyDE's staterc.
  Radii follow HyDE's rounding; flat themes set `glass-r-*` to 0 in `rofi.theme`.

## Layers generated
hypr.theme · kitty.theme · rofi.theme · waybar.theme · tmux.theme · theme.dcol · kvantum/ (recoloured KvCurves) ·
gtk/ (GTK3 + GTK4) · hyprlock layout (`~/.config/hypr/hyprlock/<Name>.conf`).

## HyDE quirks this works around
- `~/.config/hyde/themes/<Name>/` must be a real dir with real file copies (HyDE uses `find -H`, which ignores
  symlinks inside it). Only `wallpapers/` is a symlink.
- Wallbash mode >0 ignores a theme's own `*.theme` files entirely.
- Select the lockscreen in HyDE's hyprlock picker (layout name = theme name).

## Repo layout
    tokens/*.toml        the only things you edit (palette, glass, shape, motion per theme)
    templates/           hypr/kitty/rofi/waybar/tmux/vscode .theme templates, gtk/, hyprlock/, rofi/glass.rasi, bin/
    forge.py             renderer + installer      vscode_theme.py   VS Code theme + .vsix builder
    wallpapers.sh        ImageMagick wallpaper recipes (wallpapers are not committed)
    build/               generated, gitignored
Set `THEMEFORGE_SKIP_VSCODE=1` to skip the VS Code extension install (CI / dry runs).

## Your own wallpapers
Drop images into `~/.config/hyde/themes/<Theme>/wallpapers/` (a real folder; the installer only ever adds its generated
files there and never removes or overwrites yours, and keeps your chosen `wall.set`). HyDE's selector (`Super+Shift+W`)
lists that folder; the installer pre-builds the thumbnails it needs. Your own wallpapers are not in git.
`~/.config/hypr/userprefs.conf` pins `ROFI_WALLPAPER_COLUMN_COUNT=4`: without it HyDE computes ~468 columns when the
monitor scale is exactly 1 and the selector shows nothing.
