# 05 · Zsh (shell)

Zsh is the shell — the program that reads what you type, runs commands, and manages
aliases, history, and completions. This config is built on **Oh My Zsh** (a zsh
framework) with the prompt handed off to **Starship** (see [06-starship.md](06-starship.md))
and a suite of modern CLI tools replacing the classic Unix ones.

File: `home/.zshrc` (symlinked to `~/.zshrc`).

## Structure of .zshrc, top to bottom

1. **Oh My Zsh setup** — `ZSH` path, theme, plugins, then `source oh-my-zsh.sh`.
2. **PATH + env** — adds `~/.local/bin`.
3. **DevOS Productivity Ecosystem** — the modern-CLI block (the interesting part).
4. **Tail** — local secrets, Homebrew, NVM, and finally Starship.

### Oh My Zsh, with the theme disabled

```zsh
ZSH_THEME=""          # ← empty ON PURPOSE: Starship owns the prompt
plugins=(git)
source $ZSH/oh-my-zsh.sh
```

**Why `ZSH_THEME=""`:** Oh My Zsh ships its own prompt themes
(`robbyrussell`, etc.). If one is set, it competes with Starship. Setting it empty
lets Starship — initialized last — cleanly own the prompt. We keep OMZ around only
for its `git` plugin aliases and completion system.

## The modern CLI stack ("DevOS")

This is the block that makes the shell pleasant. Each line replaces a classic tool
with a faster, prettier, git-aware modern one:

| Alias / init | Tool | Replaces | What you get |
|---|---|---|---|
| `eval "$(zoxide init zsh)"`, `cd → z` | **zoxide** | `cd` | Jump to frequent dirs: `cd proj` finds it anywhere |
| `ls`/`ll`/`la`/`lt` → `eza …` | **eza** | `ls` | Icons, git status, tree view (`lt`) |
| `source <(fzf --zsh)` | **fzf** | — | `Ctrl-R` history search, `Ctrl-T` file search |
| `cat → bat -p`, `MANPAGER=bat` | **bat** | `cat` / man | Syntax highlighting in cat and man pages |
| `lg → lazygit`, `ld → lazydocker` | **lazygit/lazydocker** | git/docker CLI | TUI dashboards |
| `vi`/`v → nvim` | **neovim** | vi | The editor (see [08-neovim.md](08-neovim.md)) |
| `rg = rg --smart-case --hidden …` | **ripgrep** | grep | Fast recursive search, ignores `.git` |
| `dps` | docker | — | Pretty `docker ps` table |

`FZF_DEFAULT_COMMAND` is set to use **fd** (`fd --type f --hidden …`) so fuzzy file
search is fast and respects `.gitignore`.

## ⚠️ Init ordering matters

The bottom of `.zshrc` is order-sensitive:

```zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local   # machine-local secrets (gitignored)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"   # Homebrew
export NVM_DIR="$HOME/.config/nvm"; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # Node

# Starship MUST be last so it owns the prompt
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
```

Two things to know:

- **`STARSHIP_CONFIG` is set explicitly.** Starship's default config path is
  `~/.config/starship.toml` (a *file*), but this repo keeps it at
  `~/.config/starship/starship.toml` (a *directory*, symlinked from dotfiles).
  Without `STARSHIP_CONFIG` pointing there, Starship would silently use its
  built-in defaults. This is the single most common "why is my prompt plain?" bug.
- **`_ZO_DOCTOR=0`** is exported near the zoxide init. zoxide warns "initialize me
  last," but Starship has to be last instead. The two are compatible in practice;
  this just silences zoxide's (inapplicable) nag.

## Secrets: ~/.zshrc.local

API keys and machine-specific values go in `~/.zshrc.local`, which is **gitignored**
and sourced if present. Never put secrets directly in `.zshrc` (it's public on
GitHub).

## Common tasks

**"Add an alias."** Put it in the DevOS block of `home/.zshrc`, then `exec zsh`.

**"My prompt is the boring default."** → `STARSHIP_CONFIG` isn't set or starship
isn't initialized. Check the tail of `.zshrc` (see above) and `exec zsh`.

**"A tool isn't found."** Check it's installed (`command -v <tool>`) — the aliases
assume eza/zoxide/fzf/bat/fd/ripgrep/lazygit are present. Install list is in
[01-architecture.md](01-architecture.md#fresh-machine-bootstrap).

**"Reload the shell."** `exec zsh` (replaces the current shell with a fresh one).
