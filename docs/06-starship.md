# 06 · Starship (prompt)

Starship is the prompt engine — it draws the line(s) you type commands into: the
directory, git branch, language versions, exit status, timing. It's a single fast
binary configured by one TOML file, and it works identically in zsh, bash, fish,
nushell, etc.

File: `.config/starship/starship.toml` (symlinked dir → `~/.config/starship/`).
A backup of the previous config is kept at `starship.toml.bak`.

## How Starship gets loaded

Starship only runs if two things are true (both handled in
[`.zshrc`](05-zsh.md#-init-ordering-matters)):

```zsh
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"  # non-default path!
eval "$(starship init zsh)"                                    # turn it on, last
```

⚠️ The `STARSHIP_CONFIG` export is essential: this repo stores the config at
`.config/starship/starship.toml` (in a subdirectory), but Starship's *default*
location is `~/.config/starship.toml` (a bare file). Without the env var, Starship
finds no config and uses its built-in defaults — the classic "my fancy prompt
vanished" symptom.

## The core idea: format strings

Starship builds the prompt from **modules** (`$directory`, `$git_branch`,
`$character`, …). You arrange them with two strings:

- `format` — the **left** side, rendered top-to-bottom.
- `right_format` — the **right** side of the same line.

Each module has its own `[module]` table controlling its text, color, and symbol.

### This config's prompt shape

```toml
add_newline = false        # no blank line between prompts (tight, like the screenshot)

format = """\
$directory\               # the blue path
$git_status\              # pink ! ? + flags
$cmd_duration\            # "took 3s" if a command was slow
$line_break\              # ← drop to a second line
$character\               # the → arrow
"""

right_format = """${custom.git_branch_right}"""   # the far-right "⑂ main"
```

The trailing `\` on each line is a **line-continuation**: it joins the lines into
one string *without* inserting a newline. The only real newline is `$line_break`,
which is what puts the `→` arrow alone on the second line.

## Module-by-module

### `[directory]` — the blue path

```toml
[directory]
format = "[$path](bold fg:#8be9fd) "   # #8be9fd = cyan-blue
truncate_to_repo = false               # show full ~/path, not just repo root
truncation_length = 4
home_symbol = "~"
```

### `[character]` — the arrow

```toml
[character]
success_symbol = "[→](bold #a6e3a1)"   # green when last command succeeded
error_symbol   = "[→](bold #f38ba8)"   # red/pink when it failed
vimcmd_symbol  = "[←](bold #f9e2af)"   # yellow in vi-normal mode
```

The color of the arrow is a live status indicator: green = OK, red = the last
command exited non-zero. Quick at-a-glance feedback.

### `[git_status]` — the change flags

```toml
[git_status]
format = '[$all_status$ahead_behind](fg:#f5c2e7) '
modified = '!${count}'   # !14  = 14 modified files
untracked = '?${count}'  # ?9   = 9 untracked
staged = '+${count}'
ahead = '⇡${count}'      # commits ahead of upstream
behind = '⇣${count}'
```

So a prompt reading `~/dotfiles  !14?9` means: in dotfiles, 14 modified and 9
untracked files.

### `[cmd_duration]` — slow-command timer

```toml
[cmd_duration]
min_time = 2000                              # only show if > 2 seconds
format = "[ took $duration](fg:#fab387) "
```

### `${custom.git_branch_right}` — the right-aligned branch

This is the `⑂ main` on the far right. Starship's built-in `git_branch` can't be
placed twice, so a **custom module** runs `git branch --show-current` and renders it:

```toml
[custom.git_branch_right]
command = "git branch --show-current 2>/dev/null"
when    = "git rev-parse --is-inside-work-tree 2>/dev/null"   # only inside a repo
format  = "[⑂ $output](bold fg:#cba6f7)"                      # mauve/purple
shell   = ["bash", "--noprofile", "--norc"]
```

It only appears when you're inside a git work tree (the `when` guard).

## The color palette (Catppuccin Mocha-ish)

| Hex | Role | Where |
|---|---|---|
| `#8be9fd` | cyan-blue | directory path |
| `#a6e3a1` | green | success arrow |
| `#f38ba8` | red | error arrow |
| `#f5c2e7` | pink | git status flags |
| `#fab387` | peach | command duration |
| `#cba6f7` | mauve | right-side git branch |

These are hard-coded (not wallbash-driven), so the prompt stays consistent across
theme switches. If you want the prompt to follow the wallpaper too, you'd template
it via a `.dcol` — but the current intent is a stable prompt identity.

## Testing changes without breaking your shell

```bash
# Does the config parse? (no output / no error = good)
STARSHIP_CONFIG=~/.config/starship/starship.toml starship config

# Render the prompt as it'll look (run inside a git repo to see git modules):
cd ~/dotfiles && starship prompt
```

`right_format` won't show in `starship prompt` output (that subcommand renders the
left side only) — it appears live in the terminal.

## Common tasks

**"Add Python/Node version display."** Add the module to `format` (e.g.
`$python$nodejs` before `$character`) and configure `[python]` / `[nodejs]`. The old
config (`starship.toml.bak`) has ready-made language module blocks to copy from.

**"Move git branch back to the left."** Put `$git_branch` in `format`, configure
`[git_branch]`, and remove the `custom.git_branch_right` from `right_format`.

**"Prompt is plain default."** → see the `STARSHIP_CONFIG` note above; almost always
the cause.

🔗 Starship config: https://starship.rs/config/
