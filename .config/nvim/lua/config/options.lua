local opt = vim.opt

-- Scroll context
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Speed
opt.updatetime = 50
opt.timeoutlen = 300

-- Visual guides
opt.wrap = false
opt.colorcolumn = "80"
opt.signcolumn = "yes:2"

-- Undo
opt.undolevels = 10000

-- Folds (treesitter-driven, all open by default)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "1"

-- Better split characters
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Show whitespace characters
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
