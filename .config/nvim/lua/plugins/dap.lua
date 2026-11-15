-- Adapter installation and JS/TS launch configurations come from the TypeScript extra.
return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
        local configs = dap.configurations[ft] or {}
        dap.configurations[ft] = configs
        vim.list_extend(configs, {
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest test",
            runtimeExecutable = "node",
            runtimeArgs = { "${workspaceFolder}/node_modules/jest/bin/jest.js", "--runInBand" },
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
        })
      end
    end,
  },
  -- DAP UI (extras.dap.core installs nvim-dap-ui; we configure it here)
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      icons = { expanded = "▾", collapsed = "▸", current_frame = "→" },
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
