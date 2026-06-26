-- In VS Code, snacks is kept (whitelisted by the vscode extra) but its UI
-- features are disabled there. Skip these customizations so we don't re-enable
-- the notifier/indent or bind terminal/zen keys that don't apply in VS Code.
if vim.g.vscode then
  return {}
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Floating terminal (toggle with <C-\> or <leader>ft)
      terminal = {
        win = {
          style = "terminal",
          height = 0.4,
          width = 0.9,
          border = "rounded",
          position = "bottom",
        },
      },

      -- Zen mode config
      zen = {
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff_signs = false,
          diagnostics = false,
          inlay_hints = false,
        },
        win = { width = 100 },
      },

      -- Dashboard (startup screen)
      dashboard = {
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = " ", key = "g", desc = "Live Grep", action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },

      -- Picker (snacks.picker replaces telescope in LazyVim v14+)
      picker = {
        layout = {
          preset = "ivy",
        },
      },

      -- Scope/indent display
      indent = {
        enabled = true,
        animate = { enabled = false },
      },

      -- Smooth scrolling
      scroll = { enabled = true },

      -- Word highlights in buffer
      words = { enabled = true },

      -- Better notifications
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "fancy",
      },
    },

    keys = {
      -- Terminal
      { "<C-\\>", function() Snacks.terminal.toggle() end, desc = "Toggle terminal", mode = { "n", "t" } },
      { "<leader>ft", function() Snacks.terminal() end, desc = "Float terminal" },

      -- Zen mode
      { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
      { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom buffer" },

      -- Scratch buffer
      { "<leader>.", function() Snacks.scratch() end, desc = "Scratch buffer" },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select scratch" },

      -- Notifications
      { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
      { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },

      -- Git (lazygit via snacks — LazyVim sets <leader>gg already)
      { "<leader>gl", function() Snacks.lazygit.log_file() end, desc = "Lazygit file log" },
    },
  },
}
