#!/usr/bin/env bash
# Dotfiles installer — creates symlinks from this repo into ~/.config and ~/
# Safe to re-run: backs up anything it would overwrite.

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CFG="$HOME/.config"
BK="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BOLD='\033[1m'; NC='\033[0m'
ok()  { printf "${GREEN}✓${NC}  %s\n" "$1"; }
bk()  { printf "${YELLOW}→${NC}  backed up: %s\n" "$1"; }
hdr() { printf "\n${BOLD}%s${NC}\n" "$1"; }
warn() { printf "${YELLOW}!${NC}  %s\n" "$1"; }
warn() { printf "${YELLOW}!${NC}  %s\n" "$1"; }

# Link src → dst, backing up anything in the way
link() {
    local src="$1" dst="$2"

    # Already pointing to the right place
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        ok "already linked: ${dst/$HOME/~}"; return
    fi

    # Backup existing file or directory
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        local rel="${dst#$HOME/}"
        mkdir -p "$BK/$(dirname "$rel")"
        mv "$dst" "$BK/$rel"
        bk "${dst/$HOME/~}"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    ok "${dst/$HOME/~}"
}

# ── Preflight ──────────────────────────────────────────────────────────────
hdr "Dotfiles — Imad-Oute/dotfiles"
echo "  Repo:   $DOTFILES"
echo "  Config: $CFG"

if ! command -v hyde-shell &>/dev/null; then
    printf "\n${YELLOW}Warning:${NC} HyDE not detected. Install HyDE first, then re-run.\n"
    printf "  → https://github.com/HyDE-Project/HyDE\n\n"
fi

# ── Hyprland ───────────────────────────────────────────────────────────────
hdr "Hyprland"
link "$DOTFILES/.config/hypr"           "$CFG/hypr"

# ── HyDE ───────────────────────────────────────────────────────────────────
hdr "HyDE"
link "$DOTFILES/.config/hyde/config.toml" "$CFG/hyde/config.toml"
# Themes must be real directories (HyDE's scanner uses find -type d, skips symlinks)
for theme in "Claude Dark" "Neural" "Phantom" "Entropy"; do
    mkdir -p "$CFG/hyde/themes/$theme"
    for f in hypr.theme waybar.theme rofi.theme kitty.theme; do
        link "$DOTFILES/.config/hyde/themes/$theme/$f" "$CFG/hyde/themes/$theme/$f"
    done
    # Wallpapers live in the dotfiles repo; symlink the dir in
    link "$DOTFILES/.config/hyde/themes/$theme/wallpapers" "$CFG/hyde/themes/$theme/wallpapers"
    ok "theme: $theme"
done

# ── Waybar ─────────────────────────────────────────────────────────────────
hdr "Waybar"
link "$DOTFILES/.config/waybar/user-style.css" "$CFG/waybar/user-style.css"

# ── Terminal ───────────────────────────────────────────────────────────────
hdr "Kitty"
link "$DOTFILES/.config/kitty/kitty.conf" "$CFG/kitty/kitty.conf"

# ── Editor ─────────────────────────────────────────────────────────────────
hdr "Neovim"
link "$DOTFILES/.config/nvim"             "$CFG/nvim"

# ── Shell ──────────────────────────────────────────────────────────────────
hdr "Shell + Prompt"
link "$DOTFILES/home/.zshrc"             "$HOME/.zshrc"
link "$DOTFILES/.config/starship"        "$CFG/starship"

# ── Multiplexer ────────────────────────────────────────────────────────────
hdr "Tmux"
link "$DOTFILES/home/.tmux.conf"         "$HOME/.tmux.conf"

# ── Tools ──────────────────────────────────────────────────────────────────
hdr "CLI Tools"
link "$DOTFILES/.config/btop/btop.conf"  "$CFG/btop/btop.conf"
link "$DOTFILES/.config/fastfetch"       "$CFG/fastfetch"
link "$DOTFILES/.config/dunst"           "$CFG/dunst"

# ── Firefox Dev Edition ────────────────────────────────────────────────────
hdr "Firefox Dev Edition"
FFDEV=""
for firefox_root in "${XDG_CONFIG_HOME:-$HOME/.config}/mozilla/firefox" "$HOME/.mozilla/firefox"; do
    [ -d "$firefox_root" ] || continue
    FFDEV=$(find "$firefox_root" -maxdepth 1 -name "*.dev-edition-default" -type d -print -quit)
    [ -n "$FFDEV" ] && break
done
if [ -n "$FFDEV" ]; then
    mkdir -p "$FFDEV/chrome"
    link "$DOTFILES/.config/firefox/chrome/userChrome.css"  "$FFDEV/chrome/userChrome.css"
    link "$DOTFILES/.config/firefox/chrome/userContent.css" "$FFDEV/chrome/userContent.css"
    link "$DOTFILES/.config/firefox/user.js"                "$FFDEV/user.js"
    ok "Firefox profile: $FFDEV"
else
    warn "Firefox Dev Edition profile not found — skipping"
fi
link "$DOTFILES/.config/hyde/wallbash/always/firefox.dcol" \
     "$CFG/hyde/wallbash/always/firefox.dcol"

# ── themeforge (Glass + BlackArch) ────────────────────────────────────────
# Everything for these two themes is GENERATED from themeforge/tokens/*.toml:
#   HyDE theme dirs (real copies), GTK3/4, Kvantum/Qt, rofi, kitty, tmux, waybar, lockscreen, VS Code extension, wallpapers.
hdr "themeforge (Glass, BlackArch)"
if command -v python3 &>/dev/null && python3 -c 'import tomllib' 2>/dev/null; then
    command -v magick &>/dev/null || warn "ImageMagick not found — wallpapers will be skipped (pacman -S imagemagick)"
    command -v code   &>/dev/null || warn "VS Code ('code') not found — VS Code themes will be skipped"
    python3 "$DOTFILES/themeforge/forge.py" install all && ok "themes built + installed"
else
    warn "python3 >= 3.11 required for themeforge — skipping"
fi
# hand-written parts that live in this repo and are linked, not generated
mkdir -p "$CFG/hyde/wallbash/always"
link "$DOTFILES/.config/hyde/wallbash/always/themeforge-nvim.dcol" "$CFG/hyde/wallbash/always/themeforge-nvim.dcol"
mkdir -p "$CFG/tmux"   # tmux sources ~/.config/tmux/theme.conf (written on theme switch)
if [ -r "$HOME/.local/state/hyde/staterc" ] && ! grep -q '^enableWallDcol="0"' "$HOME/.local/state/hyde/staterc"; then
    warn "wallbash mode is not 'theme' — HyDE will ignore Glass/BlackArch's own colours."
    warn "  fix: sed -i 's/^enableWallDcol=.*/enableWallDcol=\"0\"/' ~/.local/state/hyde/staterc   (then pick the theme)"
fi

# ── Post-install ───────────────────────────────────────────────────────────
printf "\n${GREEN}${BOLD}Done.${NC}\n"
printf "\nNext steps:\n"
printf "  1. hyprctl reload\n"
printf "  2. Super+Shift+T  → pick Glass or BlackArch (wallbash mode must be \"theme\")\n"
printf "  3. Glass/BlackArch wallpapers are generated; other themes: add wallpapers (see wallpapers.md)\n"
printf "  4. Install tmux plugins: tmux then prefix + I\n"
printf "  5. Firefox: install Tree Style Tab, restart Firefox\n"
printf "     paste tst.css from dotfiles/.config/firefox/tst.css into TST prefs\n\n"
