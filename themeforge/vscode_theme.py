"""themeforge: VS Code colour theme (workbench + TextMate + semantic tokens) from a token file."""
from __future__ import annotations

import json
import zipfile
from pathlib import Path

import forge as F


def build_theme(t: dict) -> dict:
    p, a = t["palette"], t["ansi"]
    col = {k: F.parse(v) for k, v in p.items()}
    col.update({f"ansi_{k}": F.parse(v) for k, v in a.items()})
    col["purple"] = F.parse(a["magenta"])      # keyword hue: terminal magenta (Glass #BF5AF2, BlackArch #A78BFA)
    dark = t["meta"]["mode"] == "dark"

    def h(name: str, alpha: float | None = None, lighten: float = 0.0) -> str:
        c = col[name]
        if lighten:
            c = F.hls_shift(c, lighten)
        if alpha is not None:
            c = (c[0], c[1], c[2], alpha)
        s = "#" + F.f_hex(c)
        return s + F._hex2(c[3] * 255) if c[3] < 1 else s

    def deep(amount: float) -> str:      # chrome surfaces sit a step darker (dark) / lighter (light) than the editor
        return "#" + F.f_hex(F.hls_shift(col["base"], -amount if dark else amount))

    base, chrome, field = h("base"), deep(0.025), deep(0.04)
    clear = "#00000000"
    c = {
        # global
        "focusBorder": h("accent", 0.65), "foreground": h("text"), "disabledForeground": h("text3"),
        "descriptionForeground": h("text2"), "errorForeground": h("red"), "icon.foreground": h("text2"),
        "selection.background": h("accent", 0.45), "widget.shadow": "#00000040", "sash.hoverBorder": h("accent"),
        "textLink.foreground": h("accent_hi"), "textLink.activeForeground": h("accent_hi", lighten=0.1),
        "textBlockQuote.background": h("raised"), "textBlockQuote.border": h("accent"),
        "textCodeBlock.background": h("raised"), "textPreformat.foreground": h("green"),
        "textSeparator.foreground": h("separator"),
        # controls
        "button.background": h("accent"), "button.foreground": h("on_accent"), "button.hoverBackground": h("accent_hi"),
        "button.secondaryBackground": h("raised2"), "button.secondaryForeground": h("text"),
        "button.secondaryHoverBackground": h("separator"), "button.border": clear,
        "checkbox.background": h("raised"), "checkbox.border": h("separator"), "checkbox.foreground": h("text"),
        "dropdown.background": h("raised"), "dropdown.border": h("separator"), "dropdown.foreground": h("text"),
        "dropdown.listBackground": h("raised"),
        "input.background": field, "input.border": h("separator"), "input.foreground": h("text"),
        "input.placeholderForeground": h("text3"), "inputOption.activeBackground": h("accent", 0.30),
        "inputOption.activeBorder": h("accent"), "inputOption.activeForeground": h("text"),
        "inputValidation.errorBackground": h("red", 0.18), "inputValidation.errorBorder": h("red"),
        "inputValidation.warningBackground": h("orange", 0.18), "inputValidation.warningBorder": h("orange"),
        "inputValidation.infoBackground": h("accent", 0.18), "inputValidation.infoBorder": h("accent"),
        "badge.background": h("accent"), "badge.foreground": h("on_accent"), "progressBar.background": h("accent"),
        "scrollbar.shadow": clear, "scrollbarSlider.background": h("text", 0.12),
        "scrollbarSlider.hoverBackground": h("text", 0.22), "scrollbarSlider.activeBackground": h("text", 0.32),
        # lists & trees
        "list.activeSelectionBackground": h("accent"), "list.activeSelectionForeground": h("on_accent"),
        "list.inactiveSelectionBackground": h("raised2"), "list.inactiveSelectionForeground": h("text"),
        "list.hoverBackground": h("text", 0.06), "list.focusBackground": h("accent", 0.70),
        "list.focusForeground": h("on_accent"), "list.highlightForeground": h("accent_hi"),
        "list.errorForeground": h("red"), "list.warningForeground": h("orange"),
        "list.dropBackground": h("accent", 0.30), "tree.indentGuidesStroke": h("separator"),
        # window chrome
        "activityBar.background": chrome, "activityBar.foreground": h("text"), "activityBar.inactiveForeground": h("text3"),
        "activityBar.border": h("separator", 0.6), "activityBar.activeBorder": h("accent"),
        "activityBarBadge.background": h("accent"), "activityBarBadge.foreground": h("on_accent"),
        "sideBar.background": chrome, "sideBar.foreground": h("text2"), "sideBar.border": h("separator", 0.6),
        "sideBarTitle.foreground": h("text"), "sideBarSectionHeader.background": h("raised", 0.6),
        "sideBarSectionHeader.foreground": h("text2"), "sideBarSectionHeader.border": clear,
        "titleBar.activeBackground": chrome, "titleBar.activeForeground": h("text"),
        "titleBar.inactiveBackground": chrome, "titleBar.inactiveForeground": h("text3"),
        "titleBar.border": h("separator", 0.6),
        "menu.background": h("raised"), "menu.foreground": h("text"), "menu.selectionBackground": h("accent"),
        "menu.selectionForeground": h("on_accent"), "menu.separatorBackground": h("separator"),
        "menu.border": h("separator"), "menubar.selectionBackground": h("text", 0.10),
        "statusBar.background": chrome, "statusBar.foreground": h("text2"), "statusBar.border": h("separator", 0.6),
        "statusBar.noFolderBackground": h("raised"), "statusBar.debuggingBackground": h("orange"),
        "statusBar.debuggingForeground": h("bg"), "statusBarItem.hoverBackground": h("text", 0.10),
        "statusBarItem.remoteBackground": h("accent"), "statusBarItem.remoteForeground": h("on_accent"),
        "statusBarItem.prominentBackground": h("raised2"),
        "notifications.background": h("raised"), "notifications.foreground": h("text"), "notifications.border": h("separator"),
        "notificationLink.foreground": h("accent_hi"), "notificationCenterHeader.background": h("raised2"),
        "notificationToast.border": h("separator"),
        "quickInput.background": h("raised"), "quickInput.foreground": h("text"),
        "quickInputList.focusBackground": h("accent"), "quickInputList.focusForeground": h("on_accent"),
        "quickInputTitle.background": h("raised2"), "pickerGroup.foreground": h("accent_hi"),
        "pickerGroup.border": h("separator"),
        "extensionButton.prominentBackground": h("accent"), "extensionButton.prominentForeground": h("on_accent"),
        "extensionButton.prominentHoverBackground": h("accent_hi"),
        "welcomePage.tileBackground": h("raised"), "walkThrough.embeddedEditorBackground": chrome,
        # tabs & groups
        "editorGroupHeader.tabsBackground": chrome, "editorGroupHeader.tabsBorder": h("separator", 0.6),
        "editorGroup.border": h("separator"), "editorGroup.dropBackground": h("accent", 0.20),
        "tab.activeBackground": base, "tab.activeForeground": h("text"), "tab.inactiveBackground": chrome,
        "tab.inactiveForeground": h("text3"), "tab.border": chrome, "tab.activeBorderTop": h("accent"),
        "tab.hoverBackground": h("raised"), "tab.unfocusedActiveForeground": h("text2"),
        "tab.unfocusedInactiveForeground": h("text3"), "tab.lastPinnedBorder": h("separator"),
        "breadcrumb.foreground": h("text3"), "breadcrumb.focusForeground": h("text"),
        "breadcrumb.activeSelectionForeground": h("accent_hi"), "breadcrumbPicker.background": h("raised"),
        # panel / terminal
        "panel.background": chrome, "panel.border": h("separator", 0.6), "panelTitle.activeForeground": h("text"),
        "panelTitle.activeBorder": h("accent"), "panelTitle.inactiveForeground": h("text3"),
        "terminal.background": h("ansi_term_bg"), "terminal.foreground": h("ansi_term_fg"),
        "terminalCursor.foreground": h("accent"), "terminal.selectionBackground": h("accent", 0.35),
        "terminal.ansiBlack": h("ansi_black"), "terminal.ansiRed": h("ansi_red"), "terminal.ansiGreen": h("ansi_green"),
        "terminal.ansiYellow": h("ansi_yellow"), "terminal.ansiBlue": h("ansi_blue"), "terminal.ansiMagenta": h("ansi_magenta"),
        "terminal.ansiCyan": h("ansi_cyan"), "terminal.ansiWhite": h("ansi_white"),
        "terminal.ansiBrightBlack": h("ansi_bblack"), "terminal.ansiBrightRed": h("ansi_bred"),
        "terminal.ansiBrightGreen": h("ansi_bgreen"), "terminal.ansiBrightYellow": h("ansi_byellow"),
        "terminal.ansiBrightBlue": h("ansi_bblue"), "terminal.ansiBrightMagenta": h("ansi_bmagenta"),
        "terminal.ansiBrightCyan": h("ansi_bcyan"), "terminal.ansiBrightWhite": h("ansi_bwhite"),
        # editor
        "editor.background": base, "editor.foreground": h("text"),
        "editorLineNumber.foreground": h("text3", lighten=-0.12 if dark else 0.12), "editorLineNumber.activeForeground": h("accent_hi"),
        "editorCursor.foreground": h("accent"), "editor.selectionBackground": h("accent", 0.35),
        "editor.inactiveSelectionBackground": h("accent", 0.18), "editor.selectionHighlightBackground": h("accent", 0.18),
        "editor.wordHighlightBackground": h("accent", 0.20), "editor.wordHighlightStrongBackground": h("orange", 0.25),
        "editor.findMatchBackground": h("orange", 0.50), "editor.findMatchHighlightBackground": h("yellow", 0.30),
        "editor.findRangeHighlightBackground": h("accent", 0.12), "editor.hoverHighlightBackground": h("accent", 0.15),
        "editor.lineHighlightBackground": h("text", 0.05), "editor.lineHighlightBorder": clear,
        "editor.foldBackground": h("accent", 0.10), "editor.rangeHighlightBackground": h("accent", 0.10),
        "editorWhitespace.foreground": h("separator"), "editorIndentGuide.background1": h("separator", 0.7),
        "editorIndentGuide.activeBackground1": h("text3"), "editorRuler.foreground": h("separator"),
        "editorBracketMatch.background": h("accent", 0.25), "editorBracketMatch.border": h("accent"),
        "editorBracketHighlight.foreground1": h("accent_hi"), "editorBracketHighlight.foreground2": h("purple"),
        "editorBracketHighlight.foreground3": h("teal"), "editorBracketHighlight.foreground4": h("green"),
        "editorBracketHighlight.foreground5": h("orange"), "editorBracketHighlight.foreground6": h("pink"),
        "editorBracketHighlight.unexpectedBracket.foreground": h("red"),
        "editorCodeLens.foreground": h("text3"), "editorLink.activeForeground": h("accent_hi"),
        "editorInlayHint.background": h("text", 0.08), "editorInlayHint.foreground": h("text3"),
        "editorGutter.background": base, "editorGutter.modifiedBackground": h("accent"),
        "editorGutter.addedBackground": h("green"), "editorGutter.deletedBackground": h("red"),
        "editorOverviewRuler.border": clear, "editorOverviewRuler.errorForeground": h("red"),
        "editorOverviewRuler.warningForeground": h("orange"), "editorOverviewRuler.infoForeground": h("accent_hi"),
        "editorError.foreground": h("red"), "editorWarning.foreground": h("orange"),
        "editorInfo.foreground": h("accent_hi"), "editorHint.foreground": h("teal"),
        "editorWidget.background": h("raised"), "editorWidget.border": h("separator"),
        "editorWidget.foreground": h("text"), "editorSuggestWidget.background": h("raised"),
        "editorSuggestWidget.border": h("separator"), "editorSuggestWidget.foreground": h("text"),
        "editorSuggestWidget.selectedBackground": h("accent"), "editorSuggestWidget.selectedForeground": h("on_accent"),
        "editorSuggestWidget.highlightForeground": h("accent_hi"), "editorHoverWidget.background": h("raised"),
        "editorHoverWidget.border": h("separator"), "editorStickyScroll.background": chrome,
        "peekView.border": h("accent"), "peekViewEditor.background": h("raised"), "peekViewResult.background": chrome,
        "peekViewTitle.background": h("raised"), "peekViewTitleLabel.foreground": h("text"),
        "peekViewEditor.matchHighlightBackground": h("orange", 0.35), "peekViewResult.matchHighlightBackground": h("orange", 0.35),
        "diffEditor.insertedTextBackground": h("green", 0.20), "diffEditor.removedTextBackground": h("red", 0.20),
        "diffEditor.insertedLineBackground": h("green", 0.12), "diffEditor.removedLineBackground": h("red", 0.12),
        "merge.currentHeaderBackground": h("accent", 0.35), "merge.incomingHeaderBackground": h("green", 0.35),
        "minimap.background": clear, "minimap.selectionHighlight": h("accent", 0.5),
        "minimapSlider.background": h("text", 0.08), "minimapSlider.hoverBackground": h("text", 0.14),
        "minimapSlider.activeBackground": h("text", 0.20), "minimapGutter.addedBackground": h("green"),
        "minimapGutter.modifiedBackground": h("accent"), "minimapGutter.deletedBackground": h("red"),
        # scm / explorer
        "gitDecoration.addedResourceForeground": h("green"), "gitDecoration.modifiedResourceForeground": h("accent_hi"),
        "gitDecoration.deletedResourceForeground": h("red"), "gitDecoration.untrackedResourceForeground": h("teal"),
        "gitDecoration.ignoredResourceForeground": h("text3"), "gitDecoration.conflictingResourceForeground": h("orange"),
        "gitDecoration.submoduleResourceForeground": h("purple"),
        "debugToolBar.background": h("raised"), "debugIcon.breakpointForeground": h("red"),
        "debugIcon.startForeground": h("green"), "debugIcon.pauseForeground": h("orange"),
        "debugIcon.stopForeground": h("red"),
    }

    def tok(name, scope, fg=None, style=None):
        s: dict = {}
        if fg:
            s["foreground"] = h(fg) if fg in col else fg
        if style:
            s["fontStyle"] = style
        return {"name": name, "scope": scope, "settings": s}

    param = "#" + F.f_hex(F.mix(col["orange"], col["text"], 0.35))
    prop = "#" + F.f_hex(F.mix(col["indigo"], col["text"], 0.0 if not dark else 0.35))
    tokens = [
        tok("Comment", ["comment", "punctuation.definition.comment"], "text3", "italic"),
        tok("String", ["string", "string.quoted", "punctuation.definition.string"], "green"),
        tok("Regex", ["string.regexp"], "pink"),
        tok("Escape / special string", ["constant.character.escape", "string.interpolated punctuation", "punctuation.section.embedded"], "teal"),
        tok("Number / constant", ["constant.numeric", "constant.language", "constant.character", "support.constant", "variable.other.constant", "constant.other"], "orange"),
        tok("Keyword", ["keyword", "keyword.control", "storage", "storage.type", "storage.modifier", "keyword.other"], "purple"),
        tok("Import keyword", ["keyword.control.import", "keyword.control.from", "keyword.control.export", "keyword.control.default"], "pink"),
        tok("Operator", ["keyword.operator", "punctuation.separator", "punctuation.accessor"], "text2"),
        tok("Function", ["entity.name.function", "support.function", "meta.function-call entity.name.function", "meta.method-call"], "accent_hi"),
        tok("Type / class", ["entity.name.type", "entity.name.class", "support.type", "support.class", "entity.other.inherited-class", "storage.type.class"], "teal"),
        tok("Namespace", ["entity.name.namespace", "entity.name.module", "support.module"], "teal"),
        tok("Variable", ["variable", "variable.other"], "text"),
        tok("Parameter", ["variable.parameter", "meta.parameters variable"], param),
        tok("this / self", ["variable.language", "variable.language.this", "variable.language.self"], "red", "italic"),
        tok("Property", ["variable.other.property", "variable.other.object.property", "support.type.property-name", "meta.object-literal.key", "entity.name.tag.yaml"], prop),
        tok("Tag", ["entity.name.tag", "punctuation.definition.tag"], "pink"),
        tok("Attribute", ["entity.other.attribute-name"], "orange"),
        tok("Decorator", ["meta.decorator", "entity.name.function.decorator", "punctuation.decorator", "storage.type.annotation"], "pink"),
        tok("CSS property", ["support.type.property-name.css", "meta.property-name.css"], "teal"),
        tok("CSS selector class", ["entity.other.attribute-name.class.css", "entity.other.attribute-name.id.css"], "orange"),
        tok("Punctuation", ["punctuation", "meta.brace", "meta.delimiter"], "text2"),
        tok("Heading", ["markup.heading", "entity.name.section"], "accent_hi", "bold"),
        tok("Bold", ["markup.bold"], None, "bold"), tok("Italic", ["markup.italic"], None, "italic"),
        tok("Markup code", ["markup.inline.raw", "markup.fenced_code", "markup.raw"], "green"),
        tok("Markup link", ["markup.underline.link", "string.other.link"], "accent_hi"),
        tok("Markup quote", ["markup.quote"], "text3", "italic"),
        tok("Diff added", ["markup.inserted", "meta.diff.header.to-file"], "green"),
        tok("Diff removed", ["markup.deleted", "meta.diff.header.from-file"], "red"),
        tok("Invalid", ["invalid", "invalid.illegal"], "red"),
    ]
    semantic = {
        "namespace": h("teal"), "class": h("teal"), "struct": h("teal"), "enum": h("teal"), "interface": {"foreground": h("teal"), "italic": True},
        "type": h("teal"), "typeParameter": {"foreground": h("teal"), "italic": True}, "function": h("accent_hi"),
        "method": h("accent_hi"), "macro": h("pink"), "decorator": h("pink"), "variable": h("text"), "parameter": param,
        "property": prop, "enumMember": h("orange"), "variable.readonly": h("orange"), "variable.defaultLibrary": {"foreground": h("red"), "italic": True},
        "*.deprecated": {"strikethrough": True},
    }
    return {"name": t["meta"]["name"], "type": "dark" if dark else "light", "semanticHighlighting": True,
            "colors": c, "tokenColors": tokens, "semanticTokenColors": semantic}


