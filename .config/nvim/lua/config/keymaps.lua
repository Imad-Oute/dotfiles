-- KEYMAP GRAMMAR
-- <leader>f  → Find (files, grep, recent, buffers)
-- <leader>g  → Git (lazygit, blame, diff, hunks)
-- <leader>c  → Code (LSP: actions, rename, format)
-- <leader>d  → Debug (DAP: breakpoints, run, step)
-- <leader>t  → Test (neotest: nearest, file, all)
-- <leader>x  → Diagnostics (trouble, quickfix)
-- <leader>h  → Harpoon marks + Git hunks (LazyVim namespace)
-- <leader>u  → UI Toggles
-- <leader>w  → Windows
-- <leader>b  → Buffers
-- <leader>q  → Quit/Session
-- <M-1-4>    → Harpoon fast jump (Alt+number)
-- ][ prefixes → Next/prev: buffer, hunk, diagnostic, quickfix

local map = vim.keymap.set

-- ─── Insert mode ─────────────────────────────────────────────────────────────
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("c", "<C-a>", "<Home>", { desc = "Line start" })
map("c", "<C-e>", "<End>", { desc = "Line end" })

-- ─── Navigation ──────────────────────────────────────────────────────────────
-- Center cursor on large jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "n", "nzzzv", { desc = "Next result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev result (centered)" })
map("n", "G", "Gzz", { desc = "End of file (centered)" })

-- Consistent up/down on wrapped lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Keep cursor when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- ─── Search ──────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ─── Editing ─────────────────────────────────────────────────────────────────
-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Paste without overwriting register
map("x", "p", '"_dP', { desc = "Paste (keep register)" })

-- Delete to void register
map({ "n", "v" }, "<leader>D", '"_d', { desc = "Delete to void" })

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- Rename word under cursor globally in file
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename word in file" })

-- Make current file executable
map("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { desc = "Chmod +x" })

-- ─── Harpoon (extends LazyVim harpoon2 extra defaults) ───────────────────────
-- LazyVim extra sets: <leader>H (menu), <leader>ha (add), <leader>h1-5 (jump)
-- These Alt shortcuts give instant 1-key jumping:
-- Harpoon/undotree/fugitive are disabled in VS Code by the vscode extra,
-- so only define their keymaps in real Neovim.
if not vim.g.vscode then
  map("n", "<M-1>", function() require("harpoon"):list():select(1) end, { desc = "Harpoon mark 1" })
  map("n", "<M-2>", function() require("harpoon"):list():select(2) end, { desc = "Harpoon mark 2" })
  map("n", "<M-3>", function() require("harpoon"):list():select(3) end, { desc = "Harpoon mark 3" })
  map("n", "<M-4>", function() require("harpoon"):list():select(4) end, { desc = "Harpoon mark 4" })
  map("n", "[H", function() require("harpoon"):list():prev() end, { desc = "Harpoon prev" })
  map("n", "]H", function() require("harpoon"):list():next() end, { desc = "Harpoon next" })
end

-- ─── Quickfix / Location list ────────────────────────────────────────────────
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
map("n", "]Q", "<cmd>clast<CR>zz", { desc = "Last quickfix" })
map("n", "[Q", "<cmd>cfirst<CR>zz", { desc = "First quickfix" })
map("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next loclist" })
map("n", "[l", "<cmd>lprev<CR>zz", { desc = "Prev loclist" })

-- ─── Windows ─────────────────────────────────────────────────────────────────
-- LazyVim already sets <leader>| and <leader>- for splits
-- These complement with resize
map("n", "<leader>we", "<C-w>=", { desc = "Equalize splits" })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Grow split up" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Shrink split down" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Grow split right" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Shrink split left" })

if not vim.g.vscode then
  -- ─── Undotree ──────────────────────────────────────────────────────────────
  map("n", "<leader>uu", "<cmd>UndotreeToggle<CR>", { desc = "Undo tree" })

  -- ─── Fugitive ──────────────────────────────────────────────────────────────
  map("n", "<leader>gf", "<cmd>Git<CR>", { desc = "Git fugitive" })
  map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff split" })
  map("n", "<leader>gL", "<cmd>0Gclog<CR>", { desc = "Git file history" })
end

-- ─── Fold ────────────────────────────────────────────────────────────────────
-- Use ufo if it's installed, otherwise fall back to the built-in fold commands.
map("n", "zR", function()
  local ok, ufo = pcall(require, "ufo")
  if ok then ufo.openAllFolds() else vim.cmd("normal! zR") end
end, { desc = "Open all folds" })
map("n", "zM", function()
  local ok, ufo = pcall(require, "ufo")
  if ok then ufo.closeAllFolds() else vim.cmd("normal! zM") end
end, { desc = "Close all folds" })
