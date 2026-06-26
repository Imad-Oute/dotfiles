# 08 · Neovim / LazyVim (editor)

Neovim is the editor, configured as a **LazyVim** distribution — meaning you don't
configure Neovim from scratch; you extend a curated base of plugins and defaults.
The config also runs as the backend for the **VS Code Neovim** extension, so it's
written to behave correctly in both real Neovim and inside VS Code.

Directory: `.config/nvim/` (symlinked to `~/.config/nvim/`).

## Layout

```
.config/nvim/
├── init.lua                 # entrypoint → bootstraps lazy.nvim
├── lua/config/
│   ├── lazy.lua             # plugin-manager bootstrap + LazyVim import
│   ├── options.lua          # ✅ editor options (scrolloff, folds, diagnostics)
│   ├── keymaps.lua          # ✅ custom keymaps (the grammar below)
│   └── autocmds.lua         # ✅ autocommands
├── lua/plugins/             # ✅ one file per plugin/area, auto-loaded
│   ├── theme.lua            # Catppuccin Mocha, transparent
│   ├── git.lua              # fugitive + gitsigns
│   ├── editor.lua           # undotree, aerial outline
│   ├── dap.lua              # debugging (JS/TS adapter)
│   ├── snacks.lua           # floating terminal, zen mode (skipped in VS Code)
│   ├── neo-tree.lua         # file tree (shows hidden files)
│   ├── tmux-navigator.lua   # Ctrl+hjkl across nvim splits + tmux panes
│   └── render-markdown.lua  # pretty markdown rendering
├── lazy-lock.json           # ✅ plugin version lockfile — COMMIT THIS
└── lazyvim.json             # which LazyVim "extras" are enabled
```

Each file in `lua/plugins/` returns a lazy.nvim spec; LazyVim auto-loads them all.
To add a plugin, drop a new file there.

## The keymap grammar

`keymaps.lua` opens with a deliberate, memorable namespace scheme. `<leader>` is
Space. Learn the *prefix*, and the rest is discoverable:

| Prefix | Domain |
|---|---|
| `<leader>f` | **Find** — files, grep, recent, buffers |
| `<leader>g` | **Git** — lazygit, blame, diff, hunks |
| `<leader>c` | **Code** — LSP actions, rename, format |
| `<leader>d` | **Debug** — DAP breakpoints, run, step |
| `<leader>t` | **Test** — neotest nearest/file/all |
| `<leader>x` | **Diagnostics** — trouble, quickfix |
| `<leader>h` | **Harpoon** marks + git hunks |
| `<leader>u` | **UI** toggles |
| `<leader>w` / `b` / `q` | Windows / Buffers / Quit-Session |
| `<M-1..4>` | Harpoon fast-jump (Alt+number) |
| `]` / `[` | Next / prev: buffer, hunk, diagnostic, quickfix |

### Notable custom maps

```lua
map("i", "jk", "<Esc>")                 -- exit insert without reaching for Esc
map("n", "<C-d>", "<C-d>zz")            -- half-page jumps stay centered
map("n", "n", "nzzzv")                  -- search results stay centered
map("v", "J", ":m '>+1<CR>gv=gv")       -- move selected lines down
map("x", "p", '"_dP')                   -- paste over selection without clobbering register
map({"n","v"}, "<leader>y", '"+y')      -- yank to system clipboard
map("n", "<leader>rw", ...)             -- rename word-under-cursor throughout file
map("n", "<leader>cx", "<cmd>!chmod +x %<CR>")  -- make current file executable
```

## The VS Code dual-mode (important)

This config is written to run under the **VS Code Neovim** extension as well as in a
real terminal. The pattern throughout:

```lua
if not vim.g.vscode then
  -- terminal-only keymaps/plugins (harpoon, undotree, fugitive, floating terminal)
end
```

**Why:** in VS Code, the editor UI, file tree, terminal, and git are provided by VS
Code itself. Re-binding those keys or enabling Neovim's own UI plugins (snacks
notifier, indent guides, neo-tree) would conflict. So anything UI-ish is guarded
behind `not vim.g.vscode`. `vim.g.vscode` is `true` only when running inside the
extension.

This is why `snacks.lua` early-returns `{}` under VS Code, and why harpoon/undotree/
fugitive keymaps are gated.

## options.lua highlights

```lua
opt.scrolloff = 8                       -- keep 8 lines of context around cursor
opt.updatetime = 50                     -- snappy CursorHold (gitsigns, diagnostics)
opt.timeoutlen = 300                    -- which-key pops fast
opt.colorcolumn = "80"                  -- the 80-char guide
opt.foldmethod = "expr"                 -- treesitter-driven folds, all open by default
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.list = true                         -- show tabs/trailing-space/nbsp
```

Diagnostics are customized with rounded float borders, severity sorting, and Nerd
Font sign icons (` `, ` `, …).

## Plugins, by file

- **theme.lua** — Catppuccin Mocha, `transparent_background = true` so the editor
  shows the terminal's translucency. Integrations for telescope/treesitter/notify.
- **git.lua** — `vim-fugitive` (interactive staging `:Git`, diff, file history) +
  enhanced `gitsigns`.
- **editor.lua** — `undotree` (visual undo history, `<leader>uu`), `aerial`
  (symbol outline, `<leader>a`).
- **dap.lua** — debugging. JS/TS adapter auto-installed via Mason; Python via the
  LazyVim python extra; Rust via rustaceanvim.
- **snacks.lua** — floating terminal (`Ctrl+\` or `<leader>ft`), zen mode. Disabled
  under VS Code.
- **neo-tree.lua** — file tree that shows hidden files and follows the active file.
- **tmux-navigator.lua** — the `Ctrl+hjkl` seamless nav (pairs with the tmux plugin
  in [07-tmux.md](07-tmux.md)).
- **render-markdown.lua** — in-buffer markdown prettifying.

## lazy-lock.json — commit it

`lazy-lock.json` pins every plugin to an exact commit. **Commit it** so a fresh
machine installs the exact same versions you've tested. To update plugins: `:Lazy
update`, verify nothing broke, then commit the new lockfile.

## Common tasks

**"Add a plugin."** New file in `lua/plugins/`, return its spec, `:Lazy sync`.

**"A keymap works in terminal nvim but not VS Code."** It's probably (correctly)
gated behind `if not vim.g.vscode`. That's intentional for UI plugins.

**"Sync plugin versions to another machine."** Commit `lazy-lock.json`, pull on the
other machine, `:Lazy restore`.

🔗 LazyVim: https://lazyvim.org/
