# 07 · Tmux (multiplexer)

Tmux runs *inside* kitty and gives you tabs (windows), splits (panes), and
**persistent sessions** that survive closing the terminal or even a reboot. The
colored bar at the top of the reference screenshot — the `worktrunk / tmux / nu`
pills — is tmux, not the terminal.

File: `home/.tmux.conf` (symlinked to `~/.tmux.conf`).

## Core concepts in 30 seconds

- **Session** — a workspace of windows. Detach (`prefix d`) and it keeps running;
  re-attach later (`tmux a`) exactly where you left off.
- **Window** — like a browser tab. Each fills the screen.
- **Pane** — a split within a window.
- **Prefix** — the key you press *before* a tmux command. Default is `Ctrl+b`;
  **this config rebinds it to `Ctrl+Space`.**

## The prefix and the modifier-ownership model

```ini
set -g prefix C-Space      # Ctrl+Space is the tmux prefix
unbind C-b
```

This config deliberately coordinates keys with Hyprland and Neovim so nothing
fights:

| Modifier | Owner | Used for |
|---|---|---|
| `Super` (Win) | Hyprland | Window/workspace management |
| `Ctrl+h/j/k/l` | vim-tmux-navigator | Seamless nav between tmux panes *and* nvim splits |
| `Ctrl+Space` | tmux | The tmux prefix |
| `Alt+…` | apps | App-local shortcuts |

The `Ctrl+h/j/k/l` magic comes from the **vim-tmux-navigator** plugin (here and in
[Neovim](08-neovim.md)): one keystroke moves between a tmux pane and a Neovim split
transparently, as if they were the same thing.

## Settings worth knowing

```ini
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"   # true color (critical for themes)
set -g base-index 1                # windows start at 1, not 0
set -g pane-base-index 1
set -g renumber-windows on         # close a window, the rest renumber
set -g status-position top         # bar at the top (like the screenshot)
set -g mouse on                    # click panes, drag to resize, scroll
set -g history-limit 50000
set -sg escape-time 0              # no delay after Esc (important for nvim)
set -g mode-keys vi                # vi keys in copy mode
```

## Keybindings (prefix = `Ctrl+Space`)

**Splits & windows**

| Keys | Action |
|---|---|
| `prefix v` | Split vertical (side by side) |
| `prefix s` | Split horizontal (stacked) |
| `prefix c` | New window (in current dir) |
| `prefix n` / `prefix p` | Next / previous window |
| `prefix Tab` | Last window |
| `prefix H/J/K/L` | Resize pane (repeatable) |
| `prefix >` / `<` | Swap pane forward / back |
| `prefix r` | Reload config + flash "Config reloaded!" |

**Copy mode (vi + Wayland clipboard)**

| Keys | Action |
|---|---|
| `prefix Enter` | Enter copy mode |
| `v` / `V` / `Ctrl+v` | Begin / line / block selection |
| `y` | Copy to system clipboard (via `wl-copy`) |
| `Escape` | Cancel |

Copy uses `wl-copy` because this is Wayland — the X11 clipboard tools don't work.

**Sessions**

| Keys | Action |
|---|---|
| `prefix N` | New named session |
| `prefix K` | Kill session (confirm) |
| `prefix (` / `)` | Previous / next session |
| `prefix o` | **sessionx** fuzzy session switcher (see plugins) |

**Popups**

| Keys | Action |
|---|---|
| `prefix g` | lazygit in a 90% popup |
| `prefix f` | a shell in a 90% popup |

## Plugins (via TPM)

Listed in `.tmux.conf`, installed with `prefix + I`:

| Plugin | Purpose |
|---|---|
| **tpm** | The plugin manager itself |
| **tmux-sensible** | Sane universal defaults |
| **vim-tmux-navigator** | `Ctrl+hjkl` nav across tmux panes + nvim splits |
| **tmux-resurrect** | Save/restore sessions manually |
| **tmux-continuum** | Auto-save sessions (restore is off by default) |
| **catppuccin/tmux** | The themed status bar |
| **omerxx/tmux-sessionx** | Fuzzy session manager (`prefix o`) |

Bootstrap TPM on a fresh machine:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# then inside tmux: prefix + I
```

### sessionx (the reference screenshot's namesake)

`omerxx/tmux-sessionx` is the fuzzy session/worktree switcher. Config:

```ini
set -g @sessionx-bind 'o'              # prefix o opens it
set -g @sessionx-zoxide-mode 'on'      # jump to dirs via zoxide
set -g @sessionx-preview-enabled 'true'
```

## ⚠️ The Catppuccin v1.0 migration (important)

The installed `catppuccin/tmux` is **v1.0+**, which changed the entire API from
v0.x. The two are incompatible, and using old syntax silently breaks the bar.

**What changed:**

- **v0.x:** you set `@catppuccin_status_modules_right "session date_time"` and the
  plugin *built the whole bar for you*.
- **v1.0:** you run the plugin, then **assemble the bar yourself** by appending
  pre-styled module variables to `status-left` / `status-right`.

**The config (correct v1.0 form):**

```ini
# 1. Options BEFORE the plugin loads (before `run tpm`):
set -g @catppuccin_flavor 'mocha'
set -g @catppuccin_window_status_style "rounded"     # the soft pill edges
set -g @catppuccin_window_number_position "right"
set -g @catppuccin_status_background "default"        # transparent bar

# 2. Load plugins:
run '~/.tmux/plugins/tpm/tpm'

# 3. Assemble the bar AFTER the plugin loaded:
set -gF status-left  "#{E:@catppuccin_status_session}"
set -g  @catppuccin_date_time_text " %H:%M"
set -agF status-right "#{E:@catppuccin_status_directory}"
set -agF status-right "#{E:@catppuccin_status_date_time}"
```

### The `-F` flag is the whole trick

⚠️ Every line that references a `#{E:@catppuccin_status_*}` variable **must use the
`-F` flag** (`set -gF`, `set -agF`):

- `-a` = append (don't replace what's there)
- `-g` = global
- `-F` = **expand the `#{}` format now**

Without `-F`, tmux stores the literal text `#{E:@catppuccin_status_session}` and you
see that garbage in the bar instead of a styled session name. This was the exact
bug hit (twice) while building this config — once for `status-left`, once for
`status-right`. If your bar shows literal `#{...}`, a missing `-F` is why.

Also: module *text* options (like `@catppuccin_date_time_text`) must be set
**before** the module is referenced in `status-right`, or the text won't apply.

## Applying changes

```bash
tmux source ~/.tmux.conf      # or:  prefix r
```

If the Catppuccin bar still looks wrong after sourcing (v1.0 modules sometimes only
fully apply on a fresh server):

```bash
tmux kill-server              # ⚠️ closes ALL sessions — save work first
tmux                          # fresh start
```

## Testing config safely (no risk to running sessions)

```bash
# Spin up a throwaway server on a private socket:
tmux -L test new-session -d -x 200 -y 50
tmux -L test source-file ~/.tmux.conf       # watch for errors
tmux -L test display-message -p "#{status-right}"   # did it expand?
tmux -L test kill-server                    # clean up
```

🔗 Catppuccin tmux v1.0: https://github.com/catppuccin/tmux
🔗 sessionx: https://github.com/omerxx/tmux-sessionx
