# 11 · CLI Tools

The supporting cast — the command-line programs that make the shell pleasant and
the desktop informative. Most are wired up in [`.zshrc`](05-zsh.md); this guide
covers what each is, why it's here, and where its config lives.

## The modern-Unix replacements

These swap classic tools for faster, prettier, git-aware modern equivalents. Wired
via aliases in `home/.zshrc`.

| Tool | Replaces | Alias | Config |
|---|---|---|---|
| **eza** | `ls` | `ls`/`ll`/`la`/`lt` | (flags in alias) |
| **zoxide** | `cd` | `cd` → `z` | learns paths automatically |
| **bat** | `cat`, man pager | `cat`, `MANPAGER` | — |
| **fd** | `find` | (used by fzf) | — |
| **ripgrep** | `grep` | `rg` | `--smart-case --hidden` |
| **fzf** | — (new) | `Ctrl-R`, `Ctrl-T` | `FZF_DEFAULT_COMMAND` |

- **eza** — `ls` with icons, colors, git status columns. `lt` gives a 2-level tree.
- **zoxide** — frecency-based `cd`. After visiting a dir a few times, `cd partial`
  jumps straight there from anywhere. ⚠️ must init *before* Starship in `.zshrc`,
  and `_ZO_DOCTOR=0` silences its "init last" nag (Starship has to be last).
- **bat** — `cat` with syntax highlighting and line numbers; also used as the man
  pager for colored man pages.
- **fd** — fast, `.gitignore`-aware `find`. Powers fzf's file search.
- **ripgrep (rg)** — fast recursive search; the alias adds smart-case, hidden
  files, and excludes `.git`.
- **fzf** — fuzzy finder. `Ctrl-R` fuzzy-searches shell history; `Ctrl-T` inserts a
  fuzzy-found file path. Backed by `fd` for speed.

## TUIs (full-screen terminal apps)

| Tool | Launch | Purpose |
|---|---|---|
| **lazygit** | `lg`, or `prefix g` in tmux, or `<leader>gg` in nvim | Git dashboard — stage, commit, branch, rebase visually |
| **lazydocker** | `ld` | Docker/compose dashboard — containers, logs, stats |
| **btop** | `btop`, or `Ctrl+Shift+Esc` in Hyprland | System monitor — CPU/mem/net/proc |

lazygit is reachable three ways (shell alias, tmux popup, nvim keymap) because it's
the primary git interface across the whole setup.

### btop config

`.config/btop/btop.conf`:

```ini
color_theme = "Default"      # or a wallbash theme for color matching
theme_background = true      # set false for terminal transparency to show through
```

⚠️ If you want btop to be transparent (showing kitty's translucency), set
`theme_background = false`. With it `true`, btop paints its own opaque background.

## fastfetch — the system info splash

`.config/fastfetch/config.jsonc` draws the ASCII/logo + system info panel (the
thing you run to show off your rice). HyDE provides presets under
`xdg/share/fastfetch/presets/hyde/`. This config:

- Uses a dynamic logo via `fastfetch.sh logo` (so it follows the theme).
- Custom `logo/` directory with several `.icon` art files (anime/themed logos).

Run plain `fastfetch`, or test a HyDE preset with `fastfetch --config hyde/*.jsonc`.

## How they fit together

```
            you type in →  Zsh + Starship
                              │
   ┌──────────────┬───────────┼───────────┬──────────────┐
   ▼              ▼           ▼           ▼              ▼
  eza/fd/rg     zoxide      fzf         bat          lazygit/btop
 (navigate &   (jump dirs) (fuzzy     (read files)  (TUIs)
  search)                   find)
```

None of these are HyDE-specific — they'd work on any Linux/macOS shell. They're the
portable, terminal-half of the rice, independent of Hyprland.

## Install (Arch)

```bash
sudo pacman -S eza zoxide bat fd ripgrep fzf btop fastfetch lazygit
# lazydocker: AUR (yay -S lazydocker) or its install script
```

🔗 eza https://eza.rocks · zoxide https://github.com/ajeetdsouza/zoxide ·
bat https://github.com/sharkdp/bat · fzf https://github.com/junegunn/fzf ·
lazygit https://github.com/jesseduffield/lazygit · btop https://github.com/aristocratos/btop
