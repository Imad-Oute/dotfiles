-- themeforge: highlight groups for the `glass` colourscheme. Everything derives from the palette `p`.
local tf = require("themeforge")
local blend = tf.blend

local M = {}

function M.apply(p, o)
  o = o or {}
  local none = "NONE"
  local clear = o.transparent and none or p.bg

  -- derived tones --------------------------------------------------------------------------------------
  local c = {
    bg = p.bg, float = p.raised, cursorline = blend(p.bg, p.text, p.light and 0.05 or 0.07),
    visual = blend(p.bg, p.accent, 0.32), search = blend(p.bg, p.yellow, 0.38),
    dim = blend(p.muted, p.bg, 0.25), param = blend(p.orange, p.text, 0.35),
    prop = blend(p.indigo, p.text, p.light and 0.0 or 0.35),
    ok = p.green, err = p.red, warn = p.orange, info = p.accent_hi, hint = p.teal,
  }
  local tint = function(color, t) return blend(p.bg, color, t or 0.16) end

  local hl = {
    -- editor ------------------------------------------------------------------------------------------
    Normal = { fg = p.text, bg = clear }, NormalNC = { fg = p.text, bg = clear },
    NormalFloat = { fg = p.text, bg = c.float }, FloatBorder = { fg = p.line, bg = c.float },
    FloatTitle = { fg = p.accent_hi, bg = c.float, bold = true }, FloatFooter = { fg = p.muted, bg = c.float },
    Cursor = { fg = p.on_accent, bg = p.accent }, lCursor = { link = "Cursor" }, CursorIM = { link = "Cursor" },
    TermCursor = { link = "Cursor" },
    CursorLine = { bg = c.cursorline }, CursorColumn = { bg = c.cursorline }, ColorColumn = { bg = c.cursorline },
    CursorLineNr = { fg = p.accent_hi, bold = true }, LineNr = { fg = c.dim }, LineNrAbove = { fg = c.dim },
    LineNrBelow = { fg = c.dim }, SignColumn = { fg = p.muted, bg = clear }, FoldColumn = { fg = c.dim, bg = clear },
    Folded = { fg = p.muted, bg = tint(p.accent, 0.10) }, EndOfBuffer = { fg = clear == none and p.bg or p.bg },
    Visual = { bg = c.visual }, VisualNOS = { bg = c.visual }, SnippetTabstop = { bg = c.visual },
    Search = { fg = p.text, bg = c.search }, IncSearch = { fg = p.bg, bg = p.yellow },
    CurSearch = { fg = p.bg, bg = p.orange, bold = true }, Substitute = { fg = p.bg, bg = p.red },
    MatchParen = { fg = p.orange, bg = tint(p.orange, 0.25), bold = true },
    NonText = { fg = p.line }, Whitespace = { fg = blend(p.bg, p.line, 0.6) }, SpecialKey = { fg = p.line },
    Conceal = { fg = p.muted }, Directory = { fg = p.accent_hi }, Title = { fg = p.accent_hi, bold = true },
    WinSeparator = { fg = p.line, bg = none }, VertSplit = { link = "WinSeparator" },
    WinBar = { fg = p.subtle, bg = none, bold = true }, WinBarNC = { fg = p.muted, bg = none },
    StatusLine = { fg = p.text, bg = p.raised }, StatusLineNC = { fg = p.muted, bg = p.bg },
    TabLine = { fg = p.muted, bg = p.bg }, TabLineFill = { bg = p.bg }, TabLineSel = { fg = p.on_accent, bg = p.accent },
    Pmenu = { fg = p.text, bg = c.float }, PmenuSel = { fg = p.on_accent, bg = p.accent },
    PmenuKind = { fg = p.teal, bg = c.float }, PmenuKindSel = { fg = p.on_accent, bg = p.accent },
    PmenuExtra = { fg = p.muted, bg = c.float }, PmenuExtraSel = { fg = p.on_accent, bg = p.accent },
    PmenuSbar = { bg = p.raised2 }, PmenuThumb = { bg = p.muted }, PmenuMatch = { fg = p.accent_hi, bold = true },
    PmenuMatchSel = { fg = p.on_accent, bold = true },
    WildMenu = { fg = p.on_accent, bg = p.accent },
    ErrorMsg = { fg = p.red, bold = true }, WarningMsg = { fg = p.orange }, MoreMsg = { fg = p.green },
    ModeMsg = { fg = p.subtle, bold = true }, Question = { fg = p.accent_hi }, MsgArea = { fg = p.text },
    SpellBad = { sp = p.red, undercurl = true }, SpellCap = { sp = p.orange, undercurl = true },
    SpellLocal = { sp = p.teal, undercurl = true }, SpellRare = { sp = p.purple, undercurl = true },
    QuickFixLine = { bg = c.visual, bold = true }, Underlined = { underline = true },
    Added = { fg = p.green }, Changed = { fg = p.accent_hi }, Removed = { fg = p.red },
    DiffAdd = { bg = tint(p.green, 0.20) }, DiffChange = { bg = tint(p.accent, 0.18) },
    DiffDelete = { bg = tint(p.red, 0.22) }, DiffText = { bg = tint(p.accent, 0.42), bold = true },
    debugPC = { bg = tint(p.accent, 0.25) }, debugBreakpoint = { fg = p.red, bg = tint(p.red, 0.2) },

    -- diagnostics -------------------------------------------------------------------------------------
    DiagnosticError = { fg = c.err }, DiagnosticWarn = { fg = c.warn }, DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint }, DiagnosticOk = { fg = c.ok },
    DiagnosticVirtualTextError = { fg = c.err, bg = tint(c.err, 0.12) },
    DiagnosticVirtualTextWarn = { fg = c.warn, bg = tint(c.warn, 0.12) },
    DiagnosticVirtualTextInfo = { fg = c.info, bg = tint(c.info, 0.12) },
    DiagnosticVirtualTextHint = { fg = c.hint, bg = tint(c.hint, 0.12) },
    DiagnosticVirtualTextOk = { fg = c.ok, bg = tint(c.ok, 0.12) },
    DiagnosticUnderlineError = { sp = c.err, undercurl = true }, DiagnosticUnderlineWarn = { sp = c.warn, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.info, undercurl = true }, DiagnosticUnderlineHint = { sp = c.hint, undercurl = true },
    DiagnosticUnderlineOk = { sp = c.ok, undercurl = true },
    DiagnosticUnnecessary = { fg = p.muted }, DiagnosticDeprecated = { sp = p.red, strikethrough = true },
    LspReferenceText = { bg = tint(p.accent, 0.18) }, LspReferenceRead = { bg = tint(p.accent, 0.18) },
    LspReferenceWrite = { bg = tint(p.orange, 0.22) }, LspInlayHint = { fg = p.muted, bg = tint(p.accent, 0.08) },
    LspCodeLens = { fg = p.muted }, LspSignatureActiveParameter = { fg = p.orange, bold = true, underline = true },

    -- classic syntax ----------------------------------------------------------------------------------
    Comment = { fg = p.muted, italic = true }, SpecialComment = { fg = p.muted, italic = true, bold = true },
    Constant = { fg = p.orange }, String = { fg = p.green }, Character = { fg = p.green },
    Number = { fg = p.orange }, Boolean = { fg = p.orange, bold = true }, Float = { fg = p.orange },
    Identifier = { fg = p.text }, Function = { fg = p.accent_hi },
    Statement = { fg = p.purple }, Conditional = { fg = p.purple }, Repeat = { fg = p.purple },
    Label = { fg = p.purple }, Operator = { fg = p.subtle }, Keyword = { fg = p.purple }, Exception = { fg = p.purple },
    PreProc = { fg = p.pink }, Include = { fg = p.pink }, Define = { fg = p.pink }, Macro = { fg = p.pink },
    PreCondit = { fg = p.pink }, Type = { fg = p.teal }, StorageClass = { fg = p.purple },
    Structure = { fg = p.teal }, Typedef = { fg = p.teal }, Special = { fg = p.accent_hi },
    SpecialChar = { fg = p.teal }, Tag = { fg = p.pink }, Delimiter = { fg = p.subtle }, Debug = { fg = p.red },
    Error = { fg = p.red }, Todo = { fg = p.bg, bg = p.yellow, bold = true },

    -- treesitter --------------------------------------------------------------------------------------
    ["@variable"] = { fg = p.text }, ["@variable.builtin"] = { fg = p.red, italic = true },
    ["@variable.parameter"] = { fg = c.param }, ["@variable.parameter.builtin"] = { fg = c.param, italic = true },
    ["@variable.member"] = { fg = c.prop }, ["@property"] = { fg = c.prop },
    ["@constant"] = { fg = p.orange }, ["@constant.builtin"] = { fg = p.orange, bold = true },
    ["@constant.macro"] = { fg = p.pink }, ["@module"] = { fg = p.teal }, ["@module.builtin"] = { fg = p.teal, italic = true },
    ["@label"] = { fg = p.purple }, ["@string"] = { fg = p.green }, ["@string.documentation"] = { fg = p.muted, italic = true },
    ["@string.escape"] = { fg = p.teal }, ["@string.regexp"] = { fg = p.pink }, ["@string.special"] = { fg = p.teal },
    ["@string.special.url"] = { fg = p.accent_hi, underline = true }, ["@string.special.path"] = { fg = p.accent_hi },
    ["@character"] = { link = "String" }, ["@character.special"] = { fg = p.teal },
    ["@number"] = { fg = p.orange }, ["@number.float"] = { fg = p.orange }, ["@boolean"] = { fg = p.orange, bold = true },
    ["@function"] = { fg = p.accent_hi }, ["@function.call"] = { fg = p.accent_hi },
    ["@function.builtin"] = { fg = p.teal }, ["@function.method"] = { fg = p.accent_hi },
    ["@function.method.call"] = { fg = p.accent_hi }, ["@function.macro"] = { fg = p.pink },
    ["@constructor"] = { fg = p.teal }, ["@operator"] = { fg = p.subtle },
    ["@keyword"] = { fg = p.purple }, ["@keyword.function"] = { fg = p.purple }, ["@keyword.return"] = { fg = p.purple, italic = true },
    ["@keyword.operator"] = { fg = p.purple }, ["@keyword.import"] = { fg = p.pink }, ["@keyword.conditional"] = { fg = p.purple },
    ["@keyword.repeat"] = { fg = p.purple }, ["@keyword.exception"] = { fg = p.purple }, ["@keyword.modifier"] = { fg = p.purple },
    ["@keyword.type"] = { fg = p.purple }, ["@keyword.coroutine"] = { fg = p.purple, italic = true },
    ["@keyword.directive"] = { fg = p.pink }, ["@keyword.debug"] = { fg = p.red },
    ["@type"] = { fg = p.teal }, ["@type.builtin"] = { fg = p.teal, italic = true }, ["@type.definition"] = { fg = p.teal },
    ["@attribute"] = { fg = p.pink }, ["@attribute.builtin"] = { fg = p.pink },
    ["@tag"] = { fg = p.pink }, ["@tag.builtin"] = { fg = p.pink }, ["@tag.attribute"] = { fg = p.orange },
    ["@tag.delimiter"] = { fg = p.muted }, ["@punctuation"] = { fg = p.subtle }, ["@punctuation.delimiter"] = { fg = p.subtle },
    ["@punctuation.bracket"] = { fg = p.subtle }, ["@punctuation.special"] = { fg = p.teal },
    ["@comment"] = { fg = p.muted, italic = true }, ["@comment.documentation"] = { fg = p.muted, italic = true },
    ["@comment.error"] = { fg = p.bg, bg = p.red, bold = true }, ["@comment.warning"] = { fg = p.bg, bg = p.orange, bold = true },
    ["@comment.todo"] = { fg = p.bg, bg = p.yellow, bold = true }, ["@comment.note"] = { fg = p.bg, bg = p.accent_hi, bold = true },
    ["@markup"] = { fg = p.text }, ["@markup.strong"] = { bold = true }, ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true }, ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = p.accent_hi, bold = true },
    ["@markup.heading.1"] = { fg = p.accent_hi, bold = true }, ["@markup.heading.2"] = { fg = p.purple, bold = true },
    ["@markup.heading.3"] = { fg = p.teal, bold = true }, ["@markup.heading.4"] = { fg = p.green, bold = true },
    ["@markup.heading.5"] = { fg = p.orange, bold = true }, ["@markup.heading.6"] = { fg = p.pink, bold = true },
    ["@markup.quote"] = { fg = p.muted, italic = true }, ["@markup.math"] = { fg = p.teal },
    ["@markup.link"] = { fg = p.accent_hi }, ["@markup.link.label"] = { fg = p.accent_hi },
    ["@markup.link.url"] = { fg = p.accent_hi, underline = true }, ["@markup.raw"] = { fg = p.green },
    ["@markup.raw.block"] = { fg = p.green }, ["@markup.list"] = { fg = p.purple },
    ["@markup.list.checked"] = { fg = p.green }, ["@markup.list.unchecked"] = { fg = p.muted },
    ["@diff.plus"] = { fg = p.green }, ["@diff.minus"] = { fg = p.red }, ["@diff.delta"] = { fg = p.accent_hi },

    -- LSP semantic tokens (defer to treesitter unless there is a better answer) ---------------------------
    ["@lsp.type.comment"] = {}, ["@lsp.type.namespace"] = { link = "@module" }, ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.interface"] = { fg = p.teal, italic = true }, ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" }, ["@lsp.type.typeParameter"] = { fg = p.teal, italic = true },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" }, ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.decorator"] = { link = "@attribute" }, ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.typemod.variable.readonly"] = { link = "@constant" }, ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },

    -- git ---------------------------------------------------------------------------------------------
    GitSignsAdd = { fg = p.green }, GitSignsChange = { fg = p.accent_hi }, GitSignsDelete = { fg = p.red },
    GitSignsAddNr = { fg = p.green }, GitSignsChangeNr = { fg = p.accent_hi }, GitSignsDeleteNr = { fg = p.red },
    GitSignsCurrentLineBlame = { fg = p.muted, italic = true },
    GitSignsAddInline = { bg = tint(p.green, 0.35) }, GitSignsDeleteInline = { bg = tint(p.red, 0.35) },
    GitSignsChangeInline = { bg = tint(p.accent, 0.35) },

    -- snacks (picker, dashboard, indent, notifier, input) ---------------------------------------------
    SnacksNormal = { link = "NormalFloat" }, SnacksWinBar = { link = "WinBar" },
    SnacksPicker = { fg = p.text, bg = c.float }, SnacksPickerBorder = { fg = p.line, bg = c.float },
    SnacksPickerTitle = { fg = p.accent_hi, bg = c.float, bold = true }, SnacksPickerInput = { fg = p.text, bg = c.float },
    SnacksPickerInputBorder = { fg = p.accent, bg = c.float }, SnacksPickerListCursorLine = { bg = p.accent, fg = p.on_accent },
    SnacksPickerMatch = { fg = p.accent_hi, bold = true }, SnacksPickerDir = { fg = p.muted },
    SnacksPickerFile = { fg = p.text }, SnacksPickerCursorLine = { bg = c.cursorline },
    SnacksPickerPreviewTitle = { fg = p.bg, bg = p.accent_hi, bold = true },
    SnacksIndent = { fg = blend(p.bg, p.line, 0.6) }, SnacksIndentScope = { fg = p.accent_lo },
    SnacksDashboardHeader = { fg = p.accent_hi }, SnacksDashboardKey = { fg = p.orange },
    SnacksDashboardIcon = { fg = p.accent_hi }, SnacksDashboardDesc = { fg = p.text },
    SnacksDashboardFooter = { fg = p.muted, italic = true }, SnacksDashboardTitle = { fg = p.purple, bold = true },
    SnacksNotifierInfo = { fg = p.text, bg = c.float }, SnacksNotifierBorderInfo = { fg = p.accent_hi, bg = c.float },
    SnacksNotifierWarn = { fg = p.text, bg = c.float }, SnacksNotifierBorderWarn = { fg = p.orange, bg = c.float },
    SnacksNotifierError = { fg = p.text, bg = c.float }, SnacksNotifierBorderError = { fg = p.red, bg = c.float },
    SnacksInputBorder = { fg = p.accent, bg = c.float }, SnacksInputTitle = { fg = p.accent_hi, bg = c.float },

    -- neo-tree ----------------------------------------------------------------------------------------
    NeoTreeNormal = { fg = p.text, bg = clear }, NeoTreeNormalNC = { fg = p.text, bg = clear },
    NeoTreeEndOfBuffer = { fg = p.bg, bg = clear }, NeoTreeWinSeparator = { fg = p.line, bg = none },
    NeoTreeFloatBorder = { fg = p.line, bg = c.float }, NeoTreeDirectoryName = { fg = p.accent_hi },
    NeoTreeDirectoryIcon = { fg = p.accent_hi }, NeoTreeRootName = { fg = p.purple, bold = true },
    NeoTreeIndentMarker = { fg = blend(p.bg, p.line, 0.6) }, NeoTreeDotfile = { fg = p.muted },
    NeoTreeGitAdded = { fg = p.green }, NeoTreeGitModified = { fg = p.orange }, NeoTreeGitDeleted = { fg = p.red },
    NeoTreeGitUntracked = { fg = p.teal }, NeoTreeGitIgnored = { fg = p.muted }, NeoTreeGitConflict = { fg = p.red, bold = true },
    NeoTreeCursorLine = { bg = c.cursorline }, NeoTreeTitleBar = { fg = p.bg, bg = p.accent_hi },

    -- completion (blink.cmp / nvim-cmp) ---------------------------------------------------------------
    BlinkCmpMenu = { fg = p.text, bg = c.float }, BlinkCmpMenuBorder = { fg = p.line, bg = c.float },
    BlinkCmpMenuSelection = { fg = p.on_accent, bg = p.accent }, BlinkCmpScrollBarThumb = { bg = p.muted },
    BlinkCmpScrollBarGutter = { bg = p.raised2 }, BlinkCmpLabel = { fg = p.text },
    BlinkCmpLabelDeprecated = { fg = p.muted, strikethrough = true }, BlinkCmpLabelMatch = { fg = p.accent_hi, bold = true },
    BlinkCmpLabelDetail = { fg = p.muted }, BlinkCmpLabelDescription = { fg = p.muted }, BlinkCmpGhostText = { fg = p.muted },
    BlinkCmpKind = { fg = p.teal }, BlinkCmpDoc = { fg = p.text, bg = c.float }, BlinkCmpDocBorder = { fg = p.line, bg = c.float },
    BlinkCmpSignatureHelp = { fg = p.text, bg = c.float }, BlinkCmpSignatureHelpBorder = { fg = p.line, bg = c.float },
    CmpItemAbbrMatch = { fg = p.accent_hi, bold = true }, CmpItemAbbrMatchFuzzy = { fg = p.accent_hi },
    CmpItemKind = { fg = p.teal }, CmpItemMenu = { fg = p.muted },

    -- UI plugins --------------------------------------------------------------------------------------
    WhichKey = { fg = p.accent_hi }, WhichKeyGroup = { fg = p.purple }, WhichKeyDesc = { fg = p.text },
    WhichKeySeparator = { fg = p.muted }, WhichKeyNormal = { bg = c.float }, WhichKeyBorder = { fg = p.line, bg = c.float },
    WhichKeyValue = { fg = p.muted }, WhichKeyIcon = { fg = p.accent_hi },
    NoiceCmdline = { fg = p.text, bg = c.float }, NoiceCmdlinePopup = { fg = p.text, bg = c.float },
    NoiceCmdlinePopupBorder = { fg = p.accent, bg = c.float }, NoiceCmdlineIcon = { fg = p.accent_hi },
    NoicePopupmenu = { fg = p.text, bg = c.float }, NoicePopupmenuSelected = { fg = p.on_accent, bg = p.accent },
    NoiceConfirmBorder = { fg = p.accent, bg = c.float }, NoiceLspProgressTitle = { fg = p.muted },
    NotifyBackground = { bg = p.bg }, NotifyERRORBorder = { fg = p.red }, NotifyWARNBorder = { fg = p.orange },
    NotifyINFOBorder = { fg = p.accent_hi }, NotifyDEBUGBorder = { fg = p.muted }, NotifyTRACEBorder = { fg = p.purple },
    LazyNormal = { fg = p.text, bg = c.float }, LazyButton = { fg = p.text, bg = p.raised2 },
    LazyButtonActive = { fg = p.on_accent, bg = p.accent }, LazyH1 = { fg = p.on_accent, bg = p.accent, bold = true },
    LazySpecial = { fg = p.accent_hi }, LazyProp = { fg = p.muted }, LazyCommit = { fg = p.green },
    MasonNormal = { fg = p.text, bg = c.float }, MasonHeader = { fg = p.on_accent, bg = p.accent, bold = true },
    MasonHighlight = { fg = p.accent_hi }, MasonHighlightBlock = { fg = p.bg, bg = p.accent_hi },
    MasonHighlightBlockBold = { fg = p.bg, bg = p.accent_hi, bold = true }, MasonMuted = { fg = p.muted },
    IblIndent = { fg = blend(p.bg, p.line, 0.6) }, IblScope = { fg = p.accent_lo },
    FlashBackdrop = { fg = p.muted }, FlashLabel = { fg = p.bg, bg = p.pink, bold = true },
    FlashMatch = { fg = p.text, bg = tint(p.accent, 0.4) }, FlashCurrent = { fg = p.bg, bg = p.orange },
    TroubleNormal = { fg = p.text, bg = clear }, TroubleNormalNC = { fg = p.text, bg = clear },
    TodoBgTODO = { fg = p.bg, bg = p.accent_hi, bold = true }, TodoBgFIX = { fg = p.bg, bg = p.red, bold = true },
    TodoBgWARN = { fg = p.bg, bg = p.orange, bold = true }, TodoBgNOTE = { fg = p.bg, bg = p.green, bold = true },
    TodoBgHACK = { fg = p.bg, bg = p.yellow, bold = true }, TodoBgPERF = { fg = p.bg, bg = p.purple, bold = true },
    TodoFgTODO = { fg = p.accent_hi }, TodoFgFIX = { fg = p.red }, TodoFgWARN = { fg = p.orange },
    TodoFgNOTE = { fg = p.green }, TodoFgHACK = { fg = p.yellow }, TodoFgPERF = { fg = p.purple },
    DapBreakpoint = { fg = p.red }, DapBreakpointCondition = { fg = p.orange }, DapLogPoint = { fg = p.accent_hi },
    DapStopped = { fg = p.green, bg = tint(p.green, 0.2) }, DapUIScope = { fg = p.accent_hi },
    NavicText = { fg = p.subtle }, NavicSeparator = { fg = p.muted },
    MiniStatuslineModeNormal = { fg = p.on_accent, bg = p.accent, bold = true },
    MiniStatuslineModeInsert = { fg = p.bg, bg = p.green, bold = true },
    MiniStatuslineModeVisual = { fg = p.bg, bg = p.purple, bold = true },
    MiniStatuslineModeReplace = { fg = p.bg, bg = p.red, bold = true },
    MiniStatuslineModeCommand = { fg = p.bg, bg = p.orange, bold = true },
    MiniIndentscopeSymbol = { fg = p.accent_lo }, MiniCursorword = { bg = tint(p.accent, 0.2) },
    MiniFilesNormal = { fg = p.text, bg = c.float }, MiniFilesBorder = { fg = p.line, bg = c.float },
    MiniFilesTitleFocused = { fg = p.accent_hi, bg = c.float, bold = true },

    -- render-markdown ---------------------------------------------------------------------------------
    RenderMarkdownH1 = { fg = p.accent_hi, bold = true }, RenderMarkdownH2 = { fg = p.purple, bold = true },
    RenderMarkdownH3 = { fg = p.teal, bold = true }, RenderMarkdownH4 = { fg = p.green, bold = true },
    RenderMarkdownH5 = { fg = p.orange, bold = true }, RenderMarkdownH6 = { fg = p.pink, bold = true },
    RenderMarkdownH1Bg = { bg = tint(p.accent, 0.18) }, RenderMarkdownH2Bg = { bg = tint(p.purple, 0.16) },
    RenderMarkdownH3Bg = { bg = tint(p.teal, 0.16) }, RenderMarkdownH4Bg = { bg = tint(p.green, 0.14) },
    RenderMarkdownH5Bg = { bg = tint(p.orange, 0.14) }, RenderMarkdownH6Bg = { bg = tint(p.pink, 0.14) },
    RenderMarkdownCode = { bg = tint(p.text, 0.06) }, RenderMarkdownCodeInline = { fg = p.green, bg = tint(p.text, 0.08) },
    RenderMarkdownBullet = { fg = p.purple }, RenderMarkdownQuote = { fg = p.muted },
    RenderMarkdownTableHead = { fg = p.accent_hi, bold = true }, RenderMarkdownTableRow = { fg = p.subtle },
    RenderMarkdownChecked = { fg = p.green }, RenderMarkdownUnchecked = { fg = p.muted },
    RenderMarkdownLink = { fg = p.accent_hi }, RenderMarkdownDash = { fg = p.line },
  }

  for name, spec in pairs(hl) do vim.api.nvim_set_hl(0, name, spec) end

  -- terminal palette (matches the kitty theme roles) ---------------------------------------------------
  local term = {
    p.raised2, p.red, p.green, p.yellow, p.accent, p.purple, p.teal, p.subtle,
    p.muted, p.red, p.green, p.yellow, p.accent_hi, p.purple, p.teal, p.text,
  }
  for i, color in ipairs(term) do vim.g["terminal_color_" .. (i - 1)] = color end
end

return M
