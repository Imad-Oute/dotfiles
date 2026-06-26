return {
  -- Undo history visualization
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" } },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 35
      vim.g.undotree_DiffpanelHeight = 12
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
    end,
  },

  -- Aerial: override LazyVim extra defaults for better UX
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Aerial outline" },
      { "{", "<cmd>AerialPrev<CR>", desc = "Aerial prev symbol" },
      { "}", "<cmd>AerialNext<CR>", desc = "Aerial next symbol" },
    },
    opts = {
      layout = { min_width = 28 },
      show_guides = true,
      filter_kind = {
        "Class", "Constructor", "Enum", "Function",
        "Interface", "Method", "Module", "Struct", "Type",
      },
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
    },
  },

  -- Better f/t/s motions (flash is installed by LazyVim; extend config)
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = { enabled = false },
        char = {
          jump_labels = true,
          multi_line = false,
        },
      },
    },
  },

  -- Highlight and search word under cursor
  {
    "RRethy/vim-illuminate",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      under_cursor = true,
    },
  },

  -- Better increment/decrement (supports dates, booleans, etc.)
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      { "<C-a>", function() return require("dial.map").inc_visual() end, mode = "v", expr = true, desc = "Increment (visual)" },
      { "<C-x>", function() return require("dial.map").dec_visual() end, mode = "v", expr = true, desc = "Decrement (visual)" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
          augend.constant.new({ elements = { "true", "false" } }),
          augend.constant.new({ elements = { "and", "or" } }),
        },
      })
    end,
  },
}
