return {
  -- Fugitive: the definitive git plugin for interactive staging, blame, history
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "Gclog", "0Gclog" },
    keys = {
      { "<leader>gf", "<cmd>Git<CR>", desc = "Fugitive (interactive stage)" },
      { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
      { "<leader>gL", "<cmd>0Gclog<CR>", desc = "File git history" },
      { "<leader>gW", "<cmd>Gwrite<CR>", desc = "Git stage file (write)" },
      { "<leader>gR", "<cmd>Gread<CR>", desc = "Git checkout file (read)" },
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
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]g", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[g", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("n", "]G", function() gs.nav_hunk("last") end, "Last hunk")
        map("n", "[G", function() gs.nav_hunk("first") end, "First hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>gp", gs.preview_hunk_inline, "Preview hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line (full)")
        map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle blame column")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff against HEAD~1")
        map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },
}
