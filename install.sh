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
for theme in "Claude Dark" "Neural" "Phantom" "Entropy"; do
    link "$DOTFILES/.config/hyde/themes/$theme" "$CFG/hyde/themes/$theme"
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

# ── Post-install ───────────────────────────────────────────────────────────
printf "\n${GREEN}${BOLD}Done.${NC}\n"
printf "\nNext steps:\n"
printf "  1. hyprctl reload\n"
printf "  2. Super+Shift+T  → pick a theme\n"
printf "  3. Add wallpapers to ~/.config/hyde/themes/<Theme>/wallpapers/\n"
printf "     then: ln -sf <wallpaper> ~/.config/hyde/themes/<Theme>/wall.set\n"
printf "  4. Install tmux plugins: tmux then prefix + I\n"
printf "\nNeovim is managed separately:\n"
printf "  → https://github.com/Imad-Oute/nvim  (set up your own fork)\n\n"
