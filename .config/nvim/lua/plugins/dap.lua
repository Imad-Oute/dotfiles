-- DAP configuration for JavaScript / TypeScript
-- Python: handled by extras.lang.python + extras.dap.core (debugpy via Mason)
-- Rust: handled by rustaceanvim (codelldb auto-detected)
-- JS/TS: requires manual adapter config below

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local dap = require("dap")

      -- Ensure js-debug-adapter is installed via Mason
      require("mason-registry").refresh(function()
        local pkg = require("mason-registry").get_package("js-debug-adapter")
        if not pkg:is_installed() then pkg:install() end
      end)

      local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
      local js_debug_bin = js_debug_path .. "/js-debug/src/dapDebugServer.js"

      -- Register the adapter for all JS/TS variants
      for _, type in ipairs({ "node", "chrome", "pwa-node", "pwa-chrome" }) do
        dap.adapters[type] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = { js_debug_bin, "${port}" },
          },
        }
      end

      -- Shared JS/TS launch configurations
      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest test",
          runtimeExecutable = "node",
          runtimeArgs = { "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest", "--runInBand" },
          console = "integratedTerminal",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
        dap.configurations[lang] = js_config
      end
    end,
  },

  -- DAP UI (extras.dap.core installs nvim-dap-ui; we configure it here)
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      icons = { expanded = "", collapsed = "", current_frame = "" },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.4 },
            { id = "breakpoints", size = 0.2 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.15 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = { { id = "console", size = 0.5 }, { id = "repl", size = 0.5 } },
          size = 12,
          position = "bottom",
        },
      },
    },
  },
}