def build_extension(t: dict, out: Path) -> Path:
    """Write the extension dir and a .vsix; returns the .vsix path."""
    m = t["meta"]
    ident = f"themeforge-{m['slug']}"
    ext = out / "vscode" / "extension"
    (ext / "themes").mkdir(parents=True, exist_ok=True)
    theme_file = f"{m['slug']}-color-theme.json"
    (ext / "themes" / theme_file).write_text(json.dumps(build_theme(t), indent=2))
    pkg = {"name": ident, "displayName": m["name"], "description": f"{m['name']} — generated by themeforge",
           "publisher": "themeforge", "version": "1.0.0", "engines": {"vscode": "^1.60.0"}, "categories": ["Themes"],
           "contributes": {"themes": [{"label": m["name"], "uiTheme": "vs-dark" if m["mode"] == "dark" else "vs",
                                       "path": f"./themes/{theme_file}"}]}}
    (ext / "package.json").write_text(json.dumps(pkg, indent=2))
    manifest = f'''<?xml version="1.0" encoding="utf-8"?>
<PackageManifest Version="2.0.0" xmlns="http://schemas.microsoft.com/developer/vsx-schema/2011">
  <Metadata>
    <Identity Language="en-US" Id="{ident}" Version="1.0.0" Publisher="themeforge"/>
    <DisplayName>{m['name']}</DisplayName>
    <Description xml:space="preserve">{m['name']} colour theme generated by themeforge</Description>
    <Categories>Themes</Categories>
    <Properties><Property Id="Microsoft.VisualStudio.Code.Engine" Value="^1.60.0"/></Properties>
  </Metadata>
  <Installation><InstallationTarget Id="Microsoft.VisualStudio.Code"/></Installation>
  <Dependencies/>
  <Assets><Asset Type="Microsoft.VisualStudio.Code.Manifest" Path="extension/package.json" Addressable="true"/></Assets>
</PackageManifest>'''
    ctypes = ('<?xml version="1.0" encoding="utf-8"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/Content-Types">'
              '<Default Extension=".json" ContentType="application/json"/>'
              '<Default Extension=".vsixmanifest" ContentType="text/xml"/></Types>')
    vsix = out / "vscode" / f"{ident}.vsix"
    with zipfile.ZipFile(vsix, "w", zipfile.ZIP_DEFLATED) as z:
        z.writestr("[Content_Types].xml", ctypes)
        z.writestr("extension.vsixmanifest", manifest)
        z.write(ext / "package.json", "extension/package.json")
        z.write(ext / "themes" / theme_file, f"extension/themes/{theme_file}")
    return vsix
