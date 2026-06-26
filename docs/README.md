# Documentation

A complete, opinionated guide to this dotfiles ecosystem — what every layer does,
**why** it's configured the way it is, and how to change it without breaking things.

This is written to be read, not just referenced. If you're new to the setup (or
returning after months away), start at the top and work down.

## Reading order

| # | Guide | What it covers |
|---|-------|----------------|
| 00 | [Overview](00-overview.md) | The whole stack at a glance, the mental model, glossary |
| 01 | [Architecture & Install](01-architecture.md) | How the repo maps to your system: symlinks, `install.sh`, what's tracked vs generated |
| 02 | [Theming Pipeline](02-theming-pipeline.md) | HyDE, wallbash, how a wallpaper becomes a system-wide colorscheme |
| 03 | [Hyprland](03-hyprland.md) | The compositor — keybindings, window rules, workflows, monitors, animations |
| 04 | [Kitty](04-kitty.md) | The terminal emulator — fonts, opacity, the HyDE include chain |
| 05 | [Zsh](05-zsh.md) | The shell — Oh My Zsh, modern CLI replacements, tool init order |
| 06 | [Starship](06-starship.md) | The prompt — format strings, modules, the right-aligned git branch |
| 07 | [Tmux](07-tmux.md) | The multiplexer — prefix, panes, plugins, the Catppuccin v1.0 status bar |
| 08 | [Neovim / LazyVim](08-neovim.md) | The editor — keymap grammar, plugin specs, the VS Code dual-mode |
| 09 | [Waybar & Dunst](09-waybar-dunst.md) | The bar and notifications |
| 10 | [Firefox & Tridactyl](10-firefox.md) | Browser chrome CSS, vim-style browsing, the start page |
| 11 | [CLI Tools](11-cli-tools.md) | btop, fastfetch, eza, zoxide, fzf, bat, lazygit and friends |
| 12 | [Keybindings Cheat-Sheet](12-cheatsheet.md) | **Every shortcut** across Hyprland, tmux, nvim, tridactyl — in one place |

## The one rule that prevents 90% of problems

> **Edit files in `~/dotfiles/`, never the live copies in `~/.config/` or `~/`.**

The live files are *symlinks* pointing back here (created by `install.sh`). Editing
through the symlink is fine — it writes to this repo — but editing a file that
*replaced* a symlink, or a HyDE-*generated* file, gets silently overwritten. See
[01-architecture.md](01-architecture.md) for the full safe/unsafe map.

## Conventions used in these docs

- `inline code` = a literal command, filename, or config key.
- ⚠️ = a footgun. Read it before you touch the thing it's warning about.
- 🔗 = an upstream doc worth bookmarking.
- "**Why:**" blocks explain a non-obvious choice, so future-you doesn't undo it.
