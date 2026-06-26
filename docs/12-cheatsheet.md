# 12 · Keybindings Cheat-Sheet

Every shortcut across the whole setup, in one place. Print it, pin it, or just
`Super+/` for the live Hyprland overlay.

Four layers own keys, and they're deliberately coordinated so nothing clashes —
see [Modifier ownership](#modifier-ownership) at the bottom for *why* this works.

**Symbols:** `Super` = Windows/meta key · `prefix` = `Ctrl+Space` (tmux) ·
`<leader>` = `Space` (Neovim).

---

## Hyprland (desktop / window manager)

### Windows

| Keys | Action |
|---|---|
| `Super+Q` / `Alt+F4` | Close window |
| `Super+W` | Toggle floating |
| `Super+G` | Toggle group (tabbed windows) |
| `Super+J` | Toggle split direction |
| `Shift+F11` | Toggle fullscreen |
| `Super+Shift+F` | Pin window on top |
| `Super+←/→/↑/↓` | Move focus |
| `Alt+Tab` | Cycle focus |
| `Super+Ctrl+H/L` | Switch active window in group |
| `Super+Shift+←/→/↑/↓` | Resize window |
| `Super+Shift+Ctrl+←/→/↑/↓` | Move window (nudge if floating) |
| `Super+Z` (hold) | Move window with mouse |
| `Super+X` (hold) | Resize window with mouse |

### Workspaces

| Keys | Action |
|---|---|
| `Super+1…0` | Go to workspace 1–10 |
| `Super+Shift+1…0` | Move window to workspace |
| `Super+Alt+1…0` | Move window to workspace (silent — stay) |
| `Super+Ctrl+←/→` | Prev/next workspace (relative) |
| `Super+Ctrl+↓` | Nearest empty workspace |
| `Super+scroll` | Cycle workspaces |
| `Super+S` | Toggle scratchpad |
| `Super+Shift+S` / `Super+Alt+S` | Move to scratchpad / silently |

### Launchers & apps

| Keys | Action |
|---|---|
| `Super+T` | Terminal (kitty) |
| `Super+Alt+T` | Dropdown terminal (pyprland) |
| `Super+E` | File explorer (dolphin) |
| `Super+C` | Editor (code) |
| `Super+B` | Browser (firefox) |
| `Super+A` | App finder (rofi) |
| `Super+Tab` | Window switcher (rofi) |
| `Super+Shift+E` | File finder (rofi) |
| `Super+/` | **Keybindings cheat-sheet (live)** |
| `Super+,` / `Super+.` | Emoji / glyph picker |
| `Super+V` / `Super+Shift+V` | Clipboard / clipboard manager |
| `Ctrl+Shift+Esc` | System monitor (btop) |

### Screen capture

| Keys | Action |
|---|---|
| `Super+P` | Snip region |
| `Super+Ctrl+P` | Freeze + snip |
| `Super+Alt+P` | Capture this monitor |
| `Print` | Capture all monitors |
| `Super+Shift+P` | Color picker (hex → clipboard) |

### Theming / rice → [theming pipeline](02-theming-pipeline.md)

| Keys | Action |
|---|---|
| `Super+Shift+T` | Theme selector |
| `Super+Shift+W` | Wallpaper selector |
| `Super+Alt+→/←` | Next / prev wallpaper |
| `Super+Alt+↑/↓` | Next / prev Waybar layout |
| `Super+Shift+R` | Wallbash mode selector |
| `Super+Shift+Y` | Animation selector |
| `Super+Shift+U` | Hyprlock layout selector |

### Session / power

| Keys | Action |
|---|---|
| `Super+L` | Lock screen |
| `Super+Delete` | Kill Hyprland session |
| `Ctrl+Alt+Delete` | Logout menu |
| `Super+Alt+G` / `Super+Shift+G` | Game mode / game launcher |
| `Super+K` | Toggle keyboard layout |
| `Alt_R+Ctrl_R` | Toggle Waybar |
| `F10` / `F11` / `F12` | Mute / volume down / up |
| `XF86 Brightness ↑/↓` | Brightness |

---

## Tmux (multiplexer) — `prefix` = `Ctrl+Space`

### Panes & windows

| Keys | Action |
|---|---|
| `prefix v` | Split vertical (side by side) |
| `prefix s` | Split horizontal (stacked) |
| `prefix c` | New window |
| `prefix n` / `prefix p` | Next / prev window |
| `prefix Tab` | Last window |
| `prefix H/J/K/L` | Resize pane (repeatable) |
| `prefix >` / `prefix <` | Swap pane forward / back |
| `prefix r` | Reload config |
| `Ctrl+h/j/k/l` | **Move between panes** (also crosses into nvim — see below) |

### Sessions

| Keys | Action |
|---|---|
| `prefix d` | Detach (session keeps running) |
| `prefix o` | sessionx fuzzy switcher |
| `prefix N` | New named session |
| `prefix K` | Kill session (confirm) |
| `prefix (` / `prefix )` | Prev / next session |

### Copy mode (vi)

| Keys | Action |
|---|---|
| `prefix Enter` | Enter copy mode |
| `v` / `V` / `Ctrl+v` | Begin / line / block selection |
| `y` | Copy to clipboard (`wl-copy`) |
| `H` / `L` | Start / end of line |
| `Escape` | Cancel |

### Popups

| Keys | Action |
|---|---|
| `prefix g` | lazygit (90% popup) |
| `prefix f` | shell (90% popup) |

---

## Neovim / LazyVim — `<leader>` = `Space`

### Leader namespaces (learn the prefix, discover the rest)

| Prefix | Domain |
|---|---|
| `<leader>f` | **Find** — files, grep, recent, buffers |
| `<leader>g` | **Git** — lazygit, fugitive, diff, hunks |
| `<leader>c` | **Code** — LSP actions, rename, format |
| `<leader>d` | **Debug** — DAP breakpoints, run, step |
| `<leader>t` | **Test** — neotest |
| `<leader>x` | **Diagnostics** — trouble, quickfix |
| `<leader>h` | **Harpoon** + git hunks |
| `<leader>u` | **UI** toggles |
| `<leader>w` / `b` / `q` | Windows / Buffers / Quit |

### Custom maps (this config's additions)

| Keys | Mode | Action |
|---|---|---|
| `jk` | insert | Exit to normal mode |
| `Ctrl+d` / `Ctrl+u` | normal | Half-page jump (stays centered) |
| `n` / `N` | normal | Next/prev search result (centered) |
| `J` (in visual) | visual | Move selected lines down |
| `K` (in visual) | visual | Move selected lines up |
| `p` (in visual) | visual | Paste without clobbering register |
| `<leader>y` / `<leader>Y` | n/v | Yank to system clipboard |
| `<leader>D` | n/v | Delete to void register |
| `<leader>rw` | normal | Rename word-under-cursor in file |
| `<leader>cx` | normal | `chmod +x` current file |
| `Esc` | normal | Clear search highlight |

### Harpoon (terminal nvim only — not VS Code)

| Keys | Action |
|---|---|
| `<leader>H` | Harpoon menu |
| `<leader>ha` | Add file to harpoon |
| `Alt+1…4` | Jump to harpoon mark 1–4 |
| `[H` / `]H` | Prev / next harpoon mark |

### Windows / splits

| Keys | Action |
|---|---|
| `<leader>we` | Equalize splits |
| `Ctrl+↑/↓` | Grow / shrink height |
| `Ctrl+←/→` | Shrink / grow width |
| `Ctrl+h/j/k/l` | **Move between splits** (crosses into tmux) |

### Navigation: quickfix / loclist / folds

| Keys | Action |
|---|---|
| `]q` / `[q` | Next / prev quickfix |
| `]Q` / `[Q` | Last / first quickfix |
| `]l` / `[l` | Next / prev loclist |
| `zR` / `zM` | Open / close all folds |

### Git (fugitive — terminal nvim only)

| Keys | Action |
|---|---|
| `<leader>gf` | Fugitive status (interactive stage) |
| `<leader>gd` | Git diff split |
| `<leader>gL` | File git history |
| `<leader>gW` / `<leader>gR` | Stage (write) / checkout (read) file |

### Other

| Keys | Action |
|---|---|
| `<leader>uu` | Undotree toggle |
| `<leader>a` | Aerial symbol outline |
| `Ctrl+\` / `<leader>ft` | Floating terminal (snacks) |

---

## Tridactyl (Firefox) — Vim in the browser

### Scrolling & navigation

| Keys | Action |
|---|---|
| `j` / `k` | Scroll down / up (5 lines) |
| `d` / `u` | Half page down / up |
| `gg` / `G` | Top / bottom of page |
| `H` / `L` | Back / forward (history) |
| `r` / `R` | Reload / hard reload |

### Tabs

| Keys | Action |
|---|---|
| `J` / `K` | Next / prev tab |
| `x` | Close tab |
| `u` | Undo close tab |
| `t` / `T` | New tab (URL bar) / current URL in new tab |
| `b` | Fuzzy-search open tabs |

### Opening URLs

| Keys | Action |
|---|---|
| `o` / `s` | Open URL (same tab) |
| `O` / `S` | Open URL (new tab) |

### Hints (click without a mouse)

| Keys | Action |
|---|---|
| `f` | Hint links → same tab |
| `F` | Hint links → new tab |
| `gi` | Focus first input on page |

### Clipboard & find

| Keys | Action |
|---|---|
| `yy` / `yt` | Yank URL / page title |
| `p` / `P` | Open clipboard URL (same / new tab) |
| `/` `n` `N` | Find / next / prev |
| `zi` / `zo` / `z=` | Zoom in / out / reset |

### Tree Style Tab

| Keys | Action |
|---|---|
| `>` / `<` | Expand / collapse current tree |
| `]]` / `[[` | Indent (child) / outdent (promote) |
| `Alt+j` / `Alt+k` | Next / prev sibling |
| `Alt+p` / `Alt+c` | Jump to parent / first child |
| `Alt+z` | Collapse all except current |
| `Alt+b` | Toggle TST sidebar |

### Misc

| Keys | Action |
|---|---|
| `jk` | Escape insert → normal mode |
| `Space` | Passthrough next key to page |
| `Alt+r` / `Alt+m` | Reader mode / mute tab |
| `Alt+s` | Reload tridactylrc |

---

## Modifier ownership

The reason all four layers coexist without fighting: each *modifier* is owned by
exactly one layer, so the same letter means different things in different contexts
without ambiguity.

| Modifier | Owner | Scope |
|---|---|---|
| `Super` (Win) | **Hyprland** | Always — window/workspace/launcher control |
| `Ctrl+Space` | **tmux** | The tmux prefix |
| `Ctrl+h/j/k/l` | **vim-tmux-navigator** | Shared by tmux + nvim — moves between panes *and* splits as if one surface |
| `<leader>` (Space) | **Neovim** | Inside nvim only |
| `Alt+…` | **apps** | App-local (tridactyl TST, harpoon jumps, dropdown term) |

### The one trick worth understanding: `Ctrl+h/j/k/l`

This is the same key in both tmux (`07-tmux.md`) and Neovim (`08-neovim.md`), and
that's intentional. The **vim-tmux-navigator** plugin runs in both. When you press
`Ctrl+l`, it checks: "is the thing to my right a Neovim split or a tmux pane?" and
moves there either way. So a terminal full of tmux panes and nvim splits behaves
like one seamless grid — you never think about the boundary.

### Deliberate "collisions" that aren't

The same letter appears in multiple layers but never actually conflicts, because
you're only ever inside one context:

- `J`/`K` = move-lines in nvim, but next/prev-tab in tridactyl, but resize-pane
  (with prefix) in tmux. Different apps, different focus.
- `Super+L` = lock screen (Hyprland) vs `Ctrl+l` = pane-right (tmux/nvim).
  Different modifier, so no clash.
- `f` = link-hint in tridactyl, but find-file scope in nvim's `<leader>f`.

If you ever *do* hit a real conflict after adding a binding, the fix is almost
always to respect the ownership table above — pick a modifier the target layer owns.
