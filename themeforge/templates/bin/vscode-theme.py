#!/usr/bin/env python3
"""Set "workbench.colorTheme" in VS Code-family settings.json files with a minimal text edit
(keeps comments/formatting). Usage: vscode-theme.py "<Theme Name>" """
import re
import sys
from pathlib import Path

name = sys.argv[1]
cfg = Path.home() / ".config"
for app in ("Code", "Code - Insiders", "VSCodium", "Cursor"):
    f = cfg / app / "User" / "settings.json"
    if not f.is_file():
        continue
    text = f.read_text()
    new = f'"workbench.colorTheme": "{name}"'
    if re.search(r'"workbench\.colorTheme"\s*:\s*"[^"]*"', text):
        out = re.sub(r'"workbench\.colorTheme"\s*:\s*"[^"]*"', new, text, count=1)
    else:
        i = text.find("{")
        if i < 0:
            continue
        out = text[: i + 1] + f"\n    {new}," + text[i + 1 :]
    if out != text:
        tmp = f.with_suffix(".json.tmp")
        tmp.write_text(out)
        tmp.replace(f)
        print(f"[themeforge] {app}: color theme → {name}")
