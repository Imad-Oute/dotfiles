local M = {}

-- Read actual mappings, including lazy-loading stubs, rather than duplicating defaults.
function M.export(path)
  local rows = {}
  for _, mode in ipairs({ "n", "i", "x", "s", "o", "c", "t" }) do
    for _, scope in ipairs({ "global", "buffer" }) do
      local maps = scope == "global" and vim.api.nvim_get_keymap(mode) or vim.api.nvim_buf_get_keymap(0, mode)
      for _, mapping in ipairs(maps) do
        local function cell(value)
          return (tostring(value or ""):gsub("\n", " "):gsub("|", "&#124;"):gsub("`", "&#96;"))
        end
        local lhs = mapping.lhs:gsub("^ ", "<leader>")
        rows[#rows + 1] = { mode, lhs, scope, cell(mapping.desc or mapping.rhs or "Lua callback") }
      end
    end
  end
  table.sort(rows, function(a, b)
    return table.concat(a, "\t") < table.concat(b, "\t")
  end)
  local lines = {
    "# Neovim keymap catalog",
    "",
    "Generated from the running configuration. Leader = Space; local leader = backslash.",
    "",
    "Modes: n normal, i insert, x visual, s select, o operator pending, c command line, t terminal.",
    "",
    "Includes global mappings and mappings local to the current buffer. Buffer mappings take precedence.",
    "Filetype, LSP, completion, picker, and plugin-window mappings appear only when their context is active.",
    "Built-in unmapped Vim commands are covered by `:help index`. Refresh with `:KeymapsExport path`.",
    "",
    "| Mode | Key | Scope | Action |",
    "|---|---|---|---|",
  }
  for _, row in ipairs(rows) do
    row[2] = row[2]:gsub("|", "&#124;"):gsub("`", "&#96;")
    lines[#lines + 1] = "| " .. table.concat(row, " | ") .. " |"
  end
  vim.fn.writefile(lines, path)
  vim.notify("Exported " .. #rows .. " keymaps to " .. path)
end

function M.setup()
  vim.api.nvim_create_user_command("Keymaps", function()
    Snacks.picker.keymaps()
  end, { desc = "Search active keymaps" })
  vim.api.nvim_create_user_command("KeymapsExport", function(opts)
    M.export(vim.fn.expand(opts.args ~= "" and opts.args or "~/dotfiles/docs/neovim-keymaps.md"))
  end, { nargs = "?", complete = "file", desc = "Export active keymaps as Markdown" })
end

return M
