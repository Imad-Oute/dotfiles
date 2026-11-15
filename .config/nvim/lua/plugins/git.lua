return {
  -- Fugitive: the definitive git plugin for interactive staging, blame, history
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "Gclog" },
    keys = {
      { "<leader>gF", "<cmd>Git<CR>", desc = "Fugitive (interactive stage)" },
      { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
      { "<leader>gL", "<cmd>0Gclog<CR>", desc = "File git history" },
      { "<leader>gW", "<cmd>Gwrite<CR>", desc = "Git stage file (write)" },
      { "<leader>gO", "<cmd>Gread<CR>", desc = "Git checkout file (read)" },
    },
  },

  -- Gitsigns: enhance LazyVim defaults with more features
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      },
    },
  },
}
