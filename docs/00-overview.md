# 00 · Overview

## What this is

A personal Arch Linux desktop ("rice"), built on **Hyprland** (a Wayland tiling
compositor) and managed by **HyDE** (a configuration framework that sits on top of
Hyprland and gives you theming, a status bar, a launcher, and a wallpaper-driven
color system out of the box).

This repo (`~/dotfiles`) is the *source of truth* for the parts of that desktop
that are hand-tuned. A small `install.sh` symlinks these files into place.

## The mental model: independent layers

The single most useful idea for working on this setup is that it is **not one
thing**. It's a stack of independent programs, each with its own config language,
each replaceable without touching the others. When something looks wrong, the
first question is always *"which layer owns this?"*

```
┌─────────────────────────────────────────────────────────────────┐
│  Hyprland (compositor)   — windows, workspaces, blur, keybinds    │  ← the desktop itself
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Waybar (top bar)   Dunst (notifications)   Rofi (launcher)│  │  ← HyDE-managed UI
│  └───────────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Kitty (terminal window)                                   │  │  ← the terminal emulator
│  │  ┌─────────────────────────────────────────────────────┐  │  │
│  │  │  Tmux (multiplexer)  — tabs, panes, sessions         │  │  │  ← optional, runs inside kitty
│  │  │  ┌───────────────────────────────────────────────┐  │  │  │
│  │  │  │  Zsh (shell)  +  Starship (prompt)            │  │  │  │  ← what you type into
│  │  │  │  └─ runs nvim, lazygit, eza, btop, ...        │  │  │  │
│  │  │  └───────────────────────────────────────────────┘  │  │  │
│  │  └─────────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

A worked example: in the terminal screenshot that kicked off this setup, the
colored tab bar at the top is **tmux**, the blue path and green arrow is
**Starship**, the rounded translucent window is **kitty + Hyprland blur**, and the
little icons are a **Nerd Font**. Four layers, four configs. See
[07-tmux.md](07-tmux.md) and [06-starship.md](06-starship.md) for that exact build.

## The stack

| Layer | Tool | Config home | HyDE-managed? |
|---|---|---|---|
| Compositor | Hyprland | `.config/hypr/` | Partly (themes generated) |
| Framework | HyDE | `.config/hyde/` | This is HyDE itself |
| Bar | Waybar | `.config/waybar/user-style.css` | Mostly (only overrides tracked) |
| Notifications | Dunst | `.config/dunst/` | Colors via wallbash |
| Launcher | Rofi | (HyDE-provided) | Yes |
| Terminal | Kitty | `.config/kitty/kitty.conf` | Base + theme generated |
| Shell | Zsh + Oh My Zsh | `home/.zshrc` | No |
| Prompt | Starship | `.config/starship/starship.toml` | No |
| Multiplexer | Tmux + TPM | `home/.tmux.conf` | No |
| Editor | Neovim / LazyVim | `.config/nvim/` | No (own Catppuccin theme) |
| Monitor | Btop | `.config/btop/btop.conf` | Colors via wallbash |
| Fetch | Fastfetch | `.config/fastfetch/` | No |
| Browser | Firefox Dev + Tridactyl | `.config/firefox/`, `.config/tridactyl/` | Colors via wallbash |

## Glossary

- **rice** — slang for an aesthetically customized desktop (from "race inspired
  cosmetic enhancements"). To "rice" is to customize appearance.
- **compositor** — the program that draws windows on a Wayland desktop. Hyprland is
  both the compositor *and* the window manager (it tiles/floats windows).
- **HyDE** — *Hyprland Desktop Environment*. A batteries-included config layer for
  Hyprland. Provides `hyde-shell` (a CLI dispatcher), theming, wallbash, and
  sensible defaults. 🔗 https://hydeproject.pages.dev
- **wallbash** — HyDE's engine that extracts a color palette from the current
  wallpaper and regenerates every app's colors to match. See
  [02-theming-pipeline.md](02-theming-pipeline.md).
- **Nerd Font** — a normal font patched to include thousands of extra icon glyphs
  (file-type icons, the git branch symbol, powerline separators). Required for the
  prompt and bar to render icons instead of boxes.
- **symlink** — a file that's really a pointer to another file. `install.sh` makes
  `~/.config/foo` a symlink to `~/dotfiles/.config/foo`, so editing either edits
  the same underlying file. See [01-architecture.md](01-architecture.md).
- **TPM** — *Tmux Plugin Manager*. Installs tmux plugins listed in `.tmux.conf`.
- **LazyVim** — a Neovim distribution: a curated set of plugins and defaults you
  extend, rather than configuring Neovim from scratch.

## Where to go next

- Want to understand how the repo becomes a working system? → [01-architecture.md](01-architecture.md)
- Want to know how colors propagate from a wallpaper? → [02-theming-pipeline.md](02-theming-pipeline.md)
- Want to fix or tweak one specific app? → jump to its numbered guide.
