-- themeforge: palette loading, derivation and live reload for the `glass` colourscheme.
local M = {}
local uv = vim.uv or vim.loop

local cache = (vim.env.XDG_CACHE_HOME or (vim.env.HOME .. "/.cache")) .. "/hyde/wallbash"
local PATH = cache .. "/nvim.json"

-- Glass defaults, used when HyDE's palette file is missing.
local fallback = {
  bg = "#1C1C1E", raised = "#2C2C2E", raised2 = "#3A3A3C", line = "#48484A", muted = "#98989D",
  subtle = "#EBEBF5", text = "#FFFFFF", accent = "#0A84FF", accent_hi = "#409CFF", accent_lo = "#0060DF",
  on_accent = "#FFFFFF", accent2 = "#BF5AF2",
}

-- Semantic hues are mode-independent in wallbash, so we carry two tuned sets and pick by background luma.
local hues = {
  dark = { red = "#FF453A", orange = "#FF9F0A", yellow = "#FFD60A", green = "#30D158", teal = "#64D2FF",
           purple = "#BF5AF2", pink = "#FF6482", indigo = "#7D7AFF" },
  light = { red = "#D70015", orange = "#C93400", yellow = "#8A6500", green = "#248A3D", teal = "#0071A4",
            purple = "#8944AB", pink = "#C30F45", indigo = "#3634A3" },
}

local function rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

function M.luma(hex)
  local r, g, b = rgb(hex)
  return (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255
end

--- mix(a, b, t): t=0 → a, t=1 → b
function M.blend(a, b, t)
  local ar, ag, ab = rgb(a)
  local br, bg, bb = rgb(b)
  return string.format("#%02x%02x%02x", ar + (br - ar) * t, ag + (bg - ag) * t, ab + (bb - ab) * t)
end

local function read_file()
  local ok, lines = pcall(vim.fn.readfile, PATH)
  if not ok then return nil end
  local ok2, t = pcall(vim.json.decode, table.concat(lines, "\n"))
  return ok2 and type(t) == "table" and t or nil
end

function M.palette()
  local p = vim.tbl_extend("force", vim.deepcopy(fallback), read_file() or {})
  for k, v in pairs(p) do
    if type(v) ~= "string" or not v:match("^#%x%x%x%x%x%x$") then p[k] = fallback[k] end
  end
  p.light = M.luma(p.bg) > 0.5
  local h = hues[p.light and "light" or "dark"]
  for k, v in pairs(h) do p[k] = v end
  return p
end

local watcher, timer
local function watch()
  if watcher then return end
  watcher = uv.new_fs_event()
  timer = uv.new_timer()
  -- watch the directory (HyDE replaces the file, which would kill a file-level watcher)
  watcher:start(cache, {}, function(_, name)
    if name and name ~= "nvim.json" then return end
    timer:stop()
    timer:start(150, 0, vim.schedule_wrap(function()
      if vim.g.colors_name == "glass" then M.load() end
    end))
  end)
end

function M.load()
  vim.g.colors_name = nil
  local p = M.palette()
  vim.o.termguicolors = true
  vim.o.background = p.light and "light" or "dark"
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  require("themeforge.highlights").apply(p, { transparent = vim.g.themeforge_transparent ~= false })
  vim.g.colors_name = "glass"
  watch()
end

return M
