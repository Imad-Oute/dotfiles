# Complete keybind and shortcut inventory

Snapshot: 2026-11-15. Extracted from this machine’s active Hyprland and tmux key tables, a fresh Neovim runtime, installed application defaults, and personal configuration. This is a migration reference for a separate Arch + Caelestia installation; it does not modify the current desktop.

## Contents

- [Migration to Caelestia](#migration-to-caelestia)
- [Active OS / Hyprland / HyDE bindings](#active-os--hyprland--hyde-bindings)
- [Exact HyDE implementations and overrides](#exact-hyde-implementations-and-overrides)
- [tmux](#tmux)
- [Kitty](#kitty)
- [Neovim live mappings](#neovim--live-global-mappings)
- [Neovim custom configuration](#neovim-custom-configuration-and-enabled-extras)
- [Neovim context-specific plugin mappings](#neovim-context-specific-installed-plugin-mappings)
- [Neovim built-in commands](#neovim-built-in-commands)
- [Shell and command shortcuts](#shell-and-command-shortcuts)
- [Desktop mouse/menu actions](#desktop-mousemenu-actions-and-other-configured-shortcuts)
- [Legacy Hyprland bindings](#legacy-hyprland-conf-bindings)
- [HyDE menu-local shortcuts](#hyde-menu-local-shortcuts-and-supporting-settings)
- [fzf](#fzf-installed-zsh-key-integration)
- [Lazygit](#lazygit-installed-default-shortcuts)
- [Coverage limits](#other-application-coverage)

## Reading this document

`Super` is the Windows/Meta key. `Ctrl`, `Alt`, `Shift` are held together with the final key; comma-separated Vim notation is sequential. Neovim `<leader>` is Space and `<localleader>` is backslash. `<M-x>` means Alt+x. tmux `prefix` is Ctrl+Space: release it, then press the next key. Uppercase letters require Shift. Mouse 272/273 mean left/right button.

The active runtime tables are the authority for currently registered desktop/tmux bindings. Source snapshots preserve exact implementations and settings for migration. Lua dispatcher arguments shown as numbers are internal callback IDs, not reusable shell commands: use the corresponding Lua source/action description instead.

This captures locally discoverable configured shortcuts, installed defaults for the core terminal/editor stack, and context-specific plugin definitions. No finite startup export includes every application’s built-in commands or every dynamically attached LSP/filetype mapping. Contextual source sections below cover those definitions; Neovim’s complete built-in command index is included separately. Browser, IDE, and GUI application factory defaults are outside the desktop key table. Missing plugins and historical configs are explicitly distinguished rather than assumed active.

## Migration to Caelestia

1. Recreate desktop combinations from the active table below in the new compositor configuration. Keep one owner per combination; review Caelestia’s existing bindings before adding duplicates.
2. Keep native window/workspace actions as compositor dispatchers. Translate Lua `hl.dsp.*` actions into the API/configuration supported by the new installation; these Lua files depend on this HyDE build.
3. Replace `hyde-shell` menu, wallpaper, lock, logout, screenshot, clipboard, audio, brightness, and bar actions with the matching Caelestia actions, or install their HyDE scripts and dependencies deliberately. These commands are not provided by plain Arch or by copying a keybind.
4. Preserve `~/.tmux.conf`, its plugin versions, `~/.config/kitty`, and the complete `~/.config/nvim` including `lazy-lock.json`, `lazyvim.json`, and custom Lua. Key names alone do not recreate callbacks, plugin settings, sessions, LSPs, formatters, or completion behavior.
5. Install tools referenced by the bindings: kitty, zsh, tmux, Neovim, wl-clipboard (`wl-copy`/`wl-paste`), cliphist, rofi, jq, playerctl, hyprpicker, the chosen screenshot/brightness/audio tools, fzf, fd, ripgrep, zoxide, eza, bat, lazygit, lazydocker, and the configured browser/editor/file manager. HyDE scratchpad terminal additionally needs Pyprland configuration. Font: CaskaydiaCove Nerd Font Mono.
6. Preserve terminal key delivery: Ctrl+Space is consumed by tmux; Ctrl+H/J/K/L bridge tmux and Neovim; Ctrl+Shift combinations may be intercepted by Kitty; compositor bindings take priority over focused apps. Verify these layers in order after installation.

## Active OS / Hyprland / HyDE bindings

Flags: `locked` works while input is inhibited/locked; `repeat` repeats while held; `release` fires on release; `mouse` starts a drag; transparent/non-consuming flags permit propagation where supported. Blank flags mean ordinary key press. Submap is shown when applicable.


Captured **164** active binding entries.

| Shortcut | Action | Flags | Submap | Dispatcher / callback |
|---|---|---|---|---|

| Super+T | [Launcher&#124;Apps] terminal emulator |  |  | HL.Dispatcher(exec_cmd) 8 |

| Super+Alt+T | [Launcher&#124;Apps] dropdown terminal |  |  | HL.Dispatcher(exec_cmd) 11 |

| Super+E | [Launcher&#124;Apps] file explorer |  |  | HL.Dispatcher(exec_cmd) 14 |

| Super+B | [Launcher&#124;Apps] browser |  |  | HL.Dispatcher(exec_cmd) 17 |

| Super+C | [Launcher&#124;Apps] text editor |  |  | HL.Dispatcher(exec_cmd) 20 |

| Ctrl+Shift+ESCAPE | [Launcher&#124;Apps] system monitor |  |  | HL.Dispatcher(exec_cmd) 23 |

| Super+Q | [Window Management] close focused window |  |  | HL.Dispatcher(close) 26 |

| Alt+F4 | [Window Management] close focused window |  |  | HL.Dispatcher(close) 29 |

| Super+Alt+F4 | [Window Management] kill focused window |  |  | HL.Dispatcher(kill) 32 |

| Super+Delete | [Window Management] exit hyprland session |  |  | HL.Dispatcher(exit) 35 |

| Super+W | [Window Management] toggle float true |  |  | HL.Dispatcher(float) 38 |

| Super+G | [Window Management] toggle group |  |  | HL.Dispatcher(toggle) 41 |

| Alt+P | [Window Management] set a window’s pseudotiling state |  |  | HL.Dispatcher(pseudo) 44 |

| Shift+F11 | [Window Management] cycle fullscreen |  |  | function: 0x564925b75940 45 |

| Super+Shift+F | [Window Management] toggle pin |  |  | HL.Dispatcher(exec_cmd) 48 |

| Ctrl+Alt+DELETE | [Window Management] logout menu |  |  | HL.Dispatcher(exec_cmd) 51 |

| Super+L | [Window Management] lock session |  |  | HL.Dispatcher(exec_cmd) 57 |

| Super+Ctrl+H | [Window Management&#124;Group Navigation] change active group backwards |  |  | HL.Dispatcher(prev) 60 |

| Super+Ctrl+L | [Window Management&#124;Group Navigation] change active group forwards |  |  | HL.Dispatcher(next) 63 |

| Super+Left | [Window Management&#124;Change focus] focus left |  |  | HL.Dispatcher(focus) 66 |

| Super+Right | [Window Management&#124;Change focus] focus right |  |  | HL.Dispatcher(focus) 6 |

| Super+Up | [Window Management&#124;Change focus] focus up |  |  | HL.Dispatcher(focus) 10 |

| Super+Down | [Window Management&#124;Change focus] focus down |  |  | HL.Dispatcher(focus) 15 |

| Alt+TAB | [Window Management&#124;alt-tab window switcher] cycle next |  |  | HL.Dispatcher(exec_cmd) 19 |

| Alt+Shift+TAB | [Window Management&#124;alt-tab window switcher] cycle previous |  |  | HL.Dispatcher(exec_cmd) 24 |

| Alt+ALT_R | [Window Management&#124;alt-tab window switcher] switch | release |  | HL.Dispatcher(exec_cmd) 28 |

| Alt+ALT_L | [Window Management&#124;alt-tab window switcher] switch | release |  | HL.Dispatcher(exec_cmd) 33 |

| Super+Shift+RIGHT | [Window Management&#124;Resize Active Window] resize window right | repeat |  | HL.Dispatcher(resize) 40 |

| Super+Shift+LEFT | [Window Management&#124;Resize Active Window] resize window left | repeat |  | HL.Dispatcher(resize) 69 |

| Super+Shift+UP | [Window Management&#124;Resize Active Window] resize window up | repeat |  | HL.Dispatcher(resize) 72 |

| Super+Shift+DOWN | [Window Management&#124;Resize Active Window] resize window down | repeat |  | HL.Dispatcher(resize) 75 |

| Super+Ctrl+Shift+LEFT | [Window Management&#124;Move active window] left | repeat |  | function: 0x5649248c65c0 76 |

| Super+Ctrl+Shift+RIGHT | [Window Management&#124;Move active window] right | repeat |  | function: 0x5649248a2630 77 |

| Super+Ctrl+Shift+UP | [Window Management&#124;Move active window] up | repeat |  | function: 0x5649248d1b50 78 |

| Super+Ctrl+Shift+DOWN | [Window Management&#124;Move active window] down | repeat |  | function: 0x5649248d36f0 79 |

| Super+mouse:272 | [Window Management&#124;Drag & Resize with mouse] drag window | mouse |  | HL.Dispatcher(drag) 82 |

| Super+mouse:273 | [Window Management&#124;Drag & Resize with mouse] resize window | mouse |  | HL.Dispatcher(resize) 85 |

| Super+Z | [Window Management&#124;Drag & Resize with mouse] hold to move window | mouse |  | HL.Dispatcher(drag) 88 |

| Super+X | [Window Management&#124;Drag & Resize with mouse] hold to resize window | mouse |  | HL.Dispatcher(resize) 91 |

| Super+J | [Layout Management&#124;Dwindle] toggle split |  |  | HL.Dispatcher(layout) 94 |

| Super+A | [Launcher&#124;Rofi menus] application finder |  |  | HL.Dispatcher(exec_cmd) 97 |

| Super+TAB | [Launcher&#124;Rofi menus] window switcher |  |  | HL.Dispatcher(exec_cmd) 100 |

| Super+Shift+E | [Launcher&#124;Rofi menus] file finder |  |  | HL.Dispatcher(exec_cmd) 103 |

| Super+slash | [Launcher&#124;Rofi menus] keybindings hint |  |  | HL.Dispatcher(exec_cmd) 106 |

| Super+comma | [Launcher&#124;Rofi menus] emoji picker |  |  | HL.Dispatcher(exec_cmd) 109 |

| Super+period | [Launcher&#124;Rofi menus] glyph picker |  |  | HL.Dispatcher(exec_cmd) 112 |

| Super+V | [Launcher&#124;Rofi menus] clipboard |  |  | HL.Dispatcher(exec_cmd) 115 |

| Super+Shift+V | [Launcher&#124;Rofi menus] clipboard manager |  |  | HL.Dispatcher(exec_cmd) 118 |

| Super+Shift+A | [Launcher&#124;Rofi menus] select rofi launcher |  |  | HL.Dispatcher(exec_cmd) 121 |

| Super+Shift+K | [Launcher&#124;Rofi menus] Calculator |  |  | HL.Dispatcher(exec_cmd) 124 |

| Super+Shift+slash | [Launcher&#124;Rofi menus] Web Search |  |  | HL.Dispatcher(exec_cmd) 127 |

| F10 | [Hardware Controls&#124;Audio] un/mute output | locked |  | HL.Dispatcher(exec_cmd) 130 |

| F11 | [Hardware Controls&#124;Audio] decrease volume | locked, repeat |  | HL.Dispatcher(exec_cmd) 133 |

| F12 | [Hardware Controls&#124;Audio] increase volume | locked, repeat |  | HL.Dispatcher(exec_cmd) 136 |

| XF86AudioMute | [Hardware Controls&#124;Audio] un/mmute output | locked |  | HL.Dispatcher(exec_cmd) 139 |

| XF86AudioMicMute | [Hardware Controls&#124;Audio] un/mute microphone | locked |  | HL.Dispatcher(exec_cmd) 142 |

| XF86AudioLowerVolume | [Hardware Controls&#124;Audio] decrease volume | locked, repeat |  | HL.Dispatcher(exec_cmd) 145 |

| XF86AudioRaiseVolume | [Hardware Controls&#124;Audio] increase volume | locked, repeat |  | HL.Dispatcher(exec_cmd) 148 |

| XF86AudioPlay | [Hardware Controls&#124;Media] play media | locked |  | HL.Dispatcher(exec_cmd) 151 |

| XF86AudioPause | [Hardware Controls&#124;Media] pause media | locked |  | HL.Dispatcher(exec_cmd) 154 |

| XF86AudioNext | [Hardware Controls&#124;Media] next media | locked |  | HL.Dispatcher(exec_cmd) 157 |

| XF86AudioPrev | [Hardware Controls&#124;Media] previous media | locked |  | HL.Dispatcher(exec_cmd) 160 |

| Super+Ctrl+M | [Hardware Controls&#124;Media] toggle un/mute for active-window |  |  | HL.Dispatcher(exec_cmd) 163 |

| XF86MonBrightnessUp | [Hardware Controls&#124;Brightness] increase brightness | locked, repeat |  | HL.Dispatcher(exec_cmd) 166 |

| XF86MonBrightnessDown | [Hardware Controls&#124;Brightness] decrease brightness | locked, repeat |  | HL.Dispatcher(exec_cmd) 169 |

| Super+K | [Utilities] toggle keyboard layout | locked |  | HL.Dispatcher(exec_cmd) 172 |

| Super+Alt+G | [Utilities] game mode | locked |  | HL.Dispatcher(exec_cmd) 175 |

| Super+Shift+G | [Utilities] game launcher |  |  | HL.Dispatcher(exec_cmd) 178 |

| Super+Shift+P | [Utilities] screen capture] color picker | locked |  | HL.Dispatcher(exec_cmd) 181 |

| Super+P | [Utilities] partial screenshot capture | locked |  | HL.Dispatcher(exec_cmd) 184 |

| Super+Ctrl+P | [Utilities] freeze and snip screen | locked |  | HL.Dispatcher(exec_cmd) 187 |

| Super+Alt+P | [Utilities] print monitor | locked |  | HL.Dispatcher(exec_cmd) 190 |

| Print | [Utilities] print all monitors | locked |  | HL.Dispatcher(exec_cmd) 193 |

| Super+Ctrl+S | [Utilities] OCR scanner | locked |  | HL.Dispatcher(exec_cmd) 196 |

| Super+Alt+Right | [Theming and Wallpaper] next global wallpaper |  |  | HL.Dispatcher(exec_cmd) 199 |

| Super+Alt+Left | [Theming and Wallpaper] previous global wallpaper |  |  | HL.Dispatcher(exec_cmd) 202 |

| Super+Alt+Up | [Theming and Wallpaper] next Waybar layout |  |  | HL.Dispatcher(exec_cmd) 205 |

| Super+Alt+Down | [Theming and Wallpaper] previous Waybar layout |  |  | HL.Dispatcher(exec_cmd) 208 |

| Super+Shift+W | [Theming and Wallpaper] select a global wallpaper |  |  | HL.Dispatcher(exec_cmd) 211 |

| Super+Shift+R | [Theming and Wallpaper] wallbash mode selector |  |  | HL.Dispatcher(exec_cmd) 214 |

| Super+Shift+T | [Theming and Wallpaper] select a theme |  |  | HL.Dispatcher(exec_cmd) 217 |

| Super+Shift+Y | [Theming and Wallpaper] select animations |  |  | HL.Dispatcher(exec_cmd) 220 |

| Super+Shift+U | [Theming and Wallpaper] select Hyprlock layout |  |  | HL.Dispatcher(exec_cmd) 223 |

| Super+1 | [Workspaces&#124;Navigation] navigate to workspace 1 |  |  | HL.Dispatcher(focus) 226 |

| Super+2 | [Workspaces&#124;Navigation] navigate to workspace 2 |  |  | HL.Dispatcher(focus) 229 |

| Super+3 | [Workspaces&#124;Navigation] navigate to workspace 3 |  |  | HL.Dispatcher(focus) 232 |

| Super+4 | [Workspaces&#124;Navigation] navigate to workspace 4 |  |  | HL.Dispatcher(focus) 235 |

| Super+5 | [Workspaces&#124;Navigation] navigate to workspace 5 |  |  | HL.Dispatcher(focus) 238 |

| Super+6 | [Workspaces&#124;Navigation] navigate to workspace 6 |  |  | HL.Dispatcher(focus) 241 |

| Super+7 | [Workspaces&#124;Navigation] navigate to workspace 7 |  |  | HL.Dispatcher(focus) 244 |

| Super+8 | [Workspaces&#124;Navigation] navigate to workspace 8 |  |  | HL.Dispatcher(focus) 247 |

| Super+9 | [Workspaces&#124;Navigation] navigate to workspace 9 |  |  | HL.Dispatcher(focus) 250 |

| Super+0 | [Workspaces&#124;Navigation] navigate to workspace 10 |  |  | HL.Dispatcher(focus) 253 |

| Super+KP_1 | [Workspaces&#124;Navigation] navigate to workspace 11 |  |  | HL.Dispatcher(focus) 256 |

| Super+KP_End | [Workspaces&#124;Navigation] navigate to workspace 11 |  |  | HL.Dispatcher(focus) 259 |

| Super+KP_2 | [Workspaces&#124;Navigation] navigate to workspace 12 |  |  | HL.Dispatcher(focus) 262 |

| Super+KP_Down | [Workspaces&#124;Navigation] navigate to workspace 12 |  |  | HL.Dispatcher(focus) 265 |

| Super+KP_3 | [Workspaces&#124;Navigation] navigate to workspace 13 |  |  | HL.Dispatcher(focus) 268 |

| Super+KP_Next | [Workspaces&#124;Navigation] navigate to workspace 13 |  |  | HL.Dispatcher(focus) 271 |

| Super+KP_4 | [Workspaces&#124;Navigation] navigate to workspace 14 |  |  | HL.Dispatcher(focus) 274 |

| Super+KP_Left | [Workspaces&#124;Navigation] navigate to workspace 14 |  |  | HL.Dispatcher(focus) 277 |

| Super+KP_5 | [Workspaces&#124;Navigation] navigate to workspace 15 |  |  | HL.Dispatcher(focus) 280 |

| Super+KP_Begin | [Workspaces&#124;Navigation] navigate to workspace 15 |  |  | HL.Dispatcher(focus) 283 |

| Super+KP_6 | [Workspaces&#124;Navigation] navigate to workspace 16 |  |  | HL.Dispatcher(focus) 286 |

| Super+KP_Right | [Workspaces&#124;Navigation] navigate to workspace 16 |  |  | HL.Dispatcher(focus) 289 |

| Super+KP_7 | [Workspaces&#124;Navigation] navigate to workspace 17 |  |  | HL.Dispatcher(focus) 292 |

| Super+KP_Home | [Workspaces&#124;Navigation] navigate to workspace 17 |  |  | HL.Dispatcher(focus) 295 |

| Super+KP_8 | [Workspaces&#124;Navigation] navigate to workspace 18 |  |  | HL.Dispatcher(focus) 298 |

| Super+KP_Up | [Workspaces&#124;Navigation] navigate to workspace 18 |  |  | HL.Dispatcher(focus) 301 |

| Super+KP_9 | [Workspaces&#124;Navigation] navigate to workspace 19 |  |  | HL.Dispatcher(focus) 304 |

| Super+KP_Prior | [Workspaces&#124;Navigation] navigate to workspace 19 |  |  | HL.Dispatcher(focus) 307 |

| Super+KP_0 | [Workspaces&#124;Navigation] navigate to workspace 20 |  |  | HL.Dispatcher(focus) 310 |

| Super+KP_Insert | [Workspaces&#124;Navigation] navigate to workspace 20 |  |  | HL.Dispatcher(focus) 313 |

| Super+Ctrl+RIGHT | [Workspaces&#124;Navigation&#124;Relative workspace] change active workspace forwards |  |  | HL.Dispatcher(focus) 316 |

| Super+Ctrl+LEFT | [Workspaces&#124;Navigation&#124;Relative workspace] change active workspace backwards |  |  | HL.Dispatcher(focus) 319 |

| Super+Ctrl+DOWN | [Workspaces&#124;Navigation] navigate to the nearest empty workspace |  |  | HL.Dispatcher(focus) 322 |

| Super+Shift+1 | [Workspaces&#124;Move window to workspace] move focused window to workspace 1 |  |  | HL.Dispatcher(move) 325 |

| Super+Shift+2 | [Workspaces&#124;Move window to workspace] move focused window to workspace 2 |  |  | HL.Dispatcher(move) 328 |

| Super+Shift+3 | [Workspaces&#124;Move window to workspace] move focused window to workspace 3 |  |  | HL.Dispatcher(move) 331 |

| Super+Shift+4 | [Workspaces&#124;Move window to workspace] move focused window to workspace 4 |  |  | HL.Dispatcher(move) 334 |

| Super+Shift+5 | [Workspaces&#124;Move window to workspace] move focused window to workspace 5 |  |  | HL.Dispatcher(move) 337 |

| Super+Shift+6 | [Workspaces&#124;Move window to workspace] move focused window to workspace 6 |  |  | HL.Dispatcher(move) 340 |

| Super+Shift+7 | [Workspaces&#124;Move window to workspace] move focused window to workspace 7 |  |  | HL.Dispatcher(move) 343 |

| Super+Shift+8 | [Workspaces&#124;Move window to workspace] move focused window to workspace 8 |  |  | HL.Dispatcher(move) 346 |

| Super+Shift+9 | [Workspaces&#124;Move window to workspace] move focused window to workspace 9 |  |  | HL.Dispatcher(move) 349 |

| Super+Shift+0 | [Workspaces&#124;Move window to workspace] move focused window to workspace 10 |  |  | HL.Dispatcher(move) 352 |

| Super+Shift+KP_1 | [Workspaces&#124;Move window to workspace] move focused window to workspace 11 |  |  | HL.Dispatcher(move) 355 |

| Super+Shift+KP_End | [Workspaces&#124;Move window to workspace] move focused window to workspace 11 |  |  | HL.Dispatcher(move) 358 |

| Super+Shift+KP_2 | [Workspaces&#124;Move window to workspace] move focused window to workspace 12 |  |  | HL.Dispatcher(move) 361 |

| Super+Shift+KP_Down | [Workspaces&#124;Move window to workspace] move focused window to workspace 12 |  |  | HL.Dispatcher(move) 364 |

| Super+Shift+KP_3 | [Workspaces&#124;Move window to workspace] move focused window to workspace 13 |  |  | HL.Dispatcher(move) 367 |

| Super+Shift+KP_Next | [Workspaces&#124;Move window to workspace] move focused window to workspace 13 |  |  | HL.Dispatcher(move) 370 |

| Super+Shift+KP_4 | [Workspaces&#124;Move window to workspace] move focused window to workspace 14 |  |  | HL.Dispatcher(move) 350 |

| Super+Shift+KP_Left | [Workspaces&#124;Move window to workspace] move focused window to workspace 14 |  |  | HL.Dispatcher(move) 374 |

| Super+Shift+KP_5 | [Workspaces&#124;Move window to workspace] move focused window to workspace 15 |  |  | HL.Dispatcher(move) 377 |

| Super+Shift+KP_Begin | [Workspaces&#124;Move window to workspace] move focused window to workspace 15 |  |  | HL.Dispatcher(move) 380 |

| Super+Shift+KP_6 | [Workspaces&#124;Move window to workspace] move focused window to workspace 16 |  |  | HL.Dispatcher(move) 36 |

| Super+Shift+KP_Right | [Workspaces&#124;Move window to workspace] move focused window to workspace 16 |  |  | HL.Dispatcher(move) 47 |

| Super+Shift+KP_7 | [Workspaces&#124;Move window to workspace] move focused window to workspace 17 |  |  | HL.Dispatcher(move) 52 |

| Super+Shift+KP_Home | [Workspaces&#124;Move window to workspace] move focused window to workspace 17 |  |  | HL.Dispatcher(move) 56 |

| Super+Shift+KP_8 | [Workspaces&#124;Move window to workspace] move focused window to workspace 18 |  |  | HL.Dispatcher(move) 61 |

| Super+Shift+KP_Up | [Workspaces&#124;Move window to workspace] move focused window to workspace 18 |  |  | HL.Dispatcher(move) 65 |

| Super+Shift+KP_9 | [Workspaces&#124;Move window to workspace] move focused window to workspace 19 |  |  | HL.Dispatcher(move) 7 |

| Super+Shift+KP_Prior | [Workspaces&#124;Move window to workspace] move focused window to workspace 19 |  |  | HL.Dispatcher(move) 13 |

| Super+Shift+KP_0 | [Workspaces&#124;Move window to workspace] move focused window to workspace 20 |  |  | HL.Dispatcher(move) 21 |

| Super+Shift+KP_Insert | [Workspaces&#124;Move window to workspace] move focused window to workspace 20 |  |  | HL.Dispatcher(move) 27 |

| Super+Ctrl+Alt+RIGHT | [Workspaces&#124;Move window to workspace&#124;Relative workspace] move focused window to next workspace |  |  | HL.Dispatcher(move) 34 |

| Super+Ctrl+Alt+LEFT | [Workspaces&#124;Move window to workspace&#124;Relative workspace] move focused window to previous workspace |  |  | HL.Dispatcher(move) 43 |

| Super+mouse_down | [Workspaces&#124;Navigation&#124;Mouse] next workspace |  |  | HL.Dispatcher(focus) 73 |

| Super+mouse_up | [Workspaces&#124;Navigation&#124;Mouse] previous workspace |  |  | HL.Dispatcher(focus) 81 |

| Super+S | [Workspaces&#124;Navigation&#124;Special workspace] toggle scratchpad |  |  | HL.Dispatcher(toggle_special) 86 |

| Super+Shift+S | [Workspaces&#124;Navigation&#124;Special workspace] move focused window to scratchpad |  |  | HL.Dispatcher(move) 90 |

| Super+Alt+S | [Workspaces&#124;Navigation&#124;Special workspace] move focused window silently to scratchpad |  |  | HL.Dispatcher(move) 95 |

| Super+Alt+1 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 1 |  |  | HL.Dispatcher(move) 99 |

| Super+Alt+2 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 2 |  |  | HL.Dispatcher(move) 104 |

| Super+Alt+3 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 3 |  |  | HL.Dispatcher(move) 108 |

| Super+Alt+4 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 4 |  |  | HL.Dispatcher(move) 113 |

| Super+Alt+5 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 5 |  |  | HL.Dispatcher(move) 117 |

| Super+Alt+6 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 6 |  |  | HL.Dispatcher(move) 122 |

| Super+Alt+7 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 7 |  |  | HL.Dispatcher(move) 126 |

| Super+Alt+8 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 8 |  |  | HL.Dispatcher(move) 131 |

| Super+Alt+9 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 9 |  |  | HL.Dispatcher(move) 135 |

| Super+Alt+0 | [Workspaces&#124;Move window (Don't follow)] move focused window to workspace 10 |  |  | HL.Dispatcher(move) 140 |

| Super+Ctrl+B | [Window Management] toggle waybar visibility |  |  | HL.Dispatcher(exec_cmd) 54 |

## Exact HyDE implementations and overrides

The Lua entry loads HyDE defaults, then personal `hyprland.lua`, then the selected workflow. The old `.conf` bindings are retained later as legacy reference; they differ from the running Lua configuration (including Alt-Tab, Waybar, OCR, calculator, web search, and numpad workspaces).

### ~/.local/share/hypr/lua/key_binds.lua

```lua
-- * Enable bind deduplication so repeated key combos don't conflict.
-- * This has to run before the first bind below, otherwise the binds in this
-- * file are registered unchecked and only user overrides get deduplicated.
-- * For multiple dispatcher actions, wrap them in one function and bind that.
-- * If you set `hyde.binds.dedup = false`, unbind duplicates manually.
hyde.binds.dedup = true
-- hyde.binds.dedup_fields = {}

-- vars for easy access
local _apps = hyde.config.app
local MOD = hyde.config.modifiers.main
local _F

-- Functions for some multi bind actions

local cycle_fullscreen = function()
    local active_window = assert(hl.get_active_window(), "No active window to toggle fullscreen")
    local current_state = tonumber(active_window.fullscreen) or 0
    local next_state = (current_state + 1) % 3
    hl.dispatch(
        hl.dsp.window.fullscreen_state(
            {
                internal = next_state,
                client = next_state,
                window = active_window
            }
        )
    )
end

local move_window = function(dir, pix)
    local lut = {l = {-1, 0}, r = {1, 0}, u = {0, -1}, d = {0, 1}}
    lut.left, lut.right, lut.up, lut.down = lut.l, lut.r, lut.u, lut.d
    local m = lut[dir]
    return function()
        local args =
            hl.get_active_window().floating and {x = m[1] * pix, y = m[2] * pix, relative = true} or {direction = dir}
        hl.dispatch(hl.dsp.window.move(args))
    end
end

local togglefloating = function()
    -- TODO unused
    -- $ToggleFloatingMax = hyprctl --batch "dispatch togglefloating; dispatch resizeactive exact 85% 85%; dispatch centerwindow"
    hl.dsp.window.float({action = "toggle"})()
    hl.dsp.window.resize({width = "85%", height = "85%"})()
    hl.dsp.window.center()()
end

_F = {description = "[Launcher|Apps] terminal emulator"}
hl.bind(MOD .. " + T", hl.dsp.exec_cmd(_apps.terminal), _F)
_F = {description = "[Launcher|Apps] dropdown terminal"}
hl.bind(MOD .. " + ALT + T", hl.dsp.exec_cmd("hyde-shell pypr toggle console"), _F)
_F = {description = "[Launcher|Apps] file explorer"}
hl.bind(MOD .. " + E", hl.dsp.exec_cmd(_apps.explorer), _F)
_F = {description = "[Launcher|Apps] browser"}
hl.bind(MOD .. " + B", hl.dsp.exec_cmd(_apps.browser), _F)
_F = {description = "[Launcher|Apps] text editor"}
hl.bind(MOD .. " + C", hl.dsp.exec_cmd(_apps.editor), _F)
_F = {description = "[Launcher|Apps] system monitor"}
hl.bind("CTRL + SHIFT + ESCAPE", hl.dsp.exec_cmd("hyde-shell system.monitor.sh"), _F)

local _wm = "Window Management"
_F = {description = "[Window Management] close focused window"}
hl.bind(MOD .. " + Q", hl.dsp.window.close(), _F)
_F = {description = "[Window Management] close focused window"}
hl.bind("ALT + F4", hl.dsp.window.close(), _F)
_F = {description = "[Window Management] kill focused window"}
hl.bind(MOD .. "+ ALT  + F4", hl.dsp.window.kill(), _F)
_F = {description = "[Window Management] exit hyprland session"}
hl.bind(MOD .. " + Delete", hl.dsp.exit(), _F)
_F = {description = "[Window Management] toggle float true"}
hl.bind(MOD .. " + W", hl.dsp.window.float({action = "toggle"}), _F)
_F = {description = "[Window Management] toggle group"}
hl.bind(MOD .. " + G", hl.dsp.group.toggle(), _F)
_F = {description = "[Window Management] set a window’s pseudotiling state"}
hl.bind("ALT + P", hl.dsp.window.pseudo(), _F)

-- bindd = $mainMod, G, $d toggle group,exec, hydectl tabs
_F = {description = "[Window Management] cycle fullscreen"}
hl.bind("SHIFT + F11", cycle_fullscreen, _F)
_F = {description = "[Window Management] toggle pin"}
hl.bind(MOD .. " + SHIFT + F", hl.dsp.exec_cmd(hyde.sh.window.pin()), _F)
_F = {description = "[Window Management] logout menu"}
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd(hyde.sh.session.logout.launcher()), _F)
-- ALT_R is a keysym, not a modifier: "ALT_R + CONTROL_R" resolves to a bare
-- right Control, so every press of that key hid the bar.
_F = {description = "[Window Management] hide waybar"}
hl.bind(MOD .. " + CTRL + B", hl.dsp.exec_cmd(hyde.sh.waybar("--hide")), _F)
_F = {description = "[Window Management] lock session"}
hl.bind(MOD .. " + L", hl.dsp.exec_cmd(hyde.sh.session.lock()), _F)

_F = {description = "[Window Management|Group Navigation] change active group backwards"}
hl.bind(MOD .. " + CTRL + H", hl.dsp.group.prev(), _F)
_F = {description = "[Window Management|Group Navigation] change active group forwards"}
hl.bind(MOD .. " + CTRL + L", hl.dsp.group.next(), _F)

-- $d=[$wm|Change focus]

_F = {description = "[Window Management|Change focus] focus left"}
hl.bind(MOD .. " + Left", hl.dsp.focus({direction = "left"}), _F)
_F = {description = "[Window Management|Change focus] focus right"}
hl.bind(MOD .. " + Right", hl.dsp.focus({direction = "right"}), _F)
_F = {description = "[Window Management|Change focus] focus up"}
hl.bind(MOD .. " + Up", hl.dsp.focus({direction = "up"}), _F)
_F = {description = "[Window Management|Change focus] focus down"}
hl.bind(MOD .. " + Down", hl.dsp.focus({direction = "down"}), _F)

-- _F = {description = "[Window Management|Change focus] cycle group"}
-- hl.bind("ALT + TAB", hl.dsp.group.next(), _F)

-- Window switcher
-- Handles Alt Tab like Behavior like browser
_F = {description = "[Window Management|alt-tab window switcher] cycle next", transparent = true}
hl.bind("ALT+TAB", hl.dsp.exec_cmd(hyde.sh.altab("--next")), _F)
_F = {description = "[Window Management|alt-tab window switcher] cycle previous", transparent = true}
hl.bind("ALT+SHIFT+TAB", hl.dsp.exec_cmd(hyde.sh.altab("--prev")), _F)
_F = {description = "[Window Management|alt-tab window switcher] switch", release = true, transparent = true}
hl.bind("ALT + ALT_R", hl.dsp.exec_cmd(hyde.sh.altab("--apply")), _F)
hl.bind("ALT + ALT_L", hl.dsp.exec_cmd(hyde.sh.altab("--apply")), _F)

-- # Resize kwindows

_F = {description = "[Window Management|Resize Active Window] resize window right", repeating = true}
hl.bind(MOD .. " + SHIFT + RIGHT", hl.dsp.window.resize({x = 30, y = 0, relative = true}), _F)

_F = {description = "[Window Management|Resize Active Window] resize window left", repeating = true}
hl.bind(MOD .. " + SHIFT + LEFT", hl.dsp.window.resize({x = -30, y = 0, relative = true}), _F)

_F = {description = "[Window Management|Resize Active Window] resize window up", repeating = true}
hl.bind(MOD .. " + SHIFT + UP", hl.dsp.window.resize({x = 0, y = -30, relative = true}), _F)
_F = {description = "[Window Management|Resize Active Window] resize window down", repeating = true}
hl.bind(MOD .. " + SHIFT + DOWN", hl.dsp.window.resize({x = 0, y = 30, relative = true}), _F)

-- TEXT = hl.get_active_window().floating

-- # Move active window around current workspace with mainMod + SHIFT + Control [←→↑↓]

_F = {description = "[Window Management|Move active window] left", repeating = true}
hl.bind(MOD .. " + SHIFT + CONTROL + LEFT", move_window("l", 30), _F)
_F = {description = "[Window Management|Move active window] right", repeating = true}
hl.bind(MOD .. " + SHIFT + CONTROL + RIGHT", move_window("r", 30), _F)
_F = {description = "[Window Management|Move active window] up", repeating = true}
hl.bind(MOD .. " + SHIFT + CONTROL + UP", move_window("u", 30), _F)
_F = {description = "[Window Management|Move active window] down", repeating = true}
hl.bind(MOD .. " + SHIFT + CONTROL + DOWN", move_window("d", 30), _F)

_F = {description = "[Window Management|Drag & Resize with mouse] drag window", mouse = true}
hl.bind(MOD .. " + mouse:272", hl.dsp.window.drag(), _F)
_F = {description = "[Window Management|Drag & Resize with mouse] resize window", mouse = true}
hl.bind(MOD .. " + mouse:273", hl.dsp.window.resize(), _F)
_F = {description = "[Window Management|Drag & Resize with mouse] hold to move window", mouse = true}
hl.bind(MOD .. " + Z", hl.dsp.window.drag(), _F)
_F = {description = "[Window Management|Drag & Resize with mouse] hold to resize window", mouse = true}
hl.bind(MOD .. " + X", hl.dsp.window.resize(), _F)

-- # Toggle focused window split
-- $d=[$wm]

_F = {description = "[Layout Management|Dwindle] toggle split"}
hl.bind(MOD .. " + J", hl.dsp.layout("togglesplit"), _F)

_F = {description = "[Launcher|Rofi menus] application finder"}
hl.bind(MOD .. " + A", hl.dsp.exec_cmd(hyde.sh.menu.apps()), _F)
_F = {description = "[Launcher|Rofi menus] window switcher"}
hl.bind(MOD .. " + TAB", hl.dsp.exec_cmd(hyde.sh.menu.windows()), _F)
_F = {description = "[Launcher|Rofi menus] file finder"}
hl.bind(MOD .. " + SHIFT + E", hl.dsp.exec_cmd(hyde.sh.menu.files()), _F)
_F = {description = "[Launcher|Rofi menus] keybindings hint"}
hl.bind(MOD .. " + slash", hl.dsp.exec_cmd(hyde.sh.menu.binds()), _F)
_F = {description = "[Launcher|Rofi menus] emoji picker"}
hl.bind(MOD .. " + comma", hl.dsp.exec_cmd(hyde.sh.menu.emoji()), _F)
_F = {description = "[Launcher|Rofi menus] glyph picker"}
hl.bind(MOD .. " + period", hl.dsp.exec_cmd(hyde.sh.menu.glyph()), _F)
_F = {description = "[Launcher|Rofi menus] clipboard"}
hl.bind(MOD .. " + V", hl.dsp.exec_cmd(hyde.sh.menu.clipboard()), _F)
_F = {description = "[Launcher|Rofi menus] clipboard manager"}
hl.bind(MOD .. " + SHIFT + V", hl.dsp.exec_cmd(hyde.sh.menu.cliphist()), _F)
_F = {description = "[Launcher|Rofi menus] select rofi launcher"}
hl.bind(MOD .. " + SHIFT + A", hl.dsp.exec_cmd(hyde.sh.menu.select()), _F)
_F = {description = "[Launcher|Rofi menus] Calculator"}
hl.bind(MOD .. " + SHIFT + K", hl.dsp.exec_cmd(hyde.sh.menu.calculator()), _F)
_F = {description = "[Launcher|Rofi menus] Web Search"}
hl.bind(MOD .. " + SHIFT + slash", hl.dsp.exec_cmd(hyde.sh.menu.search()), _F)

-- $hc=Hardware Controls
-- $d=[$hc|Audio]

-- # binddl  = , F10, $d toggle mute output , exec, hyde-shell volumecontrol.sh -o m # toggle audio mute
-- # binddel = , F11, $d decrease volume , exec, hyde-shell volumecontrol.sh -o d # decrease volume
-- # binddel = , F12, $d increase volume , exec, hyde-shell volumecontrol.sh -o i # increase volume

_F = {description = "[Hardware Controls|Audio] un/mute output", locked = true}
hl.bind("F10", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")), _F)
_F = {description = "[Hardware Controls|Audio] decrease volume", locked = true, repeating = true}
hl.bind("F11", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "d")), _F)
_F = {description = "[Hardware Controls|Audio] increase volume", locked = true, repeating = true}
hl.bind("F12", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "i")), _F)
_F = {description = "[Hardware Controls|Audio] un/mmute output", locked = true}
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")), _F)
_F = {description = "[Hardware Controls|Audio] un/mute microphone", locked = true}
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-i", "m")), _F)
_F = {description = "[Hardware Controls|Audio] decrease volume", locked = true, repeating = true}
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "d")), _F)
_F = {description = "[Hardware Controls|Audio] increase volume", locked = true, repeating = true}
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "i")), _F)

_F = {description = "[Hardware Controls|Media] play media", locked = true}
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), _F)
_F = {description = "[Hardware Controls|Media] pause media", locked = true}
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), _F)
_F = {description = "[Hardware Controls|Media] next media", locked = true}
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), _F)
_F = {description = "[Hardware Controls|Media] previous media", locked = true}
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), _F)
_F = {description = "[Hardware Controls|Media] toggle un/mute for active-window"}
hl.bind(MOD .. "+ CONTROL + M", hl.dsp.exec_cmd(hyde.sh.window.mute()), _F)

_F = {description = "[Hardware Controls|Brightness] increase brightness", locked = true, repeating = true}
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(hyde.sh.brightnesscontrol("-i")), _F)
_F = {description = "[Hardware Controls|Brightness] decrease brightness", locked = true, repeating = true}
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(hyde.sh.brightnesscontrol("-d")), _F)

_F = {description = "[Utilities] toggle keyboard layout", locked = true}
hl.bind(MOD .. " + K", hl.dsp.exec_cmd(hyde.sh.kb.switch()), _F)
_F = {description = "[Utilities] game mode", locked = true}
hl.bind(MOD .. " + ALT + G", hl.dsp.exec_cmd(hyde.sh.gamemode()), _F) -- TODO
_F = {description = "[Utilities] game launcher"}
hl.bind(MOD .. " + SHIFT + G", hl.dsp.exec_cmd("hyde-shell gamelauncher"), _F)

_F = {description = "[Utilities] screen capture] color picker", locked = true}
hl.bind(MOD .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -an"), _F)
_F = {description = "[Utilities] partial screenshot capture", locked = true}
hl.bind(MOD .. " + P", hl.dsp.exec_cmd(hyde.sh.screenshot.snip()), _F)
_F = {description = "[Utilities] freeze and snip screen", locked = true}
hl.bind(MOD .. " + CONTROL + P", hl.dsp.exec_cmd(hyde.sh.screenshot.freeze()), _F)
_F = {description = "[Utilities] print monitor", locked = true}
hl.bind(MOD .. " + ALT + P", hl.dsp.exec_cmd(hyde.sh.screenshot.monitor()), _F)
_F = {description = "[Utilities] print all monitors", locked = true}
hl.bind("Print", hl.dsp.exec_cmd(hyde.sh.screenshot.full()), _F)
_F = {description = "[Utilities] OCR scanner", locked = true}
hl.bind(MOD .. " + CONTROL + S", hl.dsp.exec_cmd(hyde.sh.screenshot.ocr()), _F)

_F = {description = "[Theming and Wallpaper] next global wallpaper"}
hl.bind(MOD .. "+ ALT + Right", hl.dsp.exec_cmd(hyde.sh.wallpaper("--next")), _F)
_F = {description = "[Theming and Wallpaper] previous global wallpaper"}
hl.bind(MOD .. "+ ALT + Left", hl.dsp.exec_cmd(hyde.sh.wallpaper("--previous")), _F)
_F = {description = "[Theming and Wallpaper] next Waybar layout"}
hl.bind(MOD .. "+ ALT + Up", hl.dsp.exec_cmd("hyde-shell waybar --next"), _F)
_F = {description = "[Theming and Wallpaper] previous Waybar layout"}
hl.bind(MOD .. "+ ALT + Down", hl.dsp.exec_cmd("hyde-shell waybar --prev"), _F)

_F = {description = "[Theming and Wallpaper] select a global wallpaper"}
hl.bind(MOD .. "+ SHIFT + W", hl.dsp.exec_cmd(hyde.sh.menu.wallpapers()), _F)
_F = {description = "[Theming and Wallpaper] wallbash mode selector"}
hl.bind(MOD .. "+ SHIFT + R", hl.dsp.exec_cmd(hyde.sh.menu.wallbash()), _F)
_F = {description = "[Theming and Wallpaper] select a theme"}
hl.bind(MOD .. "+ SHIFT + T", hl.dsp.exec_cmd(hyde.sh.menu.themes()), _F)
_F = {description = "[Theming and Wallpaper] select animations"}
hl.bind(MOD .. "+ SHIFT + Y", hl.dsp.exec_cmd("hyde-shell animations --select"), _F)
_F = {description = "[Theming and Wallpaper] select Hyprlock layout"}
hl.bind(MOD .. "+ SHIFT + U", hl.dsp.exec_cmd("hyde-shell hyprlock --select"), _F)

-- # TODO Make a main rofi menu for these selectors
-- $rice=Theming and Wallpaper
-- $d=[$rice]
-- # bindd = $mainMod Alt, Right, $d next global wallpaper , exec, hyde-shell wallpaper.sh -Gn # next global wallpaper
-- # bindd = $mainMod Alt, Left, $d previous global wallpaper , exec, hyde-shell wallpaper.sh -Gp # previous global wallpaper
-- bindd = $mainMod SHIFT, W, $d select a global wallpaper , exec, pkill -x rofi || hyde-shell wallpaper.sh -SG # launch wallpaper select menu
-- #! bindd = $mainMod Alt, Up, $d next waybar layout , exec, hyde-shell wbarconfgen.sh n # next waybar mode
-- #! bindd = $mainMod Alt, Down, $d previous waybar layout , exec, hyde-shell wbarconfgen.sh p # previous waybar mode
-- bindd = $mainMod SHIFT, R, $d wallbash mode selector , exec, pkill -x rofi || hyde-shell wallbashtoggle.sh -m # launch wallbash mode select menu
-- bindd = $mainMod SHIFT, T, $d select a theme, exec, pkill -x rofi || hyde-shell themeselect.sh # launch theme select menu

-- Numpad keys for workspaces 11-20. The Lua bind parser has no keycode form,
-- so each key is bound under both keysyms it can emit: the digit while Num
-- Lock is on, the navigation name while it is off.
local kp = {
    [1] = {"KP_1", "KP_End"},
    [2] = {"KP_2", "KP_Down"},
    [3] = {"KP_3", "KP_Next"},
    [4] = {"KP_4", "KP_Left"},
    [5] = {"KP_5", "KP_Begin"},
    [6] = {"KP_6", "KP_Right"},
    [7] = {"KP_7", "KP_Home"},
    [8] = {"KP_8", "KP_Up"},
    [9] = {"KP_9", "KP_Prior"},
    [10] = {"KP_0", "KP_Insert"}
}

for i = 1, 10 do
    _F = {description = "[Workspaces|Navigation] navigate to workspace " .. i}
    hl.bind(MOD .. " + " .. ((i == 10) and 0 or i), hl.dsp.focus({workspace = i}), _F)
end

for i = 1, 10 do
    for _, key in ipairs(kp[i]) do
        hl.bind(
            MOD .. " + " .. key,
            hl.dsp.focus({workspace = tostring(i + 10)}),
            {description = "[Workspaces|Navigation] navigate to workspace " .. (i + 10)}
        )
    end
end

_F = {description = "[Workspaces|Navigation|Relative workspace] change active workspace forwards"}
hl.bind(MOD .. " + CONTROL + RIGHT", hl.dsp.focus({workspace = "r+1"}), _F)
_F = {description = "[Workspaces|Navigation|Relative workspace] change active workspace backwards"}
hl.bind(MOD .. " + CONTROL + LEFT", hl.dsp.focus({workspace = "r-1"}), _F)

_F = {description = "[Workspaces|Navigation] navigate to the nearest empty workspace"}
hl.bind(MOD .. " + CONTROL + DOWN", hl.dsp.focus({workspace = "empty"}), _F)

for i = 1, 10 do
    _F = {description = "[Workspaces|Move window to workspace] move focused window to workspace " .. i}
    hl.bind(MOD .. " + SHIFT + " .. ((i == 10) and 0 or i), hl.dsp.window.move({workspace = i}), _F)
end

for i = 1, 10 do
    for _, key in ipairs(kp[i]) do
        hl.bind(
            MOD .. " + SHIFT + " .. key,
            hl.dsp.window.move({workspace = tostring(i + 10)}),
            {description = "[Workspaces|Move window to workspace] move focused window to workspace " .. (i + 10)}
        )
    end
end

_F = {description = "[Workspaces|Move window to workspace|Relative workspace] move focused window to next workspace"}
hl.bind(MOD .. " + CONTROL + ALT + RIGHT", hl.dsp.window.move({workspace = "r+1"}), _F)
_F = {
    description = "[Workspaces|Move window to workspace|Relative workspace] move focused window to previous workspace"
}
hl.bind(MOD .. " + CONTROL + ALT + LEFT", hl.dsp.window.move({workspace = "r-1"}), _F)

_F = {description = "[Workspaces|Navigation|Mouse] next workspace"}
hl.bind(MOD .. " + mouse_down", hl.dsp.focus({workspace = "e+1"}), _F)
_F = {description = "[Workspaces|Navigation|Mouse] previous workspace"}
hl.bind(MOD .. " + mouse_up", hl.dsp.focus({workspace = "e-1"}), _F)

-- # Move/Switch to special workspace (scratchpad)
_F = {description = "[Workspaces|Navigation|Special workspace] toggle scratchpad"}
hl.bind(MOD .. " + S", hl.dsp.workspace.toggle_special(), _F)
_F = {description = "[Workspaces|Navigation|Special workspace] move focused window to scratchpad"}
hl.bind(MOD .. " + SHIFT + S", hl.dsp.window.move({workspace = "special"}), _F)
_F = {description = "[Workspaces|Navigation|Special workspace] move focused window silently to scratchpad"}
hl.bind(MOD .. " + ALT + S", hl.dsp.window.move({workspace = "special", follow = false}), _F)

--- Move silent
---
for i = 1, 10 do
    _F = {description = "[Workspaces|Move window (Don't follow)] move focused window to workspace " .. i}
    hl.bind(MOD .. " + ALT + " .. ((i == 10) and 0 or i), hl.dsp.window.move({workspace = i, follow = false}), _F)
end

-- Optionals

-- # $bind.Overview.Window = "qs -c Overview2 ipc call Overview2 toggle ||  qs -c Overview2"

-- $d=#! unset the group name

-- unbind = $mainMod, K
-- binddl = $mainMod, K, $d toggle keyboard layout , exec, hyprctl switchxkblayout all next -q # switch keyboard layout

-- unbind = $mainMod, K
-- binddl = $mainMod, K, $d toggle onscreen kb,exec, squeekboard

-- bindd = $mainMod Alt,slash, AI tts,exec, cd ~/AI/Talk && ./main.py --output tts

-- $gemini_bridge=bash $HOME/.scripts/gemini-bridge/gemini-bridge.sh
-- exec-once = $gemini_bridge
-- bindd = $mainMod Alt,P, Push Clipboard to gemini,exec,$gemini_bridge --push

-- bindd = $mainMod SHIFT, X,Inverted Screenshot, exec, $HOME/.local/bin/inverted-screenshot.sh

-- unbind = Alt, Tab
-- binddt = Alt, Tab, Cycle Tabs, exec, hyprctl dispatch submap altab &&  hyde-shell hypr.altab --no-notify
-- binddt = Alt SHIFT, Tab, Cycle Tabs Reversed, exec, hyprctl dispatch submap altab &&  hyde-shell hypr.altab  --prev --no-notify

-- submap = altab
-- binddt = Alt, Tab, Cycle Tabs, exec, hyde-shell hypr.altab
-- binddt = Alt SHIFT, Tab, Cycle Tabs, exec, hyde-shell hypr.altab --prev

-- bindntr = Alt, Alt_L, exec, hyde-shell hypr.altab --apply
-- bindntr = Alt, Alt_R, exec, hyde-shell hypr.altab --apply
-- bindntr = Alt, Alt_L, submap,reset
-- bindntr = Alt, Alt_R, submap,reset
-- bindntr = ,catchall,exec, notify-send "Keybinding Reset" "Exited submap mode"
-- bindntr = ,catchall,exec, hyde-shell hypr.altab --apply
-- bindntr = ,catchall,submap,reset
-- bind = ,catchall,exec, notify-send "Keybinding Reset Second" "Exited submap mode"
-- submap = reset

-- exec-once = hyde-shell app -- wayscriber --daemon
-- bindd = Alt, D, Annotate Screen,exec,pkill -SIGUSR1 wayscriber

-- # $bind.Overview.Window = "qs -c Overview2 ipc call Overview2 toggle ||  qs -c Overview2"

-- unbind = $mainMod,TAB
-- binddtn = $mainMod,Tab, Window Overview,exec, qs -c Overview ipc call Overview2 open ||  qs -c Overview

-- bind = Super ALT, F , exec , notify-send "Hyprland" "Hyprland is awesome!"
-- unbind = SUPER                     ALT , F
-- bindk = Super     ALT, F ,test device, exec , notify-send "Hyprland" "You just pressed Super + F again!"
-- bindk = Super     ALT, F ,test device, exec , notify-send "Hyprland" "You just pressed Super + F again!2"

-- # bindd = Alt, D , [Utilities] Enable Wayscriber ,exec, wayscriber --active
```

### ~/dotfiles/.config/hypr/hyprland.lua

```lua
-- Hyprland loads this file when it is started without a config, and it prefers
-- it over hyprland.conf. HyDE loads it too, last, as the override layer below.
-- The block keeps the two apart: hyde.lua sets `hyde` on its first line, so it
-- runs only when this file is the entry point and HyDE has not been loaded.
-- Removing it leaves a session with a cursor and nothing else.
if not hyde then
	local share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
	local entry = share .. "/hypr/hyde.lua"
	local handle = io.open(entry, "r")
	if not handle then
		error("HyDE is not installed at " .. entry .. ". Run install.sh -r, or point Hyprland at your own config.")
	end
	handle:close()
	dofile(entry)
end

-- Your Hyprland configuration. HyDE never overwrites this file.
--
-- It loads after HyDE's own binds, so settings here take precedence. Replacing
-- a bind needs more than that: see below. HyDE's defaults live in
-- ~/.local/share/hypr/lua/ and are overwritten on every update, so edits there
-- do not survive.
--
-- Adding a keybind:
--
--     hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(hyde.sh.gamelauncher()), {
--         description = "[Utilities] game launcher",
--     })
--
-- Replacing one of HyDE's: bind the same combination again and yours takes
-- over, but copy its flags across as well. A bind counts as the same one only
-- when its flags match, and `description` is not a flag — miss one and both
-- binds stay live on that combination. Copy the whole options table from
-- ~/.local/share/hypr/lua/key_binds.lua and change only what you need:
--
--     hl.bind("F9", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")), {
--         locked = true,
--         description = "[Hardware Controls|Audio] un/mute output",
--     })
--
-- Press SUPER + / to see what is actually loaded, your own binds included.
-- The full reference is KEYBINDINGS.md in the HyDE repository.
--
-- Other Lua files next to this one can be pulled in with require("name").

-- Personal settings migrated from userprefs.conf.
hl.config({input = {touchpad = {natural_scroll = false}}})
hl.env("ROFI_WALLPAPER_COLUMN_COUNT", "4")

-- Signal the running bar directly; its systemd unit name varies by session.
hl.bind(hyde.config.modifiers.main .. " + CTRL + B",
	hl.dsp.exec_cmd("pkill -USR1 -u " .. tostring(os.getenv("USER")) .. " -x waybar"), {
		description = "[Window Management] toggle waybar visibility",
	})
```

### ~/.local/state/hyde/lua_state/workflows.lua

```lua
local _dir = "/home/sog/.local/share/hypr/lua/workflows"
local _p   = "/home/sog/.local/share/hypr/lua/workflows/snappy.lua"
local _mod = _p:match("^.*/(.-)%.lua$")
if not package.path:find(_dir .. "/?.lua", 1, true) then
    package.path = _dir .. "/?.lua;" .. package.path
end
local _ok, _t = pcall(require, _mod)
if not (_ok and type(_t) == 'table') then _t = {} end
_t.path = _p
_t.key  = _t.key or "snappy"
return _t
```

### ~/.local/share/hypr/lua/hyde/dispatcher.lua

```lua
--[[-
    hyde.dispatcher.lua

    Provides two helper namespaces:
      * hyde.sh / hyde.shell  - builds hyde-shell command strings
      * hyde.dsp             - executes via hl.dsp.exec_cmd internally

    Usage:
      local cmd = hyde.sh.command.some("arg1", "arg2")
      -- returns: "hyde-shell command.some arg1 arg2"

      hyde.dsp.command.some("arg1", "arg2")
      -- executes: hl.dsp.exec_cmd("hyde-shell command.some arg1 arg2")()

      hyde.dsp("command.ext arg1 arg2")
      -- executes: hl.dsp.exec_cmd("hyde-shell command.ext arg1 arg2")()

    Extension stripping:
      command.sh -> command
      command.py -> command
      command.lua -> command

    Command map:
      hyde.command_map = {
          ["command.sub.sub"] = { "custom", "mapped", "command" },
          ["command.ext"] = "custom-script.sh",
      }

    Notes:
      * hyde.sh and hyde.shell only build strings
      * hyde.dsp runs the command immediately
      * dot-separated names like command.sub.name are preserved
]]


local function trim(str)
    if type(str) ~= "string" then
        return str
    end
    return str:match("^%s*(.-)%s*$")
end

local function remove_extension(name)
    if type(name) ~= "string" then
        return name
    end
    local result = name:gsub("%.sh$", ""):gsub("%.py$", ""):gsub("%.lua$", "")
    return result
end

local function split_whitespace(str)
    local out = {}
    for token in str:gmatch("%S+") do
        out[#out + 1] = token
    end
    return out
end


-- Shell-quote a single argument for safe command-line usage
local function shell_quote(arg)
    arg = tostring(arg)
    -- Escape single quotes: ' -> '\''
    arg = arg:gsub("'", "'\\''")
    return "'" .. arg .. "'"
end

local function join_args(args)
    local out = {}
    for _, v in ipairs(args) do
        out[#out + 1] = shell_quote(v)
    end
    return table.concat(out, " ")
end

local function resolve_mapped_command(command)
    local key = remove_extension(trim(command))
    if type(_G.hyde.command_map) == "table" then
        local mapped = _G.hyde.command_map[key]
        if type(mapped) == "table" then
            return table.concat(mapped, ".")
        elseif type(mapped) == "string" then
            return remove_extension(trim(mapped))
        end
    end
    return key
end

local function build_shell_string(command, ...)
    command = resolve_mapped_command(command)
    local args = {...}
    local full = command
    if #args > 0 then
        full = full .. " " .. join_args(args)
    end
    return "hyde-shell " .. full
end

local function exec_shell_string(command, ...)
    local cmd = build_shell_string(command, ...)
    if type(hl.dsp) == "table" and type(hl.dsp.exec_cmd) == "function" then
        local runner = hl.dsp.exec_cmd(cmd)
        if type(runner) == "function" then
            return runner()
        end
        return runner
    end
    if type(hl.exec_cmd) == "function" then
        local runner = hl.exec_cmd(cmd)
        if type(runner) == "function" then
            return runner()
        end
        return runner
    end
    error("no dispatcher available to execute: " .. tostring(cmd))
end

local function create_shell_proxy(prefix)
    prefix = prefix or ""
    return setmetatable({}, {
        __index = function(_, key)
            local next_prefix = prefix == "" and key or prefix .. "." .. key
            return create_shell_proxy(next_prefix)
        end,
        __call = function(_, ...)
            return build_shell_string(prefix, ...)
        end,
    })
end

local function create_dsp_proxy(prefix)
    prefix = prefix or ""
    return setmetatable({}, {
        __index = function(_, key)
            local next_prefix = prefix == "" and key or prefix .. "." .. key
            return create_dsp_proxy(next_prefix)
        end,
        __call = function(_, ...)
            return exec_shell_string(prefix, ...)
        end,
    })
end

_G.hyde = _G.hyde or {}
-- Map hypr commands to custom shell command targets.
-- Use string values or arrays for dot-joined replacement.
-- Example:
hyde.command_map = {
--     ["command.sub.sub"] = { "custom", "mapped", "command" },
--     ["command.ext"] = "custom-script.sh",
[ "window.pin" ] = "window.pin",
[ "session.logout.launcher" ] = "logoutlaunch",
[ "session.lock" ] = "lock-session",
[ "waybar.toggle" ] = "waybar.py --hide",
[ "menu.apps" ] = "rofilaunch d",
[ "menu.windows" ] = "rofilaunch w",
[ "menu.files" ] = "rofilaunch f",
[ "menu.binds" ] = "keybinds_hint",
[ "menu.emoji" ] = "emoji-picker",
[ "menu.glyph" ] = "glyph-picker",
[ "menu.clipboard" ] = "cliphist -c",
[ "menu.cliphist" ] = "cliphist",
[ "menu.launcher" ] = "rofilaunch",
[ "menu.select" ] = "rofiselect",
[ "menu.calculator" ] = "calculator",
[ "menu.search" ] = "rofi.websearch",
[ "kb.switch" ] = "keyboardswitch",
[ "colorpicker" ] = "hyprpicker -an",
[ "screenshot.full"] = "screenshot p",
[ "screenshot.snip"] = "screenshot s",
[ "screenshot.freeze"] = "screenshot sf",
[ "screenshot.monitor"] = "screenshot m",
[ "screenshot.ocr"] = "screenshot sc",
[ "wallpaper" ] = "wallpaper --global",
[ "menu.wallbash" ] = "wallbashtoggle -m",
[ "menu.themes"] = "theme.select",
[ "menu.wallpapers"] = "wallpaper -GS",

}
_G.hyde.command_map = _G.hyde.command_map or {}
_G.hyde.sh = _G.hyde.sh or create_shell_proxy()
_G.hyde.shell = _G.hyde.shell or _G.hyde.sh
_G.hyde.dsp = _G.hyde.dsp or create_dsp_proxy()

_G.hyde.sh.map = _G.hyde.sh.map or _G.hyde.command_map
_G.hyde.shell.map = _G.hyde.shell.map or _G.hyde.sh.map
_G.hyde.dsp.map = _G.hyde.dsp.map or _G.hyde.command_map

setmetatable(_G.hyde.dsp, {
    __index = function(_, key)
        return create_dsp_proxy(key)
    end,
    __call = function(_, raw)
        if type(raw) ~= "string" then
            return nil
        end
        local tokens = split_whitespace(raw)
        if #tokens == 0 then
            return nil
        end
        local command = table.remove(tokens, 1)
        return exec_shell_string(command, table.unpack(tokens))
    end,
})
```

### App / modifier declarations: ~/.local/share/hypr/lua/hyde/config.lua

```text
178: hyde.config.modifiers = hyde.config.modifiers or {}
```

### App / modifier declarations: ~/.local/share/hyde/config-registry.toml

```text
23: description = "Kitty Terminal Emulator"
```

## tmux

Prefix is Ctrl+Space, mouse enabled, vi copy mode, windows/panes start at 1. Prefix+v splits side by side; prefix+s splits top/bottom; prefix+c creates a window in the current directory. Prefix+Enter enters copy mode. In copy mode v selects, V selects a line, Ctrl+v toggles rectangular selection, y copies through wl-copy, Escape cancels.

**Existing conflict:** prefix+K is assigned resize-up first and kill-session later; the later kill-session definition wins. Prefix+H/J/L resize; prefix+K does not resize with this config. Ctrl+h/j/k/l are unprefixed navigator keys supplied by the plugin.

Runtime tables below include defaults, mouse bindings and loaded plugins. `-T prefix` requires the prefix; `-T root` does not; other tables apply only in their named mode. `-r` permits repetition during the repeat interval. The source config lists resurrect and continuum, but those plugin directories were absent at extraction; do not infer that their usual save/restore bindings are active.

### ~/dotfiles/home/.tmux.conf

```tmux
# ─── Prefix ───────────────────────────────────────────────────────────────────
set -g prefix C-Space
unbind C-b
bind C-Space send-prefix

# ─── True Color (critical for catppuccin on Wayland/Hyprland) ─────────────────
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
set -ag terminal-overrides ",*:Tc"

# ─── Core Settings ────────────────────────────────────────────────────────────
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on
set -g status-position top
set -g mouse on
set -g default-command "/usr/bin/zsh"
set -g history-limit 50000
set -g display-time 2000
set -g status-interval 5
set -g focus-events on
set -g aggressive-resize on
set -sg escape-time 0
set -g repeat-time 300

# ─── Splits & Windows ─────────────────────────────────────────────────────────
bind v split-window -h -c "#{pane_current_path}"
bind s split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

bind -r n next-window
bind -r p previous-window
bind Tab last-window

bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

bind > swap-pane -D
bind < swap-pane -U

# ─── Copy Mode (vi + wl-copy for Wayland clipboard) ───────────────────────────
set -g mode-keys vi
bind Enter copy-mode
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi V send-keys -X select-line
bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
bind -T copy-mode-vi Y send-keys -X copy-line
bind -T copy-mode-vi Escape send-keys -X cancel
bind -T copy-mode-vi H send-keys -X start-of-line
bind -T copy-mode-vi L send-keys -X end-of-line

# ─── Session Management ────────────────────────────────────────────────────────
bind N command-prompt -p "New session:" "new-session -s '%%'"
bind K confirm-before -p "Kill session #S? (y/n)" "kill-session"
bind ( switch-client -p
bind ) switch-client -n

# ─── Popups ───────────────────────────────────────────────────────────────────
bind g display-popup -d "#{pane_current_path}" -w 90% -h 90% -E "lazygit"
bind f display-popup -d "#{pane_current_path}" -w 90% -h 90% -E "zsh"

# ─── Plugins ──────────────────────────────────────────────────────────────────
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'catppuccin/tmux'
set -g @plugin 'omerxx/tmux-sessionx'

# ─── Session Persistence (survive reboots) ────────────────────────────────────
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-nvim 'session'
set -g @continuum-restore 'off'
set -g @continuum-save-interval '10'

# ─── SessionX ─────────────────────────────────────────────────────────────────
set -g @sessionx-bind 'o'
set -g @sessionx-zoxide-mode 'on'
set -g @sessionx-filter-current 'false'
set -g @sessionx-preview-enabled 'true'

# ─── Catppuccin Theme (v1.0+ API) ─────────────────────────────────────────────
# IMPORTANT: catppuccin/tmux v1.0 changed everything. These @options must be set
# BEFORE the plugin loads (i.e. before `run tpm` below). The actual status-left /
# status-right assembly happens AFTER tpm, further down — because v1.0 makes YOU
# build the bar by appending its pre-styled modules.

set -g @catppuccin_flavor 'mocha'

# ── Window tabs (the worktrunk / tmux / nu pills in the screenshot) ───────────
# "rounded" gives the soft  ▐ pill edges seen in the screenshot.
set -g @catppuccin_window_status_style "rounded"
set -g @catppuccin_window_number_position "right"   # number sits on the right of each tab
set -g @catppuccin_window_flags "icon"

# Text inside each tab: #W = window name, #{b:pane_current_path} = last path segment
set -g @catppuccin_window_text " #W"
set -g @catppuccin_window_current_text " #W"

# Optional: tweak which colors the current vs inactive tab use (Catppuccin names).
set -g @catppuccin_window_current_number_color "#{@thm_mauve}"

# ── Status bar base ───────────────────────────────────────────────────────────
set -g @catppuccin_status_background "default"   # transparent bar; show terminal bg/blur

# ─── TPM (loads plugins, including Catppuccin) ────────────────────────────────
run '~/.tmux/plugins/tpm/tpm'

# ─── HyDE theme colours (generated by themeforge → ~/.config/tmux/theme.conf) ─
# Remaps catppuccin's @thm_* palette to the active HyDE theme. -q: harmless if absent.
source-file -q ~/.config/tmux/theme.conf

# ─── Status bar assembly (v1.0: AFTER the plugin has loaded) ───────────────────
# Now that Catppuccin defined its module variables, we compose the bar ourselves.
# #{E:...} expands the variable recursively so nested #{} inside the module works.
set -g status-left-length 100
set -g status-right-length 100

# LEFT: a small session indicator (the rounded app icon area in the screenshot).
# -F so the #{E:...} format expands instead of printing literally.
set -gF status-left "#{E:@catppuccin_status_session}"

# Module text options must be set BEFORE the module is referenced in status-right.
set -g @catppuccin_date_time_text " %H:%M"

# RIGHT: directory then clock — like a clean status. Add/remove modules freely.
# Use -agF on every append: -a append, -g global, -F expand the #{} format now.
set -g  status-right ""
set -agF status-right "#{E:@catppuccin_status_directory}"
set -agF status-right "#{E:@catppuccin_status_date_time}"
```

### All running tmux key tables

```tmux
bind-key    -T copy-mode    Escape                    send-keys -X cancel
bind-key    -T copy-mode    Space                     send-keys -X page-down
bind-key    -T copy-mode    ,                         send-keys -X jump-reverse
bind-key    -T copy-mode    \;                        send-keys -X jump-again
bind-key    -T copy-mode    F                         command-prompt -1P -p "(jump backward)" { send-keys -X jump-backward -- "%%" }
bind-key    -T copy-mode    L                         send-keys -X line-numbers-toggle
bind-key    -T copy-mode    N                         send-keys -X search-reverse
bind-key    -T copy-mode    P                         send-keys -X toggle-position
bind-key    -T copy-mode    R                         send-keys -X rectangle-toggle
bind-key    -T copy-mode    T                         command-prompt -1P -p "(jump to backward)" { send-keys -X jump-to-backward -- "%%" }
bind-key    -T copy-mode    X                         send-keys -X set-mark
bind-key    -T copy-mode    f                         command-prompt -1P -p "(jump forward)" { send-keys -X jump-forward -- "%%" }
bind-key    -T copy-mode    g                         command-prompt -P -p "(goto line)" { send-keys -X goto-line -- "%%" }
bind-key    -T copy-mode    n                         send-keys -X search-again
bind-key    -T copy-mode    q                         send-keys -X cancel
bind-key    -T copy-mode    r                         send-keys -X refresh-now
bind-key    -T copy-mode    t                         command-prompt -1P -p "(jump to forward)" { send-keys -X jump-to-forward -- "%%" }
bind-key    -T copy-mode    Home                      send-keys -X start-of-line
bind-key    -T copy-mode    End                       send-keys -X end-of-line
bind-key    -T copy-mode    NPage                     send-keys -X page-down
bind-key    -T copy-mode    PPage                     send-keys -X page-up
bind-key    -T copy-mode    Up                        send-keys -X cursor-up
bind-key    -T copy-mode    Down                      send-keys -X cursor-down
bind-key    -T copy-mode    Left                      send-keys -X cursor-left
bind-key    -T copy-mode    Right                     send-keys -X cursor-right
bind-key    -T copy-mode    MouseDown1Pane            select-pane
bind-key    -T copy-mode    MouseDrag1Pane            select-pane \; send-keys -X begin-selection
bind-key    -T copy-mode    MouseDragEnd1Pane         send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode    WheelDownPane             select-pane \; send-keys -X -N 5 scroll-down
bind-key    -T copy-mode    WheelUpPane               select-pane \; send-keys -X -N 5 scroll-up
bind-key    -T copy-mode    DoubleClick1Pane          select-pane \; send-keys -X select-word \; run-shell -d 0.3 \; send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode    TripleClick1Pane          select-pane \; send-keys -X select-line \; run-shell -d 0.3 \; send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode    M-1                       command-prompt -NP -I 1 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-2                       command-prompt -NP -I 2 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-3                       command-prompt -NP -I 3 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-4                       command-prompt -NP -I 4 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-5                       command-prompt -NP -I 5 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-6                       command-prompt -NP -I 6 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-7                       command-prompt -NP -I 7 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-8                       command-prompt -NP -I 8 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-9                       command-prompt -NP -I 9 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode    M-<                       send-keys -X history-top
bind-key    -T copy-mode    M->                       send-keys -X history-bottom
bind-key    -T copy-mode    M-R                       send-keys -X top-line
bind-key    -T copy-mode    M-b                       send-keys -X previous-word
bind-key    -T copy-mode    M-f                       send-keys -X next-word-end
bind-key    -T copy-mode    M-l                       send-keys -X cursor-centre-horizontal
bind-key    -T copy-mode    M-m                       send-keys -X back-to-indentation
bind-key    -T copy-mode    M-r                       send-keys -X middle-line
bind-key    -T copy-mode    M-v                       send-keys -X page-up
bind-key    -T copy-mode    M-w                       send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode    M-x                       send-keys -X jump-to-mark
bind-key    -T copy-mode    "M-{"                     send-keys -X previous-paragraph
bind-key    -T copy-mode    "M-}"                     send-keys -X next-paragraph
bind-key    -T copy-mode    M-Up                      send-keys -X halfpage-up
bind-key    -T copy-mode    M-Down                    send-keys -X halfpage-down
bind-key    -T copy-mode    C-Space                   send-keys -X begin-selection
bind-key    -T copy-mode    C-[                       send-keys -X cancel
bind-key    -T copy-mode    C-a                       send-keys -X start-of-line
bind-key    -T copy-mode    C-b                       send-keys -X cursor-left
bind-key    -T copy-mode    C-c                       send-keys -X cancel
bind-key    -T copy-mode    C-e                       send-keys -X end-of-line
bind-key    -T copy-mode    C-f                       send-keys -X cursor-right
bind-key    -T copy-mode    C-g                       send-keys -X clear-selection
bind-key    -T copy-mode    C-k                       send-keys -X copy-pipe-end-of-line-and-cancel
bind-key    -T copy-mode    C-l                       send-keys -X recentre-top-bottom
bind-key    -T copy-mode    C-n                       send-keys -X cursor-down
bind-key    -T copy-mode    C-p                       send-keys -X cursor-up
bind-key    -T copy-mode    C-r                       command-prompt -Pi -I "#{pane_search_string}" -T search -p "(search up)" { send-keys -X search-backward-incremental -- "%%" }
bind-key    -T copy-mode    C-s                       command-prompt -Pi -I "#{pane_search_string}" -T search -p "(search down)" { send-keys -X search-forward-incremental -- "%%" }
bind-key    -T copy-mode    C-v                       send-keys -X page-down
bind-key    -T copy-mode    C-w                       send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode    C-Up                      send-keys -X scroll-up
bind-key    -T copy-mode    C-Down                    send-keys -X scroll-down
bind-key    -T copy-mode    C-M-b                     send-keys -X previous-matching-bracket
bind-key    -T copy-mode    C-M-f                     send-keys -X next-matching-bracket
bind-key    -T copy-mode    C-M-Up                    send-keys -X previous-prompt
bind-key    -T copy-mode    C-M-Down                  send-keys -X next-prompt
bind-key    -T copy-mode-vi Enter                     send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode-vi Escape                    send-keys -X cancel
bind-key    -T copy-mode-vi Space                     send-keys -X begin-selection
bind-key    -T copy-mode-vi \#                        send-keys -FX search-backward -- "#{copy_cursor_word}"
bind-key    -T copy-mode-vi \$                        send-keys -X end-of-line
bind-key    -T copy-mode-vi \%                        send-keys -X next-matching-bracket
bind-key    -T copy-mode-vi *                         send-keys -FX search-forward -- "#{copy_cursor_word}"
bind-key    -T copy-mode-vi ,                         send-keys -X jump-reverse
bind-key    -T copy-mode-vi /                         command-prompt -P -T search -p "(search down)" { send-keys -X search-forward -- "%%" }
bind-key    -T copy-mode-vi 0                         send-keys -X start-of-line
bind-key    -T copy-mode-vi 1                         command-prompt -NP -I 1 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi 2                         command-prompt -NP -I 2 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi 3                         command-prompt -NP -I 3 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi 4                         command-prompt -NP -I 4 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi 5                         command-prompt -NP -I 5 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi 6                         command-prompt -NP -I 6 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi 7                         command-prompt -NP -I 7 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi 8                         command-prompt -NP -I 8 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi 9                         command-prompt -NP -I 9 -p (repeat) { send-keys -N "%%" }
bind-key    -T copy-mode-vi :                         command-prompt -P -p "(goto line)" { send-keys -X goto-line -- "%%" }
bind-key    -T copy-mode-vi \;                        send-keys -X jump-again
bind-key    -T copy-mode-vi ?                         command-prompt -P -T search -p "(search up)" { send-keys -X search-backward -- "%%" }
bind-key    -T copy-mode-vi A                         send-keys -X append-selection-and-cancel
bind-key    -T copy-mode-vi B                         send-keys -X previous-space
bind-key    -T copy-mode-vi D                         send-keys -X copy-pipe-end-of-line-and-cancel
bind-key    -T copy-mode-vi E                         send-keys -X next-space-end
bind-key    -T copy-mode-vi F                         command-prompt -1P -p "(jump backward)" { send-keys -X jump-backward -- "%%" }
bind-key    -T copy-mode-vi G                         send-keys -X history-bottom
bind-key    -T copy-mode-vi H                         send-keys -X start-of-line
bind-key    -T copy-mode-vi J                         send-keys -X scroll-down
bind-key    -T copy-mode-vi K                         send-keys -X scroll-up
bind-key    -T copy-mode-vi L                         send-keys -X end-of-line
bind-key    -T copy-mode-vi M                         send-keys -X middle-line
bind-key    -T copy-mode-vi N                         send-keys -X search-reverse
bind-key    -T copy-mode-vi P                         send-keys -X toggle-position
bind-key    -T copy-mode-vi T                         command-prompt -1P -p "(jump to backward)" { send-keys -X jump-to-backward -- "%%" }
bind-key    -T copy-mode-vi V                         send-keys -X select-line
bind-key    -T copy-mode-vi W                         send-keys -X next-space
bind-key    -T copy-mode-vi X                         send-keys -X set-mark
bind-key    -T copy-mode-vi Y                         send-keys -X copy-line
bind-key    -T copy-mode-vi ^                         send-keys -X back-to-indentation
bind-key    -T copy-mode-vi b                         send-keys -X previous-word
bind-key    -T copy-mode-vi e                         send-keys -X next-word-end
bind-key    -T copy-mode-vi f                         command-prompt -1P -p "(jump forward)" { send-keys -X jump-forward -- "%%" }
bind-key    -T copy-mode-vi g                         send-keys -X history-top
bind-key    -T copy-mode-vi h                         send-keys -X cursor-left
bind-key    -T copy-mode-vi j                         send-keys -X cursor-down
bind-key    -T copy-mode-vi k                         send-keys -X cursor-up
bind-key    -T copy-mode-vi l                         send-keys -X cursor-right
bind-key    -T copy-mode-vi n                         send-keys -X search-again
bind-key    -T copy-mode-vi o                         send-keys -X other-end
bind-key    -T copy-mode-vi q                         send-keys -X cancel
bind-key    -T copy-mode-vi r                         send-keys -X refresh-now
bind-key    -T copy-mode-vi t                         command-prompt -1P -p "(jump to forward)" { send-keys -X jump-to-forward -- "%%" }
bind-key    -T copy-mode-vi v                         send-keys -X begin-selection
bind-key    -T copy-mode-vi w                         send-keys -X next-word
bind-key    -T copy-mode-vi y                         send-keys -X copy-pipe-and-cancel wl-copy
bind-key    -T copy-mode-vi z                         send-keys -X scroll-middle
bind-key    -T copy-mode-vi \{                        send-keys -X previous-paragraph
bind-key    -T copy-mode-vi \}                        send-keys -X next-paragraph
bind-key    -T copy-mode-vi BSpace                    send-keys -X cursor-left
bind-key    -T copy-mode-vi Home                      send-keys -X start-of-line
bind-key    -T copy-mode-vi End                       send-keys -X end-of-line
bind-key    -T copy-mode-vi NPage                     send-keys -X page-down
bind-key    -T copy-mode-vi PPage                     send-keys -X page-up
bind-key    -T copy-mode-vi Up                        send-keys -X cursor-up
bind-key    -T copy-mode-vi Down                      send-keys -X cursor-down
bind-key    -T copy-mode-vi Left                      send-keys -X cursor-left
bind-key    -T copy-mode-vi Right                     send-keys -X cursor-right
bind-key    -T copy-mode-vi MouseDown1Pane            select-pane
bind-key    -T copy-mode-vi MouseDrag1Pane            select-pane \; send-keys -X begin-selection
bind-key    -T copy-mode-vi MouseDragEnd1Pane         send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode-vi WheelDownPane             select-pane \; send-keys -X -N 5 scroll-down
bind-key    -T copy-mode-vi WheelUpPane               select-pane \; send-keys -X -N 5 scroll-up
bind-key    -T copy-mode-vi DoubleClick1Pane          select-pane \; send-keys -X select-word \; run-shell -d 0.3 \; send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode-vi TripleClick1Pane          select-pane \; send-keys -X select-line \; run-shell -d 0.3 \; send-keys -X copy-pipe-and-cancel
bind-key    -T copy-mode-vi M-x                       send-keys -X jump-to-mark
bind-key    -T copy-mode-vi C-[                       send-keys -X clear-selection
bind-key    -T copy-mode-vi C-\\                      select-pane -l
bind-key    -T copy-mode-vi C-b                       send-keys -X page-up
bind-key    -T copy-mode-vi C-c                       send-keys -X cancel
bind-key    -T copy-mode-vi C-d                       send-keys -X halfpage-down
bind-key    -T copy-mode-vi C-e                       send-keys -X scroll-down
bind-key    -T copy-mode-vi C-f                       send-keys -X page-down
bind-key    -T copy-mode-vi C-h                       select-pane -L
bind-key    -T copy-mode-vi C-j                       select-pane -D
bind-key    -T copy-mode-vi C-k                       select-pane -U
bind-key    -T copy-mode-vi C-l                       select-pane -R
bind-key    -T copy-mode-vi C-u                       send-keys -X halfpage-up
bind-key    -T copy-mode-vi C-v                       send-keys -X rectangle-toggle
bind-key    -T copy-mode-vi C-y                       send-keys -X scroll-up
bind-key    -T copy-mode-vi C-Up                      send-keys -X scroll-up
bind-key    -T copy-mode-vi C-Down                    send-keys -X scroll-down
bind-key    -T move         ,                         if-shell -F "#{pane_floating_flag}" { display-menu -T "#[align=centre]Move" -x P -y P Centre c { move-pane -P centre } '' "Top Left" 1 { move-pane -P top-left } "Top Right" 2 { move-pane -P top-right } "Bottom Left" 3 { move-pane -P bottom-left } "Bottom Right" 4 { move-pane -P bottom-right } '' Top t { move-pane -P top-centre } Bottom b { move-pane -P bottom-centre } Left l { move-pane -P centre-left } Right r { move-pane -P centre-right } }
bind-key    -T move         .                         if-shell -F "#{pane_floating_flag}" { display-menu -T "#[align=centre]Move & Resize" -x P -y P Fill 0 { resize-pane -x "100%" -y "100%" ; move-pane -P top-left } '' "Top Left" 1 { resize-pane -x "50%" -y "50%" ; move-pane -P top-left } "Top Right" 2 { resize-pane -x "50%" -y "50%" ; move-pane -P top-right } "Bottom Left" 3 { resize-pane -x "50%" -y "50%" ; move-pane -P bottom-left } "Bottom Right" 4 { resize-pane -x "50%" -y "50%" ; move-pane -P bottom-right } '' Top t { resize-pane -x "100%" -y "50%" ; move-pane -P top-centre } Bottom b { resize-pane -x "100%" -y "50%" ; move-pane -P bottom-centre } Left l { resize-pane -x "50%" -y "100%" ; move-pane -P centre-left } Right r { resize-pane -x "50%" -y "100%" ; move-pane -P centre-right } }
bind-key    -T move         0                         resize-pane -x "100%" -y "100%" \; move-pane -P top-left
bind-key    -T move         1                         move-pane -P top-left
bind-key    -T move         2                         move-pane -P top-right
bind-key    -T move         3                         move-pane -P bottom-left
bind-key    -T move         4                         move-pane -P bottom-right
bind-key    -T move         Up                        move-pane -P top-centre
bind-key    -T move         Down                      move-pane -P bottom-centre
bind-key    -T move         Left                      move-pane -P centre-left
bind-key    -T move         Right                     move-pane -P centre-right
bind-key    -T move         M-1                       resize-pane -x "50%" -y "50%" \; move-pane -P top-left
bind-key    -T move         M-2                       resize-pane -x "50%" -y "50%" \; move-pane -P top-right
bind-key    -T move         M-3                       resize-pane -x "50%" -y "50%" \; move-pane -P bottom-left
bind-key    -T move         M-4                       resize-pane -x "50%" -y "50%" \; move-pane -P bottom-right
bind-key    -T move         M-Up                      resize-pane -x "100%" -y "50%" \; move-pane -P top-centre
bind-key    -T move         M-Down                    resize-pane -x "100%" -y "50%" \; move-pane -P bottom-centre
bind-key    -T move         M-Left                    resize-pane -x "50%" -y "100%" \; move-pane -P centre-left
bind-key    -T move         M-Right                   resize-pane -x "50%" -y "100%" \; move-pane -P centre-right
bind-key    -T prefix       Tab                       last-window
bind-key    -T prefix       Enter                     copy-mode
bind-key    -T prefix       Space                     next-layout
bind-key    -T prefix       !                         break-pane
bind-key    -T prefix       \"                        split-window
bind-key    -T prefix       \#                        list-buffers
bind-key    -T prefix       \$                        command-prompt -I "#S" { rename-session "%%" }
bind-key    -T prefix       \%                        split-window -h
bind-key    -T prefix       &                         confirm-before -p "kill-window #W? (y/n)" kill-window
bind-key    -T prefix       \'                        command-prompt -p index { select-window -t ":%%" }
bind-key    -T prefix       (                         switch-client -p
bind-key    -T prefix       )                         switch-client -n
bind-key    -T prefix       *                         new-pane
bind-key    -T prefix       ,                         command-prompt -I "#W" { rename-window "%%" }
bind-key    -T prefix       -                         delete-buffer
bind-key    -T prefix       .                         command-prompt { move-window -t "%%" }
bind-key    -T prefix       /                         command-prompt -k -p key { list-keys -1N "%%" }
bind-key    -T prefix       0                         select-window -t :=0
bind-key    -T prefix       1                         select-window -t :=1
bind-key    -T prefix       2                         select-window -t :=2
bind-key    -T prefix       3                         select-window -t :=3
bind-key    -T prefix       4                         select-window -t :=4
bind-key    -T prefix       5                         select-window -t :=5
bind-key    -T prefix       6                         select-window -t :=6
bind-key    -T prefix       7                         select-window -t :=7
bind-key    -T prefix       8                         select-window -t :=8
bind-key    -T prefix       9                         select-window -t :=9
bind-key    -T prefix       :                         command-prompt
bind-key    -T prefix       \;                        last-pane
bind-key    -T prefix       <                         swap-pane -U
bind-key    -T prefix       =                         choose-buffer -Z
bind-key    -T prefix       >                         swap-pane -D
bind-key    -T prefix       ?                         list-keys -N
bind-key    -T prefix       @                         if-shell -F "#{pane_floating_flag}" { join-pane } { break-pane -W }
bind-key    -T prefix       C                         customize-mode -Z
bind-key    -T prefix       D                         choose-client -Z
bind-key    -T prefix       E                         select-layout -E
bind-key -r -T prefix       H                         resize-pane -L 5
bind-key    -T prefix       I                         run-shell /home/sog/.tmux/plugins/tpm/bindings/install_plugins
bind-key -r -T prefix       J                         resize-pane -D 5
bind-key    -T prefix       K                         confirm-before -p "Kill session #S? (y/n)" kill-session
bind-key -r -T prefix       L                         resize-pane -R 5
bind-key    -T prefix       M                         select-pane -M
bind-key    -T prefix       N                         command-prompt -p "New session:" "new-session -s '%%'"
bind-key    -T prefix       R                         run-shell " \t\t\ttmux source-file /home/sog/.tmux.conf > /dev/null; \t\t\ttmux display-message 'Sourced /home/sog/.tmux.conf!'"
bind-key    -T prefix       T                         command-prompt -I "#T" { select-pane -T "%%" }
bind-key    -T prefix       U                         run-shell /home/sog/.tmux/plugins/tpm/bindings/update_plugins
bind-key    -T prefix       [                         copy-mode
bind-key    -T prefix       ]                         paste-buffer -p
bind-key    -T prefix       c                         new-window -c "#{pane_current_path}"
bind-key    -T prefix       d                         detach-client
bind-key    -T prefix       f                         display-popup -E -d "#{pane_current_path}" -h "90%" -w "90%" zsh
bind-key    -T prefix       g                         display-popup -E -d "#{pane_current_path}" -h "90%" -w "90%" lazygit
bind-key    -T prefix       i                         display-message
bind-key    -T prefix       l                         last-window
bind-key    -T prefix       m                         select-pane -m
bind-key -r -T prefix       n                         next-window
bind-key    -T prefix       o                         run-shell /home/sog/.tmux/plugins/tmux-sessionx/scripts/sessionx.sh
bind-key -r -T prefix       p                         previous-window
bind-key    -T prefix       q                         display-panes
bind-key    -T prefix       r                         source-file /home/sog/.tmux.conf \; display-message "Config reloaded!"
bind-key    -T prefix       s                         split-window -v -c "#{pane_current_path}"
bind-key    -T prefix       t                         clock-mode
bind-key    -T prefix       v                         split-window -h -c "#{pane_current_path}"
bind-key    -T prefix       w                         choose-tree -Zw
bind-key    -T prefix       x                         confirm-before -p "kill-pane #P? (y/n)" kill-pane
bind-key    -T prefix       z                         resize-pane -Z
bind-key    -T prefix       \{                        swap-pane -U
bind-key    -T prefix       \}                        swap-pane -D
bind-key    -T prefix       \~                        show-messages
bind-key -r -T prefix       DC                        refresh-client -c
bind-key    -T prefix       PPage                     copy-mode -u
bind-key    -T prefix       BTab                      new-pane -E -X 0 -Y 0 -x "75%" -y "30%" \; move-pane -P bottom-centre \; switch-mode -ks
bind-key -r -T prefix       Up                        select-pane -U
bind-key -r -T prefix       Down                      select-pane -D
bind-key -r -T prefix       Left                      select-pane -L
bind-key -r -T prefix       Right                     select-pane -R
bind-key    -T prefix       M-1                       select-layout even-horizontal
bind-key    -T prefix       M-2                       select-layout even-vertical
bind-key    -T prefix       M-3                       select-layout main-horizontal
bind-key    -T prefix       M-4                       select-layout main-vertical
bind-key    -T prefix       M-5                       select-layout tiled
bind-key    -T prefix       M-6                       select-layout main-horizontal-mirrored
bind-key    -T prefix       M-7                       select-layout main-vertical-mirrored
bind-key    -T prefix       M-n                       next-window -a
bind-key    -T prefix       M-o                       rotate-window -D
bind-key    -T prefix       M-p                       previous-window -a
bind-key    -T prefix       M-u                       run-shell /home/sog/.tmux/plugins/tpm/bindings/clean_plugins
bind-key -r -T prefix       M-Up                      if-shell -F "#{?floating_pane_flag}" { resize-pane -D -5 } { resize-pane -U 5 }
bind-key -r -T prefix       M-Down                    resize-pane -D 5
bind-key -r -T prefix       M-Left                    if-shell -F "#{?floating_pane_flag}" { resize-pane -R -5 } { resize-pane -L 5 }
bind-key -r -T prefix       M-Right                   resize-pane -R 5
bind-key    -T prefix       C-Space                   send-prefix
bind-key    -T prefix       C-l                       send-keys C-l
bind-key    -T prefix       C-n                       next-window
bind-key    -T prefix       C-o                       rotate-window
bind-key    -T prefix       C-p                       previous-window
bind-key    -T prefix       C-z                       suspend-client
bind-key -r -T prefix       C-Up                      if-shell -F "#{?floating_pane_flag}" { resize-pane -D -1 } { resize-pane -U -- }
bind-key -r -T prefix       C-Down                    resize-pane -D --
bind-key -r -T prefix       C-Left                    if-shell -F "#{?floating_pane_flag}" { resize-pane -R -1 } { resize-pane -L -- }
bind-key -r -T prefix       C-Right                   resize-pane -R --
bind-key -r -T prefix       S-Up                      refresh-client -U 10
bind-key -r -T prefix       S-Down                    refresh-client -D 10
bind-key -r -T prefix       S-Left                    refresh-client -L 10
bind-key -r -T prefix       S-Right                   refresh-client -R 10
bind-key    -T root         MouseDown1Pane            select-pane -t = \; send-keys -M
bind-key    -T root         MouseDown1Status          switch-client -t =
bind-key    -T root         MouseDown1Border          select-pane -t =
bind-key    -T root         MouseDown1ScrollbarUp     if-shell -F -t = "#{pane_in_mode}" { send-keys -X page-up } { copy-mode -u }
bind-key    -T root         MouseDown1ScrollbarDown   if-shell -F -t = "#{pane_in_mode}" { send-keys -X page-down } { copy-mode -d }
bind-key    -T root         MouseDown1Control7        if-shell -F -t = "#{pane_floating_flag}" { join-pane } { break-pane -W }
bind-key    -T root         MouseDown1Control8        resize-pane -Z
bind-key    -T root         MouseDown1Control9        display-menu -O -T "Kill pane #{pane_index}?" -t = -x M -y M Yes y { kill-pane -t = } No n {  }
bind-key    -T root         MouseDown2Pane            select-pane -t = \; if-shell -F "#{||:#{pane_in_mode},#{mouse_any_flag}}" { send-keys -M } { paste-buffer -p }
bind-key    -T root         MouseDown3Pane            if-shell -F -t = "#{||:#{mouse_any_flag},#{&&:#{pane_in_mode},#{?#{m/r:(copy|view)-mode,#{pane_mode}},0,1}}}" { select-pane -t = ; send-keys -M } { display-menu -T "#[align=centre]#{pane_index} (#{pane_id})" -t = -x M -y M "#{?#{m/r:(copy|view)-mode,#{pane_mode}},Go To Top,}" < { send-keys -X history-top } "#{?#{m/r:(copy|view)-mode,#{pane_mode}},Go To Bottom,}" > { send-keys -X history-bottom } '' "#{?#{==:#{pane_mode},copy-mode},#{?copy_line_numbers,Hide Line Numbers,Show Line Numbers},}" L { send-keys -X line-numbers-toggle } "#{?#{==:#{pane_mode},copy-mode},#{?refresh_active,Refresh Off,Refresh On},}" r { send-keys -X refresh-toggle } '' "#{?#{&&:#{buffer_size},#{!:#{pane_in_mode}}},Paste #[underscore]#{=/9/...:buffer_sample},}" p { paste-buffer } '' "#{?mouse_word,Search For #[underscore]#{=/9/...:mouse_word},}" C-r { if-shell -F "#{?#{m/r:(copy|view)-mode,#{pane_mode}},0,1}" "copy-mode -t=" ; send-keys -X -t = search-backward -- "#{q:mouse_word}" } "#{?mouse_word,Type #[underscore]#{=/9/...:mouse_word},}" C-y { copy-mode -q ; send-keys -l "#{q:mouse_word}" } "#{?mouse_word,Copy #[underscore]#{=/9/...:mouse_word},}" c { copy-mode -q ; set-buffer "#{q:mouse_word}" } "#{?mouse_line,Copy Line,}" l { copy-mode -q ; set-buffer "#{q:mouse_line}" } '' "#{?mouse_hyperlink,Type #[underscore]#{=/9/...:mouse_hyperlink},}" C-h { copy-mode -q ; send-keys -l "#{q:mouse_hyperlink}" } "#{?mouse_hyperlink,Copy #[underscore]#{=/9/...:mouse_hyperlink},}" h { copy-mode -q ; set-buffer "#{q:mouse_hyperlink}" } '' "#{?#{#{pane_floating_flag}},Move,}" '' { display-menu -T "#[align=centre]Move" -x L -y L Centre c { move-pane -P centre } '' "Top Left" 1 { move-pane -P top-left } "Top Right" 2 { move-pane -P top-right } "Bottom Left" 3 { move-pane -P bottom-left } "Bottom Right" 4 { move-pane -P bottom-right } '' Top t { move-pane -P top-centre } Bottom b { move-pane -P bottom-centre } Left l { move-pane -P centre-left } Right r { move-pane -P centre-right } } "#{?#{#{pane_floating_flag}},Move & Resize,}" '' { display-menu -T "#[align=centre]Move & Resize" -x L -y L Fill 0 { resize-pane -x "100%" -y "100%" ; move-pane -P top-left } '' "Top Left" 1 { resize-pane -x "50%" -y "50%" ; move-pane -P top-left } "Top Right" 2 { resize-pane -x "50%" -y "50%" ; move-pane -P top-right } "Bottom Left" 3 { resize-pane -x "50%" -y "50%" ; move-pane -P bottom-left } "Bottom Right" 4 { resize-pane -x "50%" -y "50%" ; move-pane -P bottom-right } '' Top t { resize-pane -x "100%" -y "50%" ; move-pane -P top-centre } Bottom b { resize-pane -x "100%" -y "50%" ; move-pane -P bottom-centre } Left l { resize-pane -x "50%" -y "100%" ; move-pane -P centre-left } Right r { resize-pane -x "50%" -y "100%" ; move-pane -P centre-right } } "#{?#{#{pane_floating_flag}},Tile,}" t { join-pane } "#{?#{!:#{pane_floating_flag}},Float,}" f { break-pane -W } "#{?#{!:#{pane_floating_flag}},Horizontal Split,}" h { split-window -h } "#{?#{!:#{pane_floating_flag}},Vertical Split,}" v { split-window -v } '' "#{?#{&&:#{!:#{pane_floating_flag}},#{>:#{window_panes},1}},Swap Up,}" u { swap-pane -U } "#{?#{&&:#{!:#{pane_floating_flag}},#{>:#{window_panes},1}},Swap Down,}" d { swap-pane -D } "#{?pane_marked_set,,-}Swap Marked" s { swap-pane } '' Kill X { kill-pane } Respawn R { respawn-pane -k } "#{?pane_marked,Unmark,Mark}" m { select-pane -m } "#{?#{>:#{window_panes},1},,-}#{?window_zoomed_flag,Unzoom,Zoom}" z { resize-pane -Z } }
bind-key    -T root         MouseDown3Status          display-menu -T "#[align=centre]#{window_index}:#{window_name}" -t = -x W -y W "#{?#{>:#{session_windows},1},,-}Swap Left" l { swap-window -t :-1 } "#{?#{>:#{session_windows},1},,-}Swap Right" r { swap-window -t :+1 } "#{?pane_marked_set,,-}Swap Marked" s { swap-window } '' Kill X { kill-window } Respawn R { respawn-window -k } "#{?pane_marked,Unmark,Mark}" m { select-pane -m } Rename n { command-prompt -F -I "#W" { rename-window -t "#{window_id}" "%%" } } '' "New After" w { new-window -a } "New At End" W { new-window }
bind-key    -T root         MouseDown3StatusLeft      run-shell -C "display-menu -t= -xM -yW -T '#[align=centre]#{session_name}'  #{S/t:#{?#{&&:#{<:#{loop_index},6},#{!:#{session_active}}},'Switch To #[underscore]#{session_name}' '' {switch-client -t=#{session_id}#} ,}} '' 'Renumber' 'N' {move-window -r} 'Rename' 'r' {command-prompt -I '#S' {rename-session -- '%%'}} 'Detach' 'd' {detach-client} '' 'New Session' 's' {new-session} 'New Window' 'w' {new-window}"
bind-key    -T root         MouseDown3Empty           display-menu -T "#[align=centre]#{window_index}:#{window_name}" -t = -x M -y M "New Pane" p { new-pane ; join-pane } "New Window" w { new-window }
bind-key    -T root         MouseDrag1Pane            if-shell -F "#{||:#{pane_in_mode},#{mouse_any_flag}}" { send-keys -M } { copy-mode -M }
bind-key    -T root         MouseDrag1Border          resize-pane -M
bind-key    -T root         MouseDrag1ScrollbarSlider if-shell -F -t = "#{pane_in_mode}" { send-keys -X scroll-to-mouse } { copy-mode -S }
bind-key    -T root         WheelDownStatus           next-window
bind-key    -T root         WheelUpPane               if-shell -F "#{||:#{alternate_on},#{pane_in_mode},#{mouse_any_flag}}" { send-keys -M } { copy-mode -e }
bind-key    -T root         WheelUpStatus             previous-window
bind-key    -T root         DoubleClick1Pane          select-pane -t = \; if-shell -F "#{||:#{pane_in_mode},#{mouse_any_flag}}" { send-keys -M } { copy-mode -H ; send-keys -X select-word ; run-shell -d 0.3 ; send-keys -X copy-pipe-and-cancel }
bind-key    -T root         TripleClick1Pane          select-pane -t = \; if-shell -F "#{||:#{pane_in_mode},#{mouse_any_flag}}" { send-keys -M } { copy-mode -H ; send-keys -X select-line ; run-shell -d 0.3 ; send-keys -X copy-pipe-and-cancel }
bind-key    -T root         M-MouseDown3Pane          display-menu -T "#[align=centre]#{pane_index} (#{pane_id})" -t = -x M -y M "#{?#{m/r:(copy|view)-mode,#{pane_mode}},Go To Top,}" < { send-keys -X history-top } "#{?#{m/r:(copy|view)-mode,#{pane_mode}},Go To Bottom,}" > { send-keys -X history-bottom } '' "#{?#{==:#{pane_mode},copy-mode},#{?copy_line_numbers,Hide Line Numbers,Show Line Numbers},}" L { send-keys -X line-numbers-toggle } "#{?#{==:#{pane_mode},copy-mode},#{?refresh_active,Refresh Off,Refresh On},}" r { send-keys -X refresh-toggle } '' "#{?#{&&:#{buffer_size},#{!:#{pane_in_mode}}},Paste #[underscore]#{=/9/...:buffer_sample},}" p { paste-buffer } '' "#{?mouse_word,Search For #[underscore]#{=/9/...:mouse_word},}" C-r { if-shell -F "#{?#{m/r:(copy|view)-mode,#{pane_mode}},0,1}" "copy-mode -t=" ; send-keys -X -t = search-backward -- "#{q:mouse_word}" } "#{?mouse_word,Type #[underscore]#{=/9/...:mouse_word},}" C-y { copy-mode -q ; send-keys -l "#{q:mouse_word}" } "#{?mouse_word,Copy #[underscore]#{=/9/...:mouse_word},}" c { copy-mode -q ; set-buffer "#{q:mouse_word}" } "#{?mouse_line,Copy Line,}" l { copy-mode -q ; set-buffer "#{q:mouse_line}" } '' "#{?mouse_hyperlink,Type #[underscore]#{=/9/...:mouse_hyperlink},}" C-h { copy-mode -q ; send-keys -l "#{q:mouse_hyperlink}" } "#{?mouse_hyperlink,Copy #[underscore]#{=/9/...:mouse_hyperlink},}" h { copy-mode -q ; set-buffer "#{q:mouse_hyperlink}" } '' "#{?#{#{pane_floating_flag}},Move,}" '' { display-menu -T "#[align=centre]Move" -x L -y L Centre c { move-pane -P centre } '' "Top Left" 1 { move-pane -P top-left } "Top Right" 2 { move-pane -P top-right } "Bottom Left" 3 { move-pane -P bottom-left } "Bottom Right" 4 { move-pane -P bottom-right } '' Top t { move-pane -P top-centre } Bottom b { move-pane -P bottom-centre } Left l { move-pane -P centre-left } Right r { move-pane -P centre-right } } "#{?#{#{pane_floating_flag}},Move & Resize,}" '' { display-menu -T "#[align=centre]Move & Resize" -x L -y L Fill 0 { resize-pane -x "100%" -y "100%" ; move-pane -P top-left } '' "Top Left" 1 { resize-pane -x "50%" -y "50%" ; move-pane -P top-left } "Top Right" 2 { resize-pane -x "50%" -y "50%" ; move-pane -P top-right } "Bottom Left" 3 { resize-pane -x "50%" -y "50%" ; move-pane -P bottom-left } "Bottom Right" 4 { resize-pane -x "50%" -y "50%" ; move-pane -P bottom-right } '' Top t { resize-pane -x "100%" -y "50%" ; move-pane -P top-centre } Bottom b { resize-pane -x "100%" -y "50%" ; move-pane -P bottom-centre } Left l { resize-pane -x "50%" -y "100%" ; move-pane -P centre-left } Right r { resize-pane -x "50%" -y "100%" ; move-pane -P centre-right } } "#{?#{#{pane_floating_flag}},Tile,}" t { join-pane } "#{?#{!:#{pane_floating_flag}},Float,}" f { break-pane -W } "#{?#{!:#{pane_floating_flag}},Horizontal Split,}" h { split-window -h } "#{?#{!:#{pane_floating_flag}},Vertical Split,}" v { split-window -v } '' "#{?#{&&:#{!:#{pane_floating_flag}},#{>:#{window_panes},1}},Swap Up,}" u { swap-pane -U } "#{?#{&&:#{!:#{pane_floating_flag}},#{>:#{window_panes},1}},Swap Down,}" d { swap-pane -D } "#{?pane_marked_set,,-}Swap Marked" s { swap-pane } '' Kill X { kill-pane } Respawn R { respawn-pane -k } "#{?pane_marked,Unmark,Mark}" m { select-pane -m } "#{?#{>:#{window_panes},1},,-}#{?window_zoomed_flag,Unzoom,Zoom}" z { resize-pane -Z }
bind-key    -T root         M-MouseDown3Status        display-menu -T "#[align=centre]#{window_index}:#{window_name}" -t = -x W -y W "#{?#{>:#{session_windows},1},,-}Swap Left" l { swap-window -t :-1 } "#{?#{>:#{session_windows},1},,-}Swap Right" r { swap-window -t :+1 } "#{?pane_marked_set,,-}Swap Marked" s { swap-window } '' Kill X { kill-window } Respawn R { respawn-window -k } "#{?pane_marked,Unmark,Mark}" m { select-pane -m } Rename n { command-prompt -F -I "#W" { rename-window -t "#{window_id}" "%%" } } '' "New After" w { new-window -a } "New At End" W { new-window }
bind-key    -T root         M-MouseDown3StatusLeft    run-shell -C "display-menu -t= -xM -yW -T '#[align=centre]#{session_name}'  #{S/t:#{?#{&&:#{<:#{loop_index},6},#{!:#{session_active}}},'Switch To #[underscore]#{session_name}' '' {switch-client -t=#{session_id}#} ,}} '' 'Renumber' 'N' {move-window -r} 'Rename' 'r' {command-prompt -I '#S' {rename-session -- '%%'}} 'Detach' 'd' {detach-client} '' 'New Session' 's' {new-session} 'New Window' 'w' {new-window}"
bind-key    -T root         M-MouseDown3Empty         display-menu -T "#[align=centre]#{window_index}:#{window_name}" -t = -x M -y M "New Pane" p { new-pane ; join-pane } "New Window" w { new-window }
bind-key    -T root         M-MouseDrag1Pane          move-pane -M
bind-key    -T root         M-MouseDrag1Border        move-pane -M
bind-key    -T root         C-\\                      if-shell "ps -o state= -o comm= -t '#{pane_tty}'       | grep -iqE '^[^TXZ ]+ +(\\S+/)?g?\\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'" "send-keys 'C-\\'" "select-pane -l"
bind-key    -T root         C-h                       if-shell "ps -o state= -o comm= -t '#{pane_tty}'       | grep -iqE '^[^TXZ ]+ +(\\S+/)?g?\\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'" "send-keys 'C-h'" "select-pane -L"
bind-key    -T root         C-j                       if-shell "ps -o state= -o comm= -t '#{pane_tty}'       | grep -iqE '^[^TXZ ]+ +(\\S+/)?g?\\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'" "send-keys 'C-j'" "select-pane -D"
bind-key    -T root         C-k                       if-shell "ps -o state= -o comm= -t '#{pane_tty}'       | grep -iqE '^[^TXZ ]+ +(\\S+/)?g?\\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'" "send-keys 'C-k'" "select-pane -U"
bind-key    -T root         C-l                       if-shell "ps -o state= -o comm= -t '#{pane_tty}'       | grep -iqE '^[^TXZ ]+ +(\\S+/)?g?\\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'" "send-keys 'C-l'" "select-pane -R"
bind-key    -T root         C-MouseDown1Status        swap-window -t @
bind-key    -T root         C-MouseDrag1Pane          new-pane -M
bind-key    -T root         C-MouseDrag1Empty         new-pane -M
```

### ~/.tmux/plugins/tmux-sessionx/scripts/sessionx.sh

```sh
#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT="$(tmux display-message -p '#S')"
Z_MODE="off"

source "$CURRENT_DIR/tmuxinator.sh"
source "$CURRENT_DIR/fzf-marks.sh"
source "$CURRENT_DIR/git-branch.sh"

get_sorted_sessions() {
	last_session=$(tmux display-message -p '#{client_last_session}')
	sessions=$(tmux list-sessions | sed -E 's/:.*$//' | grep -Fxv "$last_session")
	filtered_sessions=$(tmux show-option -gqv @sessionx-_filtered-sessions)
	if [[ -n "$filtered_sessions" ]]; then
	  filtered_and_piped=$(echo "$filtered_sessions" | sed -E 's/,/|/g')
	  sessions=$(echo "$sessions" | grep -Ev "$filtered_and_piped")
	fi
	local sorted
	sorted=$(echo -e "$sessions\n$last_session" | awk '!seen[$0]++')
	echo "$sorted"
}

tmux_option_or_fallback() {
	local option_value
	option_value="$(tmux show-option -gqv "$1")"
	if [ -z "$option_value" ]; then
		option_value="$2"
	fi
	echo "$option_value"
}

input() {
	default_window_mode=$(tmux show-option -gqv @sessionx-_window-mode)
	if [[ "$default_window_mode" == "on" ]]; then
		tmux list-windows -a -F '#{session_name}:#{window_index} #{window_name}'
	else
		filter_current_session=$(tmux show-option -gqv @sessionx-_filter-current)
		if [[ "$filter_current_session" == "true" ]]; then
			(get_sorted_sessions | grep -Fxv "$CURRENT") || echo "$CURRENT"
		else
			(get_sorted_sessions) || echo "$CURRENT"
		fi
	fi
}

additional_input() {
	sessions=$(get_sorted_sessions)
	custom_paths=$(tmux show-option -gqv @sessionx-_custom-paths)
	custom_path_subdirectories=$(tmux show-option -gqv @sessionx-_custom-paths-subdirectories)
	if [[ -z "$custom_paths" ]]; then
		echo ""
	else
		clean_paths=$(echo "$custom_paths" | sed -E 's/ *, */,/g' | sed -E 's/^ *//' | sed -E 's/ *$//' | sed -E 's/ /✗/g')
		if [[ "$custom_path_subdirectories" == "true" ]]; then
			paths=$(find ${clean_paths//,/ } -mindepth 1 -maxdepth 1 -type d)
		else
			paths=${clean_paths//,/ }
		fi
		add_path() {
			local path=$1
			if ! grep -q "$(basename "$path")" <<< "$sessions"; then
				echo "$path"
			fi
		}
		export -f add_path
		printf "%s\n" "${paths//,/$IFS}" | xargs -n 1 -P 0 bash -c 'add_path "$@"' _
	fi
}

handle_output() {
	set -- "$(strip_git_branch_info "$*")"
	if [ -d "$*" ]; then
		# No special handling because there isn't a window number or window name present
		# except in unlikely and contrived situations (e.g.
		# "/home/person/projects:0\ bash" could be a path on your filesystem.)
		target=$(echo "$@" | tr -d '\n')
	elif is_fzf-marks_mark "$@" ; then
		# Needs to run before session name mode
		mark=$(get_fzf-marks_mark "$@")
		target=$(get_fzf-marks_target "$@")
	elif echo "$@" | grep ':' >/dev/null 2>&1; then
		# Colon probably delimits session name and window number
		session_name=$(echo "$@" | cut -d: -f1)
		num=$(echo "$@" | cut -d: -f2 | cut -d' ' -f1)
		target=$(echo "${session_name}:${num}" | tr -d '\n')
	else
		# All tokens represent a session name
		target=$(echo "$@" | tr -d '\n')
	fi

	if [[ -z "$target" ]]; then
		exit 0
	fi

	if ! tmux has-session -t="$target" 2>/dev/null; then
		if is_tmuxinator_enabled && is_tmuxinator_template "$target"; then
			tmuxinator start "$target"
		elif test -n "$mark"; then
			tmux new-session -ds "$mark" -c "$target"
			target="$mark"
		elif test -d "$target"; then
			d_target="$(basename "$target" | tr -d '.')"
			tmux new-session -ds $d_target -c "$target"
			target=$d_target
		else
			if [[ "$Z_MODE" == "on" ]]; then
				z_target=$(zoxide query "$target")
				tmux new-session -ds "$target" -c "$z_target" -n "$z_target"
			else
				tmux new-session -ds "$target"
			fi
		fi
	fi
	tmux switch-client -t "$target"

	exit 0
}

handle_input() {
	INPUT=$(input)
	ADDITIONAL_INPUT=$(additional_input)
	if [[ -n $ADDITIONAL_INPUT ]]; then
		INPUT="$(additional_input)\n$INPUT"
	fi
	bind_back=$(tmux show-option -gqv @sessionx-_bind-back)
	git_branch_mode=$(tmux show-option -gqv @sessionx-_git-branch)
	if [[ "$git_branch_mode" == "on" ]]; then
		BACK="$bind_back:reload(${CURRENT_DIR}/sessions_with_branches.sh)+change-preview(${CURRENT_DIR}/preview.sh {1})"
	else
		BACK="$bind_back:reload(echo -e \"${INPUT// /}\")+change-preview(${CURRENT_DIR}/preview.sh {1})"
	fi
}

run_plugin() {
	Z_MODE=$(tmux_option_or_fallback "@sessionx-zoxide-mode" "off")
	eval $(tmux show-option -gqv @sessionx-_built-args)
	eval $(tmux show-option -gqv @sessionx-_built-fzf-opts)
	handle_input
	args+=(--bind "$BACK")

	git_branch_mode=$(tmux show-option -gqv @sessionx-_git-branch)
	if [[ "$git_branch_mode" == "on" ]]; then
		FZF_LISTEN_PORT=$((RANDOM % 10000 + 20000))
		args+=(--listen "localhost:$FZF_LISTEN_PORT")
		args+=(--tiebreak=begin)
		"${CURRENT_DIR}/sessions_with_branches.sh" "$FZF_LISTEN_PORT" &
	fi

	FZF_BUILTIN_TMUX=$(tmux show-option -gqv @sessionx-_fzf-builtin-tmux)
	if [[ "$FZF_BUILTIN_TMUX" == "on" ]]; then
		RESULT=$(echo -e "${INPUT}" | sed -E 's/✗/ /g' | fzf "${fzf_opts[@]}" "${args[@]}" | tail -n1)
	else
		RESULT=$(echo -e "${INPUT}" | sed -E 's/✗/ /g' | fzf-tmux "${fzf_opts[@]}" "${args[@]}" | tail -n1)
	fi
}

run_plugin
handle_output "$RESULT"
```

### ~/.tmux/plugins/tmux-sessionx/sessionx.tmux

```sh
#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$CURRENT_DIR/scripts"
CURRENT="$(tmux display-message -p '#S')"

source "$SCRIPTS_DIR/tmuxinator.sh"
source "$SCRIPTS_DIR/fzf-marks.sh"

tmux_option_or_fallback() {
	local option_value
	option_value="$(tmux show-option -gqv "$1")"
	if [ -z "$option_value" ]; then
		option_value="$2"
	fi
	echo "$option_value"
}

preview_settings() {
	default_window_mode=$(tmux_option_or_fallback "@sessionx-window-mode" "off")
	if [[ "$default_window_mode" == "on" ]]; then
		PREVIEW_OPTIONS="-w"
	fi
	default_window_mode=$(tmux_option_or_fallback "@sessionx-tree-mode" "off")
	if [[ "$default_window_mode" == "on" ]]; then
		PREVIEW_OPTIONS="-t"
	fi
	preview_location=$(tmux_option_or_fallback "@sessionx-preview-location" "top")
	preview_ratio=$(tmux_option_or_fallback "@sessionx-preview-ratio" "75%")
	preview_enabled=$(tmux_option_or_fallback "@sessionx-preview-enabled" "true")
}

window_settings() {
	window_height=$(tmux_option_or_fallback "@sessionx-window-height" "75%")
	window_width=$(tmux_option_or_fallback "@sessionx-window-width" "75%")
	layout_mode=$(tmux_option_or_fallback "@sessionx-layout" "default")
	prompt_icon=$(tmux_option_or_fallback "@sessionx-prompt" " ")
	pointer_icon=$(tmux_option_or_fallback "@sessionx-pointer" "▶")
}

handle_binds() {
	bind_tree_mode=$(tmux_option_or_fallback "@sessionx-bind-tree-mode" "ctrl-t")
	bind_window_mode=$(tmux_option_or_fallback "@sessionx-bind-window-mode" "ctrl-w")
	bind_configuration_mode=$(tmux_option_or_fallback "@sessionx-bind-configuration-path" "ctrl-x")
	bind_rename_session=$(tmux_option_or_fallback "@sessionx-bind-rename-session" "ctrl-r")
	additional_fzf_options=$(tmux_option_or_fallback "@sessionx-additional-options" "--color pointer:9,spinner:92,marker:46")

	bind_back=$(tmux_option_or_fallback "@sessionx-bind-back" "ctrl-b")
	bind_new_window=$(tmux_option_or_fallback "@sessionx-bind-new-window" "ctrl-e")
	bind_zo=$(tmux_option_or_fallback "@sessionx-bind-zo-new-window" "ctrl-f")
	bind_kill_session=$(tmux_option_or_fallback "@sessionx-bind-kill-session" "alt-bspace")

	bind_exit=$(tmux_option_or_fallback "@sessionx-bind-abort" "esc")
	bind_accept=$(tmux_option_or_fallback "@sessionx-bind-accept" "enter")
	bind_delete_char=$(tmux_option_or_fallback "@sessionx-bind-delete-char" "bspace")

	bind_scroll_up=$(tmux_option_or_fallback "@sessionx-bind-scroll-up" "ctrl-u")
	bind_scroll_down=$(tmux_option_or_fallback "@sessionx-bind-scroll-down" "ctrl-d")

	bind_select_up=$(tmux_option_or_fallback "@sessionx-bind-select-up" "ctrl-p")
	bind_select_down=$(tmux_option_or_fallback "@sessionx-bind-select-down" "ctrl-n")

}

handle_args() {
	LS_COMMAND=$(tmux_option_or_fallback "@sessionx-ls-command" "ls")
	if [[ "$preview_enabled" == "true" ]]; then
		PREVIEW_LINE="${SCRIPTS_DIR%/}/preview.sh ${PREVIEW_OPTIONS} {}"
	fi
	CONFIGURATION_PATH=$(tmux_option_or_fallback "@sessionx-x-path" "$HOME/.config")
	FZF_BUILTIN_TMUX=$(tmux_option_or_fallback "@sessionx-fzf-builtin-tmux" "off")

	TREE_MODE="$bind_tree_mode:change-preview(${SCRIPTS_DIR%/}/preview.sh -t {1})"
	CONFIGURATION_MODE="$bind_configuration_mode:reload(find -L $CONFIGURATION_PATH -mindepth 1 -maxdepth 1 -type d -o -type l)+change-preview($LS_COMMAND {})"
	WINDOWS_MODE="$bind_window_mode:reload(tmux list-windows -a -F '#{session_name}:#{window_name}')+change-preview(${SCRIPTS_DIR%/}/preview.sh -w {1})"

	NEW_WINDOW="$bind_new_window:reload(find -L $PWD -mindepth 1 -maxdepth 1 -type d -o -type l)+change-preview($LS_COMMAND {})"
	ZO_WINDOW="$bind_zo:reload(zoxide query -l)+change-preview($LS_COMMAND {})"
	KILL_SESSION="$bind_kill_session:execute-silent(tmux kill-session -t {1})+reload(${SCRIPTS_DIR%/}/reload_sessions.sh)"

	ACCEPT="$bind_accept:replace-query+print-query"
	DELETE="$bind_delete_char:backward-delete-char"
	EXIT="$bind_exit:abort"

	SELECT_UP="$bind_select_up:up"
	SELECT_DOWN="$bind_select_down:down"
	SCROLL_UP="$bind_scroll_up:preview-half-page-up"
	SCROLL_DOWN="$bind_scroll_down:preview-half-page-down"

	RENAME_SESSION_EXEC='bash -c '\'' printf >&2 "New name: ";read name; tmux rename-session -t {1} "${name}"; '\'''
	RENAME_SESSION_RELOAD='bash -c '\'' tmux list-sessions | sed -E "s/:.*$//"; '\'''
	RENAME_SESSION="$bind_rename_session:execute($RENAME_SESSION_EXEC)+reload($RENAME_SESSION_RELOAD)"

	HEADER="$bind_accept=󰿄  $bind_kill_session=󱂧  $bind_rename_session=󰑕  $bind_configuration_mode=󱃖  $bind_window_mode=   $bind_new_window=󰇘  $bind_back=󰌍  $bind_tree_mode=󰐆   $bind_scroll_up=  $bind_scroll_down= / $bind_zo="
	if is_fzf-marks_enabled; then
		HEADER="$HEADER  $(get_fzf-marks_keybind)=󰣉"
	fi

	if [[ "$FZF_BUILTIN_TMUX" == "on" ]]; then
		fzf_size_arg="--tmux"
	else
		fzf_size_arg="-p"
	fi

	args=(
		--ansi
		--bind "$TREE_MODE"
		--bind "$CONFIGURATION_MODE"
		--bind "$WINDOWS_MODE"
		--bind "$NEW_WINDOW"
		--bind "$ZO_WINDOW"
		--bind "$KILL_SESSION"
		--bind "$DELETE"
		--bind "$EXIT"
		--bind "$SELECT_UP"
		--bind "$SELECT_DOWN"
		--bind "$ACCEPT"
		--bind "$SCROLL_UP"
		--bind "$SCROLL_DOWN"
		--bind "$RENAME_SESSION"
		--bind '?:toggle-preview'
		--bind 'change:first'
		--exit-0
		--header="$HEADER"
		--preview="${PREVIEW_LINE}"
		--preview-window="${preview_location},${preview_ratio},,"
		--layout="$layout_mode"
		--pointer="$pointer_icon"
		"${fzf_size_arg}" "$window_width,$window_height"
		--prompt "$prompt_icon"
		--print-query
		--tac
		--scrollbar '▌▐'
	)

	legacy=$(tmux_option_or_fallback "@sessionx-legacy-fzf-support" "off")
	if [[ "${legacy}" == "off" ]]; then
		args+=(--border-label "Current session: \"$CURRENT\" ")
		args+=(--bind 'focus:transform-preview-label:echo [ {} ] | sed "s/\x1b\[[0-9;]*m//g"')
	fi
	auto_accept=$(tmux_option_or_fallback "@sessionx-auto-accept" "off")
	if [[ "${auto_accept}" == "on" ]]; then
		args+=(--bind one:accept)
	fi

	if $(is_tmuxinator_enabled); then
		args+=(--bind "$(load_tmuxinator_binding)")
	fi
	if $(is_fzf-marks_enabled); then
		args+=(--bind "$(load_fzf-marks_binding)")
	fi

	eval "fzf_opts=($additional_fzf_options)"
}

handle_extra_options() {
	# Store each option individually to avoid bash 3.2 associative array issues on macOS
	tmux set-option -g @sessionx-_bind-back "$bind_back"
	tmux set-option -g @sessionx-_filtered-sessions "$(tmux_option_or_fallback "@sessionx-filtered-sessions" "")"
	tmux set-option -g @sessionx-_window-mode "$(tmux_option_or_fallback "@sessionx-window-mode" "off")"
	tmux set-option -g @sessionx-_filter-current "$(tmux_option_or_fallback "@sessionx-filter-current" "true")"
	tmux set-option -g @sessionx-_custom-paths "$(tmux_option_or_fallback "@sessionx-custom-paths" "")"
	tmux set-option -g @sessionx-_custom-paths-subdirectories "$(tmux_option_or_fallback "@sessionx-custom-paths-subdirectories" "false")"
	tmux set-option -g @sessionx-_git-branch "$(tmux_option_or_fallback "@sessionx-git-branch" "off")"
	tmux set-option -g @sessionx-_fzf-builtin-tmux "$FZF_BUILTIN_TMUX"
}

preview_settings
window_settings
handle_binds
handle_args
handle_extra_options

tmux set-option -g @sessionx-_built-args "$(declare -p args)"
tmux set-option -g @sessionx-_built-fzf-opts "$(declare -p fzf_opts)"

if [ `tmux_option_or_fallback "@sessionx-prefix" "on"` = "on"  ]; then
	tmux bind-key "$(tmux_option_or_fallback "@sessionx-bind" "O")" run-shell "$CURRENT_DIR/scripts/sessionx.sh"
else
	tmux bind-key -n "$(tmux_option_or_fallback "@sessionx-bind" "O")" run-shell "$CURRENT_DIR/scripts/sessionx.sh"
fi
```

### ~/.tmux/plugins/vim-tmux-navigator/vim-tmux-navigator.tmux

```sh
#!/usr/bin/env bash

get_tmux_option() {
  local option value default
  option="$1"
  default="$2"
  # NOTE: Older tmux versions (eg. 3.2a on Ubuntu 22.04) do not exit with an
  #       error code when an option is not defined. Therefore we need to first
  #       test if the option exists, and only then try to get its value or fall
  #       back to the default.
  value="$([[ -n $(tmux show-options -gq "$option") ]] \
      && tmux show-option -gqv "$option" \
      || echo "$default")"

  # Deprecated, for backward compatibility
  if [[ $value == 'null' ]]; then
      echo ""
      return
  fi

  echo "$value"
}

# Export 'vim_pattern' so that it can be tested in pattern-check
declare vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'

bind_key_vim() {
  local key tmux_cmd is_vim tmux_navigator_disable_when_zoomed
  key="$1"
  tmux_cmd="$2"

  vim_pattern="$(get_tmux_option "@vim_navigator_pattern" "${vim_pattern}")"

  is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
      | grep -iqE '^[^TXZ ]+ +"@vim_navigator_pattern"$'"
  is_vim="$(get_tmux_option "@vim_navigator_check" "${is_vim}")"
  is_vim="${is_vim//@vim_navigator_pattern/${vim_pattern}}"

  tmux_navigator_disable_when_zoomed="$(get_tmux_option "@tmux_navigator_disable_when_zoomed" "0")"
  if [ "$tmux_navigator_disable_when_zoomed" = "1" ]; then
    tmux_cmd="if-shell -F '#{window_zoomed_flag}' '' '$tmux_cmd'"
  fi

  # sending C-/ according to https://github.com/tmux/tmux/issues/1827
  tmux bind-key -n "$key" if-shell "$is_vim" "send-keys '$key'" "$tmux_cmd"
  # tmux < 3.0 cannot parse "$tmux_cmd" as one argument, thus copying as multiple arguments
  tmux bind-key -T copy-mode-vi "$key" $tmux_cmd
}

main() {
  move_left="$(get_tmux_option "@vim_navigator_mapping_left" 'C-h')"
  move_right="$(get_tmux_option "@vim_navigator_mapping_right" 'C-l')"
  move_up="$(get_tmux_option "@vim_navigator_mapping_up" 'C-k')"
  move_down="$(get_tmux_option "@vim_navigator_mapping_down" 'C-j')"
  move_prev="$(get_tmux_option "@vim_navigator_mapping_prev" 'C-\')"

  for k in $(echo "$move_left");  do bind_key_vim "$k" "select-pane -L"; done
  for k in $(echo "$move_down");  do bind_key_vim "$k" "select-pane -D"; done
  for k in $(echo "$move_up");    do bind_key_vim "$k" "select-pane -U"; done
  for k in $(echo "$move_right"); do bind_key_vim "$k" "select-pane -R"; done
  for k in $(echo "$move_prev");  do bind_key_vim "$k" "select-pane -l"; done

  # Restoring clear screen
  clear_screen="$(get_tmux_option "@vim_navigator_prefix_mapping_clear_screen" 'C-l')"
  for k in $(echo "$clear_screen"); do tmux bind "$k" send-keys 'C-l'; done
}

if [ "$BASH_SOURCE" == "$0" ]; then
  main "$@"
fi
```

### ~/.tmux/plugins/tpm/tests/test_plugin_sourcing.sh

```sh
#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TPM_DIR="$PWD"
PLUGINS_DIR="$HOME/.tmux/plugins"

CUSTOM_PLUGINS_DIR="$HOME/foo/plugins"

source "$CURRENT_DIR/helpers/helpers.sh"
source "$CURRENT_DIR/helpers/tpm.sh"

check_binding_defined() {
	local binding="$1"
	tmux list-keys | grep -q "$binding"
}

create_test_plugin_helper() {
	local plugin_path="$PLUGINS_DIR/tmux_test_plugin/"
	rm -rf "$plugin_path"
	mkdir -p "$plugin_path"

	while read line; do
		echo "$line" >> "$plugin_path/test_plugin.tmux"
	done
	chmod +x "$plugin_path/test_plugin.tmux"
}

check_tpm_path() {
	local correct_tpm_path="$1"
	local tpm_path="$(tmux start-server\; show-environment -g TMUX_PLUGIN_MANAGER_PATH | cut -f2 -d=)"
	[ "$correct_tpm_path" == "$tpm_path" ]
}

test_plugin_sourcing() {
	set_tmux_conf_helper <<- HERE
	set -g mode-keys vi
	set -g @plugin "doesnt_matter/tmux_test_plugin"
	run-shell "$TPM_DIR/tpm"
	HERE

	# manually creates a local tmux plugin
	create_test_plugin_helper <<- HERE
	tmux bind-key R run-shell foo_command
	HERE

	tmux new-session -d  # tmux starts detached
	check_binding_defined "R run-shell foo_command" ||
		fail_helper "Plugin sourcing fails"

	teardown_helper
}

test_default_tpm_path() {
	set_tmux_conf_helper <<- HERE
	set -g mode-keys vi
	run-shell "$TPM_DIR/tpm"
	HERE

	check_tpm_path "${PLUGINS_DIR}/" ||
		fail_helper "Default TPM path not correct"

	teardown_helper
}

test_custom_tpm_path() {
	set_tmux_conf_helper <<- HERE
	set -g mode-keys vi
	set-environment -g TMUX_PLUGIN_MANAGER_PATH '$CUSTOM_PLUGINS_DIR'
	run-shell "$TPM_DIR/tpm"
	HERE

	check_tpm_path "$CUSTOM_PLUGINS_DIR" ||
		fail_helper "Custom TPM path not correct"

	teardown_helper
}

run_tests
```

### ~/.tmux/plugins/tpm/tpm

```sh
#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BINDINGS_DIR="$CURRENT_DIR/bindings"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

source "$SCRIPTS_DIR/variables.sh"

get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value="$(tmux show-option -gqv "$option")"
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

tpm_path_set() {
	tmux show-environment -g "$DEFAULT_TPM_ENV_VAR_NAME" >/dev/null 2>&1
}

# Check if configuration file exists at an XDG-compatible location, if so use
# that directory for TMUX_PLUGIN_MANAGER_PATH. Otherwise use $DEFAULT_TPM_PATH.
set_default_tpm_path() {
	local xdg_tmux_path="${XDG_CONFIG_HOME:-$HOME/.config}/tmux"
	local tpm_path="$DEFAULT_TPM_PATH"

	if [ -f "$xdg_tmux_path/tmux.conf" ]; then
		tpm_path="$xdg_tmux_path/plugins/"
	fi

	tmux set-environment -g "$DEFAULT_TPM_ENV_VAR_NAME" "$tpm_path"
}

# Ensures TMUX_PLUGIN_MANAGER_PATH global env variable is set.
#
# Put this in `.tmux.conf` to override the default:
# `set-environment -g TMUX_PLUGIN_MANAGER_PATH "/some/other/path/"`
set_tpm_path() {
	if ! tpm_path_set; then
		set_default_tpm_path
	fi
}

# 1. Fetches plugin names from `@plugin` variables
# 2. Creates full plugin path
# 3. Sources all *.tmux files from each of the plugin directories
#	 - no errors raised if directory does not exist
# Files are sourced as tmux config files, not as shell scripts!
source_plugins() {
	"$SCRIPTS_DIR/source_plugins.sh" >/dev/null 2>&1
}

# prefix + I - downloads TPM plugins and reloads TMUX environment
# prefix + U - updates a plugin (or all of them) and reloads TMUX environment
# prefix + alt + u - remove unused TPM plugins and reloads TMUX environment
set_tpm_key_bindings() {
	local install_key="$(get_tmux_option "$install_key_option" "$default_install_key")"
	tmux bind-key "$install_key" run-shell "$BINDINGS_DIR/install_plugins"

	local update_key="$(get_tmux_option "$update_key_option" "$default_update_key")"
	tmux bind-key "$update_key" run-shell "$BINDINGS_DIR/update_plugins"

	local clean_key="$(get_tmux_option "$clean_key_option" "$default_clean_key")"
	tmux bind-key "$clean_key" run-shell "$BINDINGS_DIR/clean_plugins"
}

supported_tmux_version_ok() {
	"$SCRIPTS_DIR/check_tmux_version.sh" "$SUPPORTED_TMUX_VERSION"
}

main() {
	if supported_tmux_version_ok; then
		set_tpm_path
		set_tpm_key_bindings
		source_plugins
	fi
}
main
```

### ~/.tmux/plugins/tmux-sensible/sensible.tmux

```sh
#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# used to match output from `tmux list-keys`
KEY_BINDING_REGEX="bind-key[[:space:]]\+\(-r[[:space:]]\+\)\?\(-T prefix[[:space:]]\+\)\?"

is_osx() {
	local platform=$(uname)
	[ "$platform" == "Darwin" ]
}

iterm_terminal() {
	[[ "${TERM_PROGRAM}" =~ ^iTerm || "${LC_TERMINAL}" =~ ^iTerm ]]
}

command_exists() {
	local command="$1"
	type "$command" >/dev/null 2>&1
}

# returns prefix key, e.g. 'C-a'
prefix() {
	tmux show-option -gv prefix
}

# if prefix is 'C-a', this function returns 'a'
prefix_without_ctrl() {
	local prefix="$(prefix)"
	echo "$prefix" | cut -d '-' -f2
}

option_value_not_changed() {
	local option="$1"
	local default_value="$2"
	local option_value=$(tmux show-option -gv "$option")
	[ "$option_value" == "$default_value" ]
}

server_option_value_not_changed() {
	local option="$1"
	local default_value="$2"
	local option_value=$(tmux show-option -sv "$option")
	[ "$option_value" == "$default_value" ]
}

key_binding_not_set() {
	local key="${1//\\/\\\\}"
	if $(tmux list-keys | grep -q "${KEY_BINDING_REGEX}${key}[[:space:]]"); then
		return 1
	else
		return 0
	fi
}

key_binding_not_changed() {
	local key="$1"
	local default_value="$2"
	if $(tmux list-keys | grep -q "${KEY_BINDING_REGEX}${key}[[:space:]]\+${default_value}"); then
		# key still has the default binding
		return 0
	else
		return 1
	fi
}

get_tmux_config() {
	local tmux_config_xdg="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
	local tmux_config="$HOME/.tmux.conf"

	if [ -f "${tmux_config_xdg}" ]; then
		echo "${tmux_config_xdg}"
	else
		echo ${tmux_config}
	fi
}

main() {
	# OPTIONS

	# address vim mode switching delay (http://superuser.com/a/252717/65504)
	if server_option_value_not_changed "escape-time" "500"; then
		tmux set-option -s escape-time 0
	fi

	# increase scrollback buffer size
	if option_value_not_changed "history-limit" "2000"; then
		tmux set-option -g history-limit 50000
	fi

	# tmux messages are displayed for 4 seconds
	if option_value_not_changed "display-time" "750"; then
		tmux set-option -g display-time 4000
	fi

	# refresh 'status-left' and 'status-right' more often
	if option_value_not_changed "status-interval" "15"; then
		tmux set-option -g status-interval 5
	fi

	# required (only) on OS X
	if is_osx && command_exists "reattach-to-user-namespace" && option_value_not_changed "default-command" ""; then
		tmux set-option -g default-command "reattach-to-user-namespace -l $SHELL"
	fi

	# upgrade $TERM, tmux 1.9
	if option_value_not_changed "default-terminal" "screen"; then
		tmux set-option -g default-terminal "screen-256color"
	fi
	# upgrade $TERM, tmux 2.0+
	if server_option_value_not_changed "default-terminal" "screen"; then
		tmux set-option -s default-terminal "screen-256color"
	fi

	# emacs key bindings in tmux command prompt (prefix + :) are better than
	# vi keys, even for vim users
	tmux set-option -g status-keys emacs

	# focus events enabled for terminals that support them
	tmux set-option -g focus-events on

	# super useful when using "grouped sessions" and multi-monitor setup
	if ! iterm_terminal; then
		tmux set-window-option -g aggressive-resize on
	fi

	# DEFAULT KEY BINDINGS

	local prefix="$(prefix)"
	local prefix_without_ctrl="$(prefix_without_ctrl)"

	# if C-b is not prefix
	if [ $prefix != "C-b" ]; then
		# unbind obsolete default binding
		if key_binding_not_changed "C-b" "send-prefix"; then
			tmux unbind-key C-b
		fi

		# pressing `prefix + prefix` sends <prefix> to the shell
		if key_binding_not_set "$prefix"; then
			tmux bind-key "$prefix" send-prefix
		fi
	fi

	# If Ctrl-a is prefix then `Ctrl-a + a` switches between alternate windows.
	# Works for any prefix character.
	if key_binding_not_set "$prefix_without_ctrl"; then
		tmux bind-key "$prefix_without_ctrl" last-window
	fi

	# easier switching between next/prev window
	if key_binding_not_set "C-p"; then
		tmux bind-key C-p previous-window
	fi
	if key_binding_not_set "C-n"; then
		tmux bind-key C-n next-window
	fi

	# source `.tmux.conf` file - as suggested in `man tmux`
	if key_binding_not_set "R"; then
		local tmux_config=$(get_tmux_config)

		tmux bind-key R run-shell " \
			tmux source-file ${tmux_config} > /dev/null; \
			tmux display-message 'Sourced ${tmux_config}!'"
	fi
}
main
```

## Kitty

No active personal `map` or `mouse_map` directives were found in the loaded Kitty config chain. The terminal inherits installed Linux defaults below. `kitty_mod` is Ctrl+Shift unless overridden. `>` in a key specification introduces a multi-key sequence. The tab bar is hidden in the personal config, but keyboard tab actions still apply. Some defaults have version-specific fallback flags preserved here.

### ~/.config/kitty/kitty.conf

```conf
include hyde.conf
# ^ HyDE base: font (CaskaydiaCove Nerd Font Mono), padding, font_size, theme.conf.
#   Anything below OVERRIDES hyde.conf, because later settings win in kitty.

# ─── Appearance: the soft frosted look from the screenshot ─────────────────────
# IMPORTANT: Hyprland ALREADY sets kitty opacity to 0.80 via a windowrule in
# ~/.config/hypr/windowrules.conf, and Hyprland blur is enabled. Compositor blur
# is what gives the frosted look (kitty alone can't blur). These two opacities
# MULTIPLY, so we keep kitty fully opaque (1.0) and let Hyprland own transparency.
# To make the terminal MORE/LESS see-through, edit the 0.80 in windowrules.conf.
background_opacity           1.0
# dynamic_background_opacity lets you live-adjust opacity with ctrl+shift+a then +/-
dynamic_background_opacity   yes

# A touch more breathing room than HyDE's default 25 looks closer to the screenshot.
window_padding_width         18

# ─── Font ─────────────────────────────────────────────────────────────────────
# HyDE sets CaskaydiaCove already. JetBrainsMono Nerd Font (also installed) is the
# closest match to the screenshot's glyph shapes — uncomment to switch.
# font_family                  JetBrainsMono Nerd Font
# font_size                    11.0

# Slightly looser line height reads cleaner at small sizes (optional).
# modify_font                  cell_height 110%

# ─── Catppuccin Mocha palette (mirrors ~/.tmux Catppuccin so kitty == tmux) ────
# These are the exact hex values from catppuccin_mocha_tmux.conf. hyde.conf's
# theme.conf normally provides colors; we restate Mocha here so the tab pills
# below (which derive from these) match tmux even if HyDE's flavor drifts.
# Comment this whole block out to hand color back to HyDE's theme.conf.
# [themeforge] foreground                   #cdd6f4
# [themeforge] background                   #1e1e2e
# [themeforge] selection_foreground         #1e1e2e
# [themeforge] selection_background         #f5e0dc
# [themeforge] cursor                       #f5e0dc
# [themeforge] cursor_text_color            #1e1e2e
# [themeforge] url_color                    #f5e0dc
# black
# [themeforge] color0  #45475a
# [themeforge] color8  #585b70
# red
# [themeforge] color1  #f38ba8
# [themeforge] color9  #f38ba8
# green
# [themeforge] color2  #a6e3a1
# [themeforge] color10 #a6e3a1
# yellow
# [themeforge] color3  #f9e2af
# [themeforge] color11 #f9e2af
# blue
# [themeforge] color4  #89b4fa
# [themeforge] color12 #89b4fa
# magenta
# [themeforge] color5  #f5c2e7
# [themeforge] color13 #f5c2e7
# cyan
# [themeforge] color6  #94e2d5
# [themeforge] color14 #94e2d5
# white
# [themeforge] color7  #bac2de
# [themeforge] color15 #a6adc8

# ─── Tab bar: themed to MATCH tmux's Catppuccin pills, but kept OFF for now ────
# You run tmux inside kitty, and tmux's Catppuccin bar provides the window tabs
# (worktrunk / tmux / nu in the screenshot). Two tab bars stacked looks bad, so
# kitty's stays hidden while tmux owns the tabs.
#
# Everything below is a ready-to-use, exact-match config. To turn kitty's OWN
# Catppuccin tab bar ON later, flip the line below:
#     tab_bar_style hidden   ->   tab_bar_style separator
# `separator` makes kitty render the custom *_tab_title_template pills defined
# below — rounded mauve current pill, surface-gray inactive, number on the LEFT.
tab_bar_style                hidden

# --- Pill geometry (rounded edges like tmux @catppuccin_window_status_style "rounded") ---
tab_bar_edge                 top
tab_bar_align                left
tab_bar_min_tabs             1
# transparent bar — matches @catppuccin_status_background "default" (Hyprland blur shows through)
tab_bar_background           none
# rounded pill end-caps: the U+E0B6/U+E0B4 half-circle powerline glyphs (Nerd Font)
tab_separator                ""
tab_bar_margin_width         6.0
tab_bar_margin_height        4.0 0.0

# --- Tab title: NUMBER ON THE LEFT (you asked for left, tmux had it on the right) ---
# {index} first = number on the left of each pill, then the title.
tab_title_template           "{fmt.fg._1e1e2e}{fmt.bg._cba6f7} {index} {fmt.bg._313244}{fmt.fg._cdd6f4} {title} "
# Active tab: mauve pill (#cba6f7) like @catppuccin_window_current_number_color "#{@thm_mauve}"
active_tab_title_template    "{fmt.fg._cba6f7}{fmt.fg._1e1e2e}{fmt.bg._cba6f7} {index} {title} {fmt.bg.default}{fmt.fg._cba6f7}"
# Inactive tab: surface-gray pill (#313244 / #585b70 fg)
active_tab_foreground        #1e1e2e
active_tab_background        #cba6f7
active_tab_font_style        bold
inactive_tab_foreground      #cdd6f4
inactive_tab_background      #313244
inactive_tab_font_style      normal
tab_activity_symbol          " ●"

# ─── Cursor ───────────────────────────────────────────────────────────────────
cursor_shape                 block
# steady cursor, like the screenshot
cursor_blink_interval        0
# subtle motion trail (HyDE already enables)
cursor_trail                 1

# ─── Bell ─────────────────────────────────────────────────────────────────────
enable_audio_bell            no
window_alert_on_bell         no

# ─── Scrollback & misc ────────────────────────────────────────────────────────
scrollback_lines             10000
# don't nag when closing
confirm_os_window_close      0
# remap to open new kitty tab in the same directory (default is home dir)
# map ctrl+shift+t            new_tab_with_cwd

# ─── Latency (uncomment for snappier feel, slightly higher GPU use) ───────────
# input_delay 0
# repaint_delay 2
# sync_to_monitor no
# wayland_enable_ime no
```

### ~/.config/kitty/hyde.conf

```conf
# This is the configuration file for kitty terminal
# For more information, see https://sw.kovidgoyal.net/kitty/conf.html
# For your custom configurations, put it in ./kitty.conf
font_family CaskaydiaCove Nerd Font Mono
bold_font auto
italic_font auto
bold_italic_font auto
enable_audio_bell no
font_size 9.0
window_padding_width 25
cursor_trail 1

# Themes can override any settings in this file
include theme.conf
#background_opacity 0.60
#hide_window_decorations yes
#confirm_os_window_close 0
```

| Kind | Description | Exact default binding and action |
|---|---|---|

| mouse | Click the link under the mouse or move the cursor | click_url_or_select left click ungrabbed mouse_handle_click selection link prompt |

| mouse | Click the link under the mouse or move the cursor even when grabbed | click_url_or_select_grabbed shift+left click grabbed,ungrabbed mouse_handle_click selection link prompt |

| mouse | Click the link under the mouse cursor | click_url ctrl+shift+left release grabbed,ungrabbed mouse_handle_click link |

| mouse | Discard press event for link click | click_url_discard ctrl+shift+left press grabbed discard_event |

| mouse | Paste from the primary selection | paste_selection middle release ungrabbed paste_from_selection |

| mouse | Start selecting text | start_simple_selection left press ungrabbed mouse_selection normal |

| mouse | Start selecting text in a rectangle | start_rectangle_selection ctrl+alt+left press ungrabbed mouse_selection rectangle |

| mouse | Select a word | select_word left doublepress ungrabbed mouse_selection word |

| mouse | Select a line | select_line left triplepress ungrabbed mouse_selection line |

| mouse | Select line from first cell | select_line_from_begin alt+left triplepress ungrabbed mouse_selection line_from_begin |

| mouse | Select line from point | select_line_from_point ctrl+alt+left triplepress ungrabbed mouse_selection line_from_point |

| mouse | Extend the current selection | extend_selection right press ungrabbed mouse_selection extend |

| mouse | Extend the current selection with shift | extend_selection_shift shift+left press ungrabbed mouse_selection extend |

| mouse | Paste from the primary selection even when grabbed | paste_selection_grabbed shift+middle release ungrabbed,grabbed paste_selection |

| mouse | Discard press event for middle click paste | paste_selection_grabbed shift+middle press grabbed discard_event |

| mouse | Start selecting text even when grabbed | start_simple_selection_grabbed shift+left press grabbed mouse_selection normal |

| mouse | Start selecting text in a rectangle even when grabbed | start_rectangle_selection_grabbed ctrl+shift+alt+left press ungrabbed,grabbed mouse_selection rectangle |

| mouse | Select a word even when grabbed | select_word_grabbed shift+left doublepress ungrabbed,grabbed mouse_selection word |

| mouse | Select a line even when grabbed | select_line_grabbed shift+left triplepress ungrabbed,grabbed mouse_selection line |

| mouse | Select line from first cell even when grabbed | select_line_from_begin_grabbed shift+alt+left triplepress ungrabbed,grabbed mouse_selection line_from_begin |

| mouse | Select line from point even when grabbed | select_line_from_point_grabbed ctrl+shift+alt+left triplepress ungrabbed,grabbed mouse_selection line_from_point |

| mouse | Extend the current selection even when grabbed | extend_selection_grabbed shift+right press ungrabbed,grabbed mouse_selection extend |

| mouse | Show clicked command output in pager | show_clicked_cmd_output_ungrabbed ctrl+shift+right press ungrabbed mouse_show_command_output |

| key | Copy to clipboard | copy_to_clipboard --allow-fallback=shifted,ascii kitty_mod+c copy_to_clipboard |

| key | Paste from clipboard | paste_from_clipboard --allow-fallback=shifted,ascii kitty_mod+v paste_from_clipboard |

| key | Paste from selection | paste_from_selection --allow-fallback=shifted,ascii kitty_mod+s paste_from_selection |

| key | Paste from selection | paste_from_selection shift+insert paste_from_selection |

| key | Pass selection to program | pass_selection_to_program --allow-fallback=shifted,ascii kitty_mod+o pass_selection_to_program |

| key | Scroll line up | scroll_line_up kitty_mod+up scroll_line_up smooth |

| key | Scroll line up | scroll_line_up --allow-fallback=shifted,ascii kitty_mod+k scroll_line_up smooth |

| key | Scroll line down | scroll_line_down kitty_mod+down scroll_line_down smooth |

| key | Scroll line down | scroll_line_down --allow-fallback=shifted,ascii kitty_mod+j scroll_line_down smooth |

| key | Scroll page up | scroll_page_up kitty_mod+page_up scroll_page_up |

| key | Scroll page down | scroll_page_down kitty_mod+page_down scroll_page_down |

| key | Scroll to top | scroll_home kitty_mod+home scroll_home |

| key | Scroll to bottom | scroll_end kitty_mod+end scroll_end |

| key | Scroll to previous shell prompt | scroll_to_previous_prompt --allow-fallback=shifted,ascii kitty_mod+z scroll_to_prompt -1 |

| key | Scroll to next shell prompt | scroll_to_next_prompt --allow-fallback=shifted,ascii kitty_mod+x scroll_to_prompt 1 |

| key | Browse scrollback buffer in pager | show_scrollback --allow-fallback=shifted,ascii kitty_mod+h show_scrollback |

| key | Browse output of the last shell command in pager | show_last_command_output --allow-fallback=shifted,ascii kitty_mod+g show_last_command_output |

| key | Search the scrollback within a pager | search_scrollback kitty_mod+/ search_scrollback |

| key | New window | new_window kitty_mod+enter new_window |

| key | New OS window | new_os_window --allow-fallback=shifted,ascii kitty_mod+n new_os_window |

| key | Close window | close_window --allow-fallback=shifted,ascii kitty_mod+w close_window |

| key | Next window | next_window kitty_mod+] next_window |

| key | Previous window | previous_window kitty_mod+[ previous_window |

| key | Move window forward | move_window_forward --allow-fallback=shifted,ascii kitty_mod+f move_window_forward |

| key | Move window backward | move_window_backward --allow-fallback=shifted,ascii kitty_mod+b move_window_backward |

| key | Move window to top | move_window_to_top kitty_mod+&#96; move_window_to_top |

| key | Start resizing window | start_resizing_window --allow-fallback=shifted,ascii kitty_mod+r start_resizing_window |

| key | First window | first_window kitty_mod+1 first_window |

| key | Second window | second_window kitty_mod+2 second_window |

| key | Third window | third_window kitty_mod+3 third_window |

| key | Fourth window | fourth_window kitty_mod+4 fourth_window |

| key | Fifth window | fifth_window kitty_mod+5 fifth_window |

| key | Sixth window | sixth_window kitty_mod+6 sixth_window |

| key | Seventh window | seventh_window kitty_mod+7 seventh_window |

| key | Eighth window | eighth_window kitty_mod+8 eighth_window |

| key | Ninth window | ninth_window kitty_mod+9 ninth_window |

| key | Tenth window | tenth_window kitty_mod+0 tenth_window |

| key | Visually select and focus window | focus_visible_window kitty_mod+f7 focus_visible_window |

| key | Visually swap window with another | swap_with_window kitty_mod+f8 swap_with_window |

| key | Next tab | next_tab kitty_mod+right next_tab |

| key | Next tab | next_tab ctrl+tab next_tab |

| key | Previous tab | previous_tab kitty_mod+left previous_tab |

| key | Previous tab | previous_tab ctrl+shift+tab previous_tab |

| key | New tab | new_tab --allow-fallback=shifted,ascii kitty_mod+t new_tab |

| key | Close tab | close_tab --allow-fallback=shifted,ascii kitty_mod+q close_tab |

| key | Move tab forward | move_tab_forward kitty_mod+. move_tab_forward |

| key | Move tab backward | move_tab_backward kitty_mod+, move_tab_backward |

| key | Set tab title | set_tab_title --allow-fallback=shifted,ascii kitty_mod+alt+t set_tab_title |

| key | Next layout | next_layout --allow-fallback=shifted,ascii kitty_mod+l next_layout |

| key | Increase font size | increase_font_size kitty_mod+equal change_font_size all +2.0 |

| key | Increase font size | increase_font_size kitty_mod+plus change_font_size all +2.0 |

| key | Increase font size | increase_font_size kitty_mod+kp_add change_font_size all +2.0 |

| key | Decrease font size | decrease_font_size kitty_mod+minus change_font_size all -2.0 |

| key | Decrease font size | decrease_font_size kitty_mod+kp_subtract change_font_size all -2.0 |

| key | Reset font size | reset_font_size kitty_mod+backspace change_font_size all 0 |

| key | Open URL | open_url --allow-fallback=shifted,ascii kitty_mod+e open_url_with_hints |

| key | Insert selected path | insert_selected_path --allow-fallback=shifted,ascii kitty_mod+p>f kitten hints --type path --program - |

| key | Open selected path | open_selected_path --allow-fallback=shifted,ascii kitty_mod+p>shift+f kitten hints --type path |

| key | Insert chosen file | insert_chosen_file --allow-fallback=shifted,ascii kitty_mod+p>c kitten choose-files |

| key | Insert chosen directory | insert_chosen_directory --allow-fallback=shifted,ascii kitty_mod+p>d kitten choose-files --mode=dir |

| key | Insert selected line | insert_selected_line --allow-fallback=shifted,ascii kitty_mod+p>l kitten hints --type line --program - |

| key | Insert selected word | insert_selected_word --allow-fallback=shifted,ascii kitty_mod+p>w kitten hints --type word --program - |

| key | Insert selected hash | insert_selected_hash --allow-fallback=shifted,ascii kitty_mod+p>h kitten hints --type hash --program - |

| key | Open the selected file at the selected line | goto_file_line --allow-fallback=shifted,ascii kitty_mod+p>n kitten hints --type linenum |

| key | Open the selected hyperlink | open_selected_hyperlink --allow-fallback=shifted,ascii kitty_mod+p>y kitten hints --type hyperlink |

| key | Show documentation | show_kitty_doc kitty_mod+f1 show_kitty_doc overview |

| key | Command palette | command_palette kitty_mod+f3 command_palette |

| key | Toggle fullscreen | toggle_fullscreen kitty_mod+f11 toggle_fullscreen |

| key | Toggle maximized | toggle_maximized kitty_mod+f10 toggle_maximized |

| key | Unicode input | input_unicode_character --allow-fallback=shifted,ascii kitty_mod+u kitten unicode_input |

| key | Edit config file | edit_config_file kitty_mod+f2 edit_config_file |

| key | Open the kitty command shell | kitty_shell kitty_mod+escape kitty_shell window |

| key | Increase background opacity | increase_background_opacity --allow-fallback=shifted,ascii kitty_mod+a>m set_background_opacity +0.1 |

| key | Decrease background opacity | decrease_background_opacity --allow-fallback=shifted,ascii kitty_mod+a>l set_background_opacity -0.1 |

| key | Make background fully opaque | full_background_opacity --allow-fallback=shifted,ascii kitty_mod+a>1 set_background_opacity 1 |

| key | Reset background opacity | reset_background_opacity --allow-fallback=shifted,ascii kitty_mod+a>d set_background_opacity default |

| key | Reset the terminal | reset_terminal kitty_mod+delete clear_terminal reset active |

| key | Reload kitty.conf | reload_config_file kitty_mod+f5 load_config_file |

| key | Debug kitty configuration | debug_config kitty_mod+f6 debug_config |

| key | Send arbitrary text on key presses | send_text ctrl+shift+alt+h send_text all Hello World |

## Neovim — live global mappings

Fresh headless startup exported 303 mappings. The additional prior catalog and context-specific sources below include more mappings than a plain buffer can expose. Modes: n normal, i insert, x visual, s select, o operator-pending, c command line, t terminal. Buffer-local mappings override globals. Disabled VS Code integrations are conditional in the preserved sources. `jk` leaves insert mode; Space begins leader sequences. Use `:Keymaps` or Space+s+k in an active context to inspect available keys; `:verbose map {lhs}` identifies its source.

# Neovim keymap catalog

Generated from the running configuration. Leader = Space; local leader = backslash.

Modes: n normal, i insert, x visual, s select, o operator pending, c command line, t terminal.

Includes global mappings and mappings local to the current buffer. Buffer mappings take precedence.
Filetype, LSP, completion, picker, and plugin-window mappings appear only when their context is active.
Built-in unmapped Vim commands are covered by `:help index`. Refresh with `:KeymapsExport path`.

| Mode | Key | Scope | Action |
|---|---|---|---|
| c | <C-S> | global | Toggle Flash Search |
| c | <S-CR> | global | Redirect Cmdline |
| i | <C-B> | global | Scroll Backward |
| i | <C-F> | global | Scroll Forward |
| i | <C-S> | global | vim.lsp.buf.signature_help() |
| i | <C-U> | global | :help i_CTRL-U-default |
| i | <C-W> | global | :help i_CTRL-W-default |
| i | <S-Tab> | global | vim.snippet.jump if active, otherwise <S-Tab> |
| i | <Tab> | global | vim.snippet.jump if active, otherwise <Tab> |
| n | % | global | <Plug>(MatchitNormalForward) |
| n | & | global | :help &-default |
| n | <C-A> | global | Increment |
| n | <C-B> | global | Scroll Backward |
| n | <C-Bslash> | global | Toggle terminal |
| n | <C-F> | global | Scroll Forward |
| n | <C-H> | global | Navigate left (Neovim/tmux) |
| n | <C-J> | global | Navigate down (Neovim/tmux) |
| n | <C-K> | global | Navigate up (Neovim/tmux) |
| n | <C-L> | global | Navigate right (Neovim/tmux) |
| n | <C-Space> | global | Treesitter Incremental Selection |
| n | <C-W>  | global | Window Hydra Mode (which-key) |
| n | <C-W><C-D> | global | Show diagnostics under the cursor |
| n | <C-W>d | global | Show diagnostics under the cursor |
| n | <C-X> | global | Decrement |
| n | <Plug>(MatchitNormalBackward) | global | :<C-U>call matchit#Match_wrapper('',0,'n')<CR> |
| n | <Plug>(MatchitNormalForward) | global | :<C-U>call matchit#Match_wrapper('',1,'n')<CR> |
| n | <Plug>(MatchitNormalMultiBackward) | global | :<C-U>call matchit#MultiMatch("bW", "n")<CR> |
| n | <Plug>(MatchitNormalMultiForward) | global | :<C-U>call matchit#MultiMatch("W",  "n")<CR> |
| n | <leader>  | global | Find Files (Root Dir) |
| n | <leader>, | global | Buffers |
| n | <leader>. | global | Scratch buffer |
| n | <leader>/ | global | Grep (Root Dir) |
| n | <leader>1 | global | Harpoon to File 1 |
| n | <leader>2 | global | Harpoon to File 2 |
| n | <leader>3 | global | Harpoon to File 3 |
| n | <leader>4 | global | Harpoon to File 4 |
| n | <leader>5 | global | Harpoon to File 5 |
| n | <leader>6 | global | Harpoon to File 6 |
| n | <leader>7 | global | Harpoon to File 7 |
| n | <leader>8 | global | Harpoon to File 8 |
| n | <leader>9 | global | Harpoon to File 9 |
| n | <leader>: | global | Command History |
| n | <leader>? | global | Buffer Keymaps (which-key) |
| n | <leader>D | global | Toggle DBUI |
| n | <leader>E | global | Explorer Snacks (cwd) |
| n | <leader>H | global | Harpoon File |
| n | <leader>S | global | Select scratch |
| n | <leader>Z | global | Zoom buffer |
| n | <leader>a | global | +ai |
| n | <leader>aC | global | Continue Claude |
| n | <leader>aa | global | Accept diff |
| n | <leader>ab | global | Add current buffer |
| n | <leader>ac | global | Toggle Claude |
| n | <leader>ad | global | Deny diff |
| n | <leader>af | global | Focus Claude |
| n | <leader>ap | global | Prompt Actions (CopilotChat) |
| n | <leader>aq | global | Quick Chat (CopilotChat) |
| n | <leader>ar | global | Resume Claude |
| n | <leader>ax | global | Clear (CopilotChat) |
| n | <leader>bP | global | Delete Non-Pinned Buffers |
| n | <leader>bj | global | Pick Buffer |
| n | <leader>bl | global | Delete Buffers to the Left |
| n | <leader>bp | global | Toggle Pin |
| n | <leader>br | global | Delete Buffers to the Right |
| n | <leader>cF | global | Format Injected Langs |
| n | <leader>cS | global | LSP references/definitions/... (Trouble) |
| n | <leader>cm | global | Mason |
| n | <leader>cs | global | Aerial (Symbols) |
| n | <leader>dB | global | Breakpoint Condition |
| n | <leader>dC | global | Run to Cursor |
| n | <leader>dO | global | Step Over |
| n | <leader>dP | global | Pause |
| n | <leader>da | global | Run with Args |
| n | <leader>db | global | Toggle Breakpoint |
| n | <leader>dc | global | Run/Continue |
| n | <leader>de | global | Eval |
| n | <leader>dg | global | Go to Line (No Execute) |
| n | <leader>di | global | Step Into |
| n | <leader>dj | global | Down |
| n | <leader>dk | global | Up |
| n | <leader>dl | global | Run Last |
| n | <leader>do | global | Step Out |
| n | <leader>dps | global | Profiler Scratch Buffer |
| n | <leader>dr | global | Toggle REPL |
| n | <leader>ds | global | Session |
| n | <leader>dt | global | Terminate |
| n | <leader>du | global | Dap UI |
| n | <leader>dw | global | Widgets |
| n | <leader>e | global | Explorer Snacks (root dir) |
| n | <leader>fB | global | Buffers (all) |
| n | <leader>fE | global | Explorer Snacks (cwd) |
| n | <leader>fF | global | Find Files (cwd) |
| n | <leader>fR | global | Recent (cwd) |
| n | <leader>fb | global | Buffers |
| n | <leader>fc | global | Find Config File |
| n | <leader>fe | global | Explorer Snacks (root dir) |
| n | <leader>ff | global | Find Files (Root Dir) |
| n | <leader>fg | global | Find Files (git-files) |
| n | <leader>fp | global | Projects |
| n | <leader>fr | global | Recent |
| n | <leader>ft | global | Float terminal |
| n | <leader>gD | global | Git Diff (origin) |
| n | <leader>gF | global | Fugitive (interactive stage) |
| n | <leader>gI | global | GitHub Issues (all) |
| n | <leader>gL | global | File git history |
| n | <leader>gO | global | Git checkout file (read) |
| n | <leader>gP | global | GitHub Pull Requests (all) |
| n | <leader>gS | global | Git Stash |
| n | <leader>gW | global | Git stage file (write) |
| n | <leader>gd | global | Git Diff (hunks) |
| n | <leader>gi | global | GitHub Issues (open) |
| n | <leader>gl | global | Lazygit file log |
| n | <leader>gp | global | GitHub Pull Requests (open) |
| n | <leader>gs | global | Git Status |
| n | <leader>h | global | Harpoon Quick Menu |
| n | <leader>n | global | Notification History |
| n | <leader>qS | global | Select Session |
| n | <leader>qd | global | Don't Save Current Session |
| n | <leader>ql | global | Restore Last Session |
| n | <leader>qs | global | Restore Session |
| n | <leader>s" | global | Registers |
| n | <leader>s/ | global | Search History |
| n | <leader>sB | global | Grep Open Buffers |
| n | <leader>sC | global | Commands |
| n | <leader>sD | global | Buffer Diagnostics |
| n | <leader>sG | global | Grep (cwd) |
| n | <leader>sH | global | Highlights |
| n | <leader>sM | global | Man Pages |
| n | <leader>sR | global | Resume |
| n | <leader>sT | global | Todo/Fix/Fixme |
| n | <leader>sW | global | Visual selection or word (cwd) |
| n | <leader>sa | global | Autocmds |
| n | <leader>sb | global | Buffer Lines |
| n | <leader>sc | global | Command History |
| n | <leader>sd | global | Diagnostics |
| n | <leader>sg | global | Grep (Root Dir) |
| n | <leader>sh | global | Help Pages |
| n | <leader>si | global | Icons |
| n | <leader>sj | global | Jumps |
| n | <leader>sk | global | Keymaps |
| n | <leader>sl | global | Location List |
| n | <leader>sm | global | Marks |
| n | <leader>sn | global | +noice |
| n | <leader>sna | global | Noice All |
| n | <leader>snd | global | Dismiss All |
| n | <leader>snh | global | Noice History |
| n | <leader>snl | global | Noice Last Message |
| n | <leader>snt | global | Noice Picker (Telescope/FzfLua) |
| n | <leader>sp | global | Search for Plugin Spec |
| n | <leader>sq | global | Quickfix List |
| n | <leader>sr | global | Search and Replace |
| n | <leader>st | global | Todo |
| n | <leader>su | global | Undotree |
| n | <leader>sw | global | Visual selection or word (Root Dir) |
| n | <leader>t | global | +test |
| n | <leader>tO | global | Toggle Output Panel (Neotest) |
| n | <leader>tS | global | Stop (Neotest) |
| n | <leader>tT | global | Run All Test Files (Neotest) |
| n | <leader>ta | global | Attach to Test (Neotest) |
| n | <leader>td | global | Debug Nearest |
| n | <leader>tl | global | Run Last (Neotest) |
| n | <leader>to | global | Show Output (Neotest) |
| n | <leader>tr | global | Run Nearest (Neotest) |
| n | <leader>ts | global | Toggle Summary (Neotest) |
| n | <leader>tt | global | Run File (Neotest) |
| n | <leader>tw | global | Toggle Watch (Neotest) |
| n | <leader>uC | global | Colorschemes |
| n | <leader>un | global | Dismiss All Notifications |
| n | <leader>uu | global | Undo tree |
| n | <leader>wp | global | Previous tmux pane |
| n | <leader>xL | global | Location List (Trouble) |
| n | <leader>xQ | global | Quickfix List (Trouble) |
| n | <leader>xT | global | Todo/Fix/Fixme (Trouble) |
| n | <leader>xX | global | Buffer Diagnostics (Trouble) |
| n | <leader>xt | global | Todo (Trouble) |
| n | <leader>xx | global | Diagnostics (Trouble) |
| n | <leader>z | global | Zen mode |
| n | H | global | Prev Buffer |
| n | L | global | Next Buffer |
| n | S | global | Flash Treesitter |
| n | Y | global | :help Y-default |
| n | [  | global | Add empty line above cursor |
| n | [% | global | <Plug>(MatchitNormalMultiBackward) |
| n | [<C-L> | global | :lpfile |
| n | [<C-Q> | global | :cpfile |
| n | [<C-T> | global | :ptprevious |
| n | [A | global | :rewind |
| n | [B | global | Move buffer prev |
| n | [D | global | Jump to the first diagnostic in the current buffer |
| n | [L | global | :lrewind |
| n | [Q | global | :crewind |
| n | [T | global | :trewind |
| n | [a | global | :previous |
| n | [b | global | Prev Buffer |
| n | [d | global | Jump to the previous diagnostic in the current buffer |
| n | [l | global | :lprevious |
| n | [q | global | Previous Trouble/Quickfix Item |
| n | [s | global | Aerial prev symbol |
| n | [t | global | Previous Todo Comment |
| n | ]  | global | Add empty line below cursor |
| n | ]% | global | <Plug>(MatchitNormalMultiForward) |
| n | ]<C-L> | global | :lnfile |
| n | ]<C-Q> | global | :cnfile |
| n | ]<C-T> | global | :ptnext |
| n | ]A | global | :last |
| n | ]B | global | Move buffer next |
| n | ]D | global | Jump to the last diagnostic in the current buffer |
| n | ]L | global | :llast |
| n | ]Q | global | :clast |
| n | ]T | global | :tlast |
| n | ]a | global | :next |
| n | ]b | global | Next Buffer |
| n | ]d | global | Jump to the next diagnostic in the current buffer |
| n | ]l | global | :lnext |
| n | ]q | global | Next Trouble/Quickfix Item |
| n | ]s | global | Aerial next symbol |
| n | ]t | global | Next Todo Comment |
| n | g% | global | <Plug>(MatchitNormalBackward) |
| n | gO | global | vim.lsp.buf.document_symbol() |
| n | gc | global | Toggle comment |
| n | gcc | global | Toggle comment line |
| n | gra | global | vim.lsp.buf.code_action() |
| n | gri | global | vim.lsp.buf.implementation() |
| n | grn | global | vim.lsp.buf.rename() |
| n | grr | global | vim.lsp.buf.references() |
| n | grt | global | vim.lsp.buf.type_definition() |
| n | grx | global | vim.lsp.codelens.run() |
| n | gsF | global | Find Left Surrounding |
| n | gsa | global | Add Surrounding |
| n | gsd | global | Delete Surrounding |
| n | gsf | global | Find Right Surrounding |
| n | gsh | global | Highlight Surrounding |
| n | gsn | global | Update &#96;MiniSurround.config.n_lines&#96; |
| n | gsr | global | Replace Surrounding |
| n | gx | global | Opens filepath or URI under cursor with the system handler (file explorer, web browser, …) |
| n | s | global | Flash |
| o | % | global | <Plug>(MatchitOperationForward) |
| o | <C-Space> | global | Treesitter Incremental Selection |
| o | <Plug>(MatchitOperationBackward) | global | :<C-U>call matchit#Match_wrapper('',0,'o')<CR> |
| o | <Plug>(MatchitOperationForward) | global | :<C-U>call matchit#Match_wrapper('',1,'o')<CR> |
| o | <Plug>(MatchitOperationMultiBackward) | global | :<C-U>call matchit#MultiMatch("bW", "o")<CR> |
| o | <Plug>(MatchitOperationMultiForward) | global | :<C-U>call matchit#MultiMatch("W",  "o")<CR> |
| o | R | global | Treesitter Search |
| o | S | global | Flash Treesitter |
| o | [% | global | <Plug>(MatchitOperationMultiBackward) |
| o | ]% | global | <Plug>(MatchitOperationMultiForward) |
| o | an | global | Select parent (outer) node |
| o | g% | global | <Plug>(MatchitOperationBackward) |
| o | gc | global | Comment textobject |
| o | in | global | Select child (inner) node |
| o | r | global | Remote Flash |
| o | s | global | Flash |
| s | <C-A> | global | Increment (visual) |
| s | <C-B> | global | Scroll Backward |
| s | <C-F> | global | Scroll Forward |
| s | <C-S> | global | vim.lsp.buf.signature_help() |
| s | <C-X> | global | Decrement (visual) |
| s | <S-Tab> | global | vim.snippet.jump if active, otherwise <S-Tab> |
| s | <Tab> | global | vim.snippet.jump if active, otherwise <Tab> |
| s | <leader>a | global | +ai |
| s | <leader>as | global | Send to Claude |
| t | <C-Bslash> | global | Toggle terminal |
| x | # | global | :help v_#-default |
| x | % | global | <Plug>(MatchitVisualForward) |
| x | * | global | :help v_star-default |
| x | <C-A> | global | Increment (visual) |
| x | <C-Space> | global | Treesitter Incremental Selection |
| x | <C-X> | global | Decrement (visual) |
| x | <Plug>(MatchitVisualBackward) | global | :<C-U>call matchit#Match_wrapper('',0,'v')<CR>m'gv&#96;&#96; |
| x | <Plug>(MatchitVisualForward) | global | :<C-U>call matchit#Match_wrapper('',1,'v')<CR>:if col("''") != col("$") &#124; exe ":normal! m'" &#124; endif<CR>gv&#96;&#96; |
| x | <Plug>(MatchitVisualMultiBackward) | global | :<C-U>call matchit#MultiMatch("bW", "n")<CR>m'gv&#96;&#96; |
| x | <Plug>(MatchitVisualMultiForward) | global | :<C-U>call matchit#MultiMatch("W",  "n")<CR>m'gv&#96;&#96; |
| x | <Plug>(MatchitVisualTextObject) | global | <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward) |
| x | <leader>a | global | +ai |
| x | <leader>aa | global | Toggle (CopilotChat) |
| x | <leader>ap | global | Prompt Actions (CopilotChat) |
| x | <leader>aq | global | Quick Chat (CopilotChat) |
| x | <leader>as | global | Send to Claude |
| x | <leader>ax | global | Clear (CopilotChat) |
| x | <leader>cF | global | Format Injected Langs |
| x | <leader>de | global | Eval |
| x | <leader>sW | global | Visual selection or word (cwd) |
| x | <leader>sr | global | Search and Replace |
| x | <leader>sw | global | Visual selection or word (Root Dir) |
| x | @ | global | :help v_@-default |
| x | Q | global | :help v_Q-default |
| x | R | global | Treesitter Search |
| x | S | global | Flash Treesitter |
| x | [% | global | <Plug>(MatchitVisualMultiBackward) |
| x | [N | global | Select previous sibling node |
| x | [n | global | Select previous node |
| x | ]% | global | <Plug>(MatchitVisualMultiForward) |
| x | ]N | global | Select next sibling node |
| x | ]n | global | Select next node |
| x | a% | global | <Plug>(MatchitVisualTextObject) |
| x | an | global | Select parent (outer) node |
| x | g% | global | <Plug>(MatchitVisualBackward) |
| x | gc | global | Toggle comment |
| x | gra | global | vim.lsp.buf.code_action() |
| x | gsa | global | Add Surrounding |
| x | gx | global | Opens filepath or URI under cursor with the system handler (file explorer, web browser, …) |
| x | in | global | Select child (inner) node |
| x | s | global | Flash |


### Previous full editor catalog

Existing repository export retained for context coverage; not every entry is active in a plain startup buffer. Fresh runtime table above takes precedence for overlaps.

# Neovim keymap catalog

Generated from the running configuration. Leader = Space; local leader = backslash.

Modes: n normal, i insert, x visual, s select, o operator pending, c command line, t terminal.

Includes global mappings and mappings local to the current buffer. Buffer mappings take precedence.
Filetype, LSP, completion, picker, and plugin-window mappings appear only when their context is active.
Built-in unmapped Vim commands are covered by `:help index`. Refresh with `:KeymapsExport path`.

| Mode | Key | Scope | Action |
|---|---|---|---|
| c | " | global | Closeopen action for '""' pair |
| c | ' | global | Closeopen action for "''" pair |
| c | ( | global | Open action for "()" pair |
| c | ) | global | Close action for "()" pair |
| c | <BS> | global | MiniPairs <BS> |
| c | <C-A> | global | Line start |
| c | <C-E> | global | Line end |
| c | <C-S> | global | Toggle Flash Search |
| c | <S-CR> | global | Redirect Cmdline |
| c | [ | global | Open action for "[]" pair |
| c | ] | global | Close action for "[]" pair |
| c | &#96; | global | Closeopen action for "&#96;&#96;" pair |
| c | { | global | Open action for "{}" pair |
| c | } | global | Close action for "{}" pair |
| i | " | global | Closeopen action for '""' pair |
| i | ' | global | Closeopen action for "''" pair |
| i | ( | global | Open action for "()" pair |
| i | ) | global | Close action for "()" pair |
| i | , | global | ,<C-G>u |
| i | . | global | .<C-G>u |
| i | ; | global | ;<C-G>u |
| i | <BS> | global | MiniPairs <BS> |
| i | <C-B> | global | Scroll Backward |
| i | <C-F> | global | Scroll Forward |
| i | <C-K> | buffer | Signature Help |
| i | <C-S> | global | Save File |
| i | <C-U> | global | :help i_CTRL-U-default |
| i | <C-W> | global | :help i_CTRL-W-default |
| i | <CR> | global | MiniPairs <CR> |
| i | <Esc> | global | Escape and Clear hlsearch |
| i | <M-[> | buffer | Prev Copilot Suggestion |
| i | <M-]> | buffer | Next Copilot Suggestion |
| i | <M-j> | global | Move Down |
| i | <M-k> | global | Move Up |
| i | <S-Tab> | global | vim.snippet.jump if active, otherwise <S-Tab> |
| i | <Tab> | global | vim.snippet.jump if active, otherwise <Tab> |
| i | [ | global | Open action for "[]" pair |
| i | ] | global | Close action for "[]" pair |
| i | &#96; | global | Closeopen action for "&#96;&#96;" pair |
| i | jk | global | Exit insert mode |
| i | { | global | Open action for "{}" pair |
| i | } | global | Close action for "{}" pair |
| n | " | buffer | which-key-trigger registers |
| n | % | global | <Plug>(MatchitNormalForward) |
| n | & | global | :help &-default |
| n | ' | buffer | which-key-trigger marks |
| n | , | global | Lua callback |
| n | ; | global | Lua callback |
| n | <C-/> | global | Terminal (Root Dir) |
| n | <C-A> | global | Increment |
| n | <C-B> | global | Scroll Backward |
| n | <C-Bslash> | global | Toggle terminal |
| n | <C-D> | global | Half page down |
| n | <C-Down> | global | Shrink split down |
| n | <C-F> | global | Scroll Forward |
| n | <C-H> | global | Navigate left (Neovim/tmux) |
| n | <C-J> | global | Navigate down (Neovim/tmux) |
| n | <C-K> | global | Navigate up (Neovim/tmux) |
| n | <C-L> | global | Navigate right (Neovim/tmux) |
| n | <C-Left> | global | Shrink split left |
| n | <C-Right> | global | Grow split right |
| n | <C-S> | global | Save File |
| n | <C-Space> | global | Treesitter Incremental Selection |
| n | <C-U> | global | Half page up |
| n | <C-Up> | global | Grow split up |
| n | <C-W> | buffer | which-key-trigger |
| n | <C-W>  | global | Window Hydra Mode (which-key) |
| n | <C-W><C-D> | global | Show diagnostics under the cursor |
| n | <C-W>d | global | Show diagnostics under the cursor |
| n | <C-X> | global | Decrement |
| n | <C-_> | global | which_key_ignore |
| n | <Down> | global | Down |
| n | <Esc> | global | Clear search highlight |
| n | <M-1> | global | Harpoon mark 1 |
| n | <M-2> | global | Harpoon mark 2 |
| n | <M-3> | global | Harpoon mark 3 |
| n | <M-4> | global | Harpoon mark 4 |
| n | <M-[> | buffer | Prev Copilot Suggestion |
| n | <M-]> | buffer | Next Copilot Suggestion |
| n | <M-j> | global | Move Down |
| n | <M-k> | global | Move Up |
| n | <M-n> | buffer | Next Reference |
| n | <M-n> | global | Move to next reference |
| n | <M-p> | buffer | Prev Reference |
| n | <M-p> | global | Move to previous reference |
| n | <Plug>(MatchitNormalBackward) | global | :<C-U>call matchit#Match_wrapper('',0,'n')<CR> |
| n | <Plug>(MatchitNormalForward) | global | :<C-U>call matchit#Match_wrapper('',1,'n')<CR> |
| n | <Plug>(MatchitNormalMultiBackward) | global | :<C-U>call matchit#MultiMatch("bW", "n")<CR> |
| n | <Plug>(MatchitNormalMultiForward) | global | :<C-U>call matchit#MultiMatch("W",  "n")<CR> |
| n | <Up> | global | Up |
| n | <leader> | buffer | which-key-trigger |
| n | <leader>  | global | Find Files (Root Dir) |
| n | <leader>, | global | Buffers |
| n | <leader>- | global | Split Window Below |
| n | <leader>. | global | Scratch buffer |
| n | <leader>/ | global | Grep (Root Dir) |
| n | <leader>1 | global | Harpoon to File 1 |
| n | <leader>2 | global | Harpoon to File 2 |
| n | <leader>3 | global | Harpoon to File 3 |
| n | <leader>4 | global | Harpoon to File 4 |
| n | <leader>5 | global | Harpoon to File 5 |
| n | <leader>6 | global | Harpoon to File 6 |
| n | <leader>7 | global | Harpoon to File 7 |
| n | <leader>8 | global | Harpoon to File 8 |
| n | <leader>9 | global | Harpoon to File 9 |
| n | <leader>: | global | Command History |
| n | <leader><Tab><Tab> | global | New Tab |
| n | <leader><Tab>[ | global | Previous Tab |
| n | <leader><Tab>] | global | Next Tab |
| n | <leader><Tab>d | global | Close Tab |
| n | <leader><Tab>f | global | First Tab |
| n | <leader><Tab>l | global | Last Tab |
| n | <leader><Tab>o | global | Close Other Tabs |
| n | <leader>? | global | Buffer Keymaps (which-key) |
| n | <leader>D | global | Delete to void |
| n | <leader>E | global | Explorer Snacks (cwd) |
| n | <leader>H | global | Harpoon File |
| n | <leader>K | global | Keywordprg |
| n | <leader>L | global | LazyVim Changelog |
| n | <leader>S | global | Select scratch |
| n | <leader>Y | global | Yank line to clipboard |
| n | <leader>Z | global | Zoom buffer |
| n | <leader>&#96; | global | Switch to Other Buffer |
| n | <leader>a | global | +ai |
| n | <leader>aC | global | Continue Claude |
| n | <leader>aa | global | Toggle (CopilotChat) |
| n | <leader>ab | global | Add current buffer |
| n | <leader>ac | global | Toggle Claude |
| n | <leader>ad | global | Deny diff |
| n | <leader>af | global | Focus Claude |
| n | <leader>ap | global | Prompt Actions (CopilotChat) |
| n | <leader>aq | global | Quick Chat (CopilotChat) |
| n | <leader>ar | global | Resume Claude |
| n | <leader>ax | global | Clear (CopilotChat) |
| n | <leader>bD | global | Delete Buffer and Window |
| n | <leader>bP | global | Delete Non-Pinned Buffers |
| n | <leader>bb | global | Switch to Other Buffer |
| n | <leader>bd | global | Delete Buffer |
| n | <leader>bj | global | Pick Buffer |
| n | <leader>bl | global | Delete Buffers to the Left |
| n | <leader>bo | global | Delete Other Buffers |
| n | <leader>bp | global | Toggle Pin |
| n | <leader>br | global | Delete Buffers to the Right |
| n | <leader>cA | buffer | Source Action |
| n | <leader>cC | buffer | Refresh & Display Codelens |
| n | <leader>cF | global | Format Injected Langs |
| n | <leader>cR | buffer | Rename File |
| n | <leader>cS | global | LSP references/definitions/... (Trouble) |
| n | <leader>ca | buffer | Code Action |
| n | <leader>cc | buffer | Run Codelens |
| n | <leader>cd | global | Line Diagnostics |
| n | <leader>cf | global | Format |
| n | <leader>cl | buffer | Lsp Info |
| n | <leader>cm | global | Mason |
| n | <leader>cr | buffer | Rename |
| n | <leader>cs | global | Aerial (Symbols) |
| n | <leader>cx | global | Make file executable |
| n | <leader>dB | global | Breakpoint Condition |
| n | <leader>dC | global | Run to Cursor |
| n | <leader>dO | global | Step Over |
| n | <leader>dP | global | Pause |
| n | <leader>da | global | Run with Args |
| n | <leader>db | global | Toggle Breakpoint |
| n | <leader>dc | global | Run/Continue |
| n | <leader>de | global | Eval |
| n | <leader>dg | global | Go to Line (No Execute) |
| n | <leader>di | global | Step Into |
| n | <leader>dj | global | Down |
| n | <leader>dk | global | Up |
| n | <leader>dl | global | Run Last |
| n | <leader>do | global | Step Out |
| n | <leader>dph | global | Toggle Profiler Highlights |
| n | <leader>dpp | global | Toggle Profiler |
| n | <leader>dps | global | Profiler Scratch Buffer |
| n | <leader>dr | global | Toggle REPL |
| n | <leader>ds | global | Session |
| n | <leader>dt | global | Terminate |
| n | <leader>du | global | Dap UI |
| n | <leader>dw | global | Widgets |
| n | <leader>e | global | Explorer Snacks (root dir) |
| n | <leader>fB | global | Buffers (all) |
| n | <leader>fE | global | Explorer Snacks (cwd) |
| n | <leader>fF | global | Find Files (cwd) |
| n | <leader>fR | global | Recent (cwd) |
| n | <leader>fT | global | Terminal (cwd) |
| n | <leader>fb | global | Buffers |
| n | <leader>fc | global | Find Config File |
| n | <leader>fe | global | Explorer Snacks (root dir) |
| n | <leader>ff | global | Find Files (Root Dir) |
| n | <leader>fg | global | Find Files (git-files) |
| n | <leader>fn | global | New File |
| n | <leader>fp | global | Projects |
| n | <leader>fr | global | Recent |
| n | <leader>ft | global | Float terminal |
| n | <leader>gB | global | Git Browse (open) |
| n | <leader>gD | global | Git Diff (origin) |
| n | <leader>gF | global | Fugitive (interactive stage) |
| n | <leader>gG | global | Lazygit (cwd) |
| n | <leader>gI | global | GitHub Issues (all) |
| n | <leader>gL | global | File git history |
| n | <leader>gO | global | Git checkout file (read) |
| n | <leader>gP | global | GitHub Pull Requests (all) |
| n | <leader>gS | global | Git Stash |
| n | <leader>gW | global | Git stage file (write) |
| n | <leader>gY | global | Git Browse (copy) |
| n | <leader>gb | global | Git Blame Line |
| n | <leader>gd | global | Git Diff (hunks) |
| n | <leader>gf | global | Git Current File History |
| n | <leader>gg | global | Lazygit (Root Dir) |
| n | <leader>ghB | buffer | Blame Buffer |
| n | <leader>ghD | buffer | Diff This ~ |
| n | <leader>ghR | buffer | Reset Buffer |
| n | <leader>ghS | buffer | Stage Buffer |
| n | <leader>ghb | buffer | Blame Line |
| n | <leader>ghd | buffer | Diff This |
| n | <leader>ghp | buffer | Preview Hunk Inline |
| n | <leader>ghr | buffer | Reset Hunk |
| n | <leader>ghs | buffer | Stage Hunk |
| n | <leader>ghu | buffer | Undo Stage Hunk |
| n | <leader>gi | global | GitHub Issues (open) |
| n | <leader>gl | global | Lazygit file log |
| n | <leader>gp | global | GitHub Pull Requests (open) |
| n | <leader>gs | global | Git Status |
| n | <leader>h | global | Harpoon Quick Menu |
| n | <leader>l | global | Lazy |
| n | <leader>n | global | Notification History |
| n | <leader>qS | global | Select Session |
| n | <leader>qd | global | Don't Save Current Session |
| n | <leader>ql | global | Restore Last Session |
| n | <leader>qq | global | Quit All |
| n | <leader>qs | global | Restore Session |
| n | <leader>rw | global | Rename word in file |
| n | <leader>s" | global | Registers |
| n | <leader>s/ | global | Search History |
| n | <leader>sB | global | Grep Open Buffers |
| n | <leader>sC | global | Commands |
| n | <leader>sD | global | Buffer Diagnostics |
| n | <leader>sG | global | Grep (cwd) |
| n | <leader>sH | global | Highlights |
| n | <leader>sM | global | Man Pages |
| n | <leader>sR | global | Resume |
| n | <leader>sS | buffer | LSP Workspace Symbols |
| n | <leader>sT | global | Todo/Fix/Fixme |
| n | <leader>sW | global | Visual selection or word (cwd) |
| n | <leader>sa | global | Autocmds |
| n | <leader>sb | global | Buffer Lines |
| n | <leader>sc | global | Command History |
| n | <leader>sd | global | Diagnostics |
| n | <leader>sg | global | Grep (Root Dir) |
| n | <leader>sh | global | Help Pages |
| n | <leader>si | global | Icons |
| n | <leader>sj | global | Jumps |
| n | <leader>sk | global | Keymaps |
| n | <leader>sl | global | Location List |
| n | <leader>sm | global | Marks |
| n | <leader>sn | global | +noice |
| n | <leader>sna | global | Noice All |
| n | <leader>snd | global | Dismiss All |
| n | <leader>snh | global | Noice History |
| n | <leader>snl | global | Noice Last Message |
| n | <leader>snt | global | Noice Picker (Telescope/FzfLua) |
| n | <leader>sp | global | Search for Plugin Spec |
| n | <leader>sq | global | Quickfix List |
| n | <leader>sr | global | Search and Replace |
| n | <leader>ss | buffer | LSP Symbols |
| n | <leader>st | global | Todo |
| n | <leader>su | global | Undotree |
| n | <leader>sw | global | Visual selection or word (Root Dir) |
| n | <leader>t | global | +test |
| n | <leader>tO | global | Toggle Output Panel (Neotest) |
| n | <leader>tS | global | Stop (Neotest) |
| n | <leader>tT | global | Run All Test Files (Neotest) |
| n | <leader>ta | global | Attach to Test (Neotest) |
| n | <leader>td | global | Debug Nearest |
| n | <leader>tl | global | Run Last (Neotest) |
| n | <leader>to | global | Show Output (Neotest) |
| n | <leader>tr | global | Run Nearest (Neotest) |
| n | <leader>ts | global | Toggle Summary (Neotest) |
| n | <leader>tt | global | Run File (Neotest) |
| n | <leader>tw | global | Toggle Watch (Neotest) |
| n | <leader>uA | global | Toggle Tabline |
| n | <leader>uC | global | Colorschemes |
| n | <leader>uD | global | Toggle Dimming |
| n | <leader>uF | global | Toggle Auto Format (Buffer) |
| n | <leader>uG | global | Toggle Git Signs |
| n | <leader>uI | global | Inspect Tree |
| n | <leader>uL | global | Toggle Relative Number |
| n | <leader>uS | global | Toggle Smooth Scroll |
| n | <leader>uT | global | Toggle Treesitter Highlight |
| n | <leader>uZ | global | Toggle Zoom Mode |
| n | <leader>ua | global | Toggle Animations |
| n | <leader>ub | global | Toggle Dark Background |
| n | <leader>uc | global | Toggle Conceal Level |
| n | <leader>ud | global | Toggle Diagnostics |
| n | <leader>uf | global | Toggle Auto Format (Global) |
| n | <leader>ug | global | Toggle Indent Guides |
| n | <leader>uh | global | Toggle Inlay Hints |
| n | <leader>ui | global | Inspect Pos |
| n | <leader>ul | global | Toggle Line Numbers |
| n | <leader>un | global | Dismiss All Notifications |
| n | <leader>up | global | Toggle Mini Pairs |
| n | <leader>ur | global | Redraw / Clear hlsearch / Diff Update |
| n | <leader>us | global | Toggle Spelling |
| n | <leader>uu | global | Undo tree |
| n | <leader>uw | global | Toggle Wrap |
| n | <leader>uz | global | Toggle Zen Mode |
| n | <leader>w | buffer | which-key-trigger |
| n | <leader>wd | global | Delete Window |
| n | <leader>we | global | Equalize splits |
| n | <leader>wm | global | Toggle Zoom Mode |
| n | <leader>wp | global | Previous tmux pane |
| n | <leader>xL | global | Location List (Trouble) |
| n | <leader>xQ | global | Quickfix List (Trouble) |
| n | <leader>xT | global | Todo/Fix/Fixme (Trouble) |
| n | <leader>xX | global | Buffer Diagnostics (Trouble) |
| n | <leader>xl | global | Location List |
| n | <leader>xq | global | Quickfix List |
| n | <leader>xt | global | Todo (Trouble) |
| n | <leader>xx | global | Diagnostics (Trouble) |
| n | <leader>y | global | Yank to clipboard |
| n | <leader>z | global | Zen mode |
| n | <leader>&#124; | global | Split Window Right |
| n | F | global | Lua callback |
| n | G | global | End of file (centered) |
| n | H | global | Prev Buffer |
| n | J | global | Join lines |
| n | K | buffer | Hover |
| n | L | global | Next Buffer |
| n | N | global | Prev result (centered) |
| n | S | global | Flash Treesitter |
| n | T | global | Lua callback |
| n | Y | global | :help Y-default |
| n | [ | buffer | which-key-trigger |
| n | [  | global | Add empty line above cursor |
| n | [% | global | <Plug>(MatchitNormalMultiBackward) |
| n | [<C-L> | global | :lpfile |
| n | [<C-Q> | global | :cpfile |
| n | [<C-T> | global | :ptprevious |
| n | [A | buffer | Prev Parameter End |
| n | [A | global | :rewind |
| n | [B | global | Move buffer prev |
| n | [C | buffer | Prev Class End |
| n | [D | global | Jump to the first diagnostic in the current buffer |
| n | [F | buffer | Prev Function End |
| n | [H | buffer | First Hunk |
| n | [L | global | :lrewind |
| n | [Q | global | First quickfix |
| n | [T | global | :trewind |
| n | [[ | buffer | Prev Reference |
| n | [a | buffer | Prev Parameter Start |
| n | [a | global | :previous |
| n | [b | global | Prev Buffer |
| n | [c | buffer | Prev Class Start |
| n | [d | global | Prev Diagnostic |
| n | [e | global | Prev Error |
| n | [f | buffer | Prev Function Start |
| n | [h | buffer | Prev Hunk |
| n | [i | global | jump to top edge of scope |
| n | [l | global | Prev loclist |
| n | [m | global | Harpoon prev |
| n | [q | global | Prev quickfix |
| n | [s | global | Aerial prev symbol |
| n | [t | global | Previous Todo Comment |
| n | [w | global | Prev Warning |
| n | \ | buffer | which-key-trigger |
| n | \r | buffer | Run Lua |
| n | ] | buffer | which-key-trigger |
| n | ]  | global | Add empty line below cursor |
| n | ]% | global | <Plug>(MatchitNormalMultiForward) |
| n | ]<C-L> | global | :lnfile |
| n | ]<C-Q> | global | :cnfile |
| n | ]<C-T> | global | :ptnext |
| n | ]A | buffer | Next Parameter End |
| n | ]A | global | :last |
| n | ]B | global | Move buffer next |
| n | ]C | buffer | Next Class End |
| n | ]D | global | Jump to the last diagnostic in the current buffer |
| n | ]F | buffer | Next Function End |
| n | ]H | buffer | Last Hunk |
| n | ]L | global | :llast |
| n | ]Q | global | Last quickfix |
| n | ]T | global | :tlast |
| n | ]] | buffer | Next Reference |
| n | ]a | buffer | Next Parameter Start |
| n | ]a | global | :next |
| n | ]b | global | Next Buffer |
| n | ]c | buffer | Next Class Start |
| n | ]d | global | Next Diagnostic |
| n | ]e | global | Next Error |
| n | ]f | buffer | Next Function Start |
| n | ]h | buffer | Next Hunk |
| n | ]i | global | jump to bottom edge of scope |
| n | ]l | global | Next loclist |
| n | ]m | global | Harpoon next |
| n | ]q | global | Next quickfix |
| n | ]s | global | Aerial next symbol |
| n | ]t | global | Next Todo Comment |
| n | ]w | global | Next Warning |
| n | &#96; | buffer | which-key-trigger marks |
| n | f | global | Lua callback |
| n | g | buffer | which-key-trigger |
| n | g% | global | <Plug>(MatchitNormalBackward) |
| n | g' | buffer | which-key-trigger marks |
| n | gD | buffer | Goto Declaration |
| n | gI | buffer | Goto Implementation |
| n | gK | buffer | Signature Help |
| n | gO | global | vim.lsp.buf.document_symbol() |
| n | g[ | global | Move to left "around" |
| n | g] | global | Move to right "around" |
| n | g&#96; | buffer | which-key-trigger marks |
| n | gc | global | Toggle comment |
| n | gcO | global | Add Comment Above |
| n | gcc | global | Toggle comment line |
| n | gco | global | Add Comment Below |
| n | gd | buffer | Goto Definition |
| n | gr | buffer | References |
| n | gra | global | vim.lsp.buf.code_action() |
| n | gri | global | vim.lsp.buf.implementation() |
| n | grn | global | vim.lsp.buf.rename() |
| n | grr | global | vim.lsp.buf.references() |
| n | grt | global | vim.lsp.buf.type_definition() |
| n | grx | global | vim.lsp.codelens.run() |
| n | gsF | global | Find Left Surrounding |
| n | gsa | global | Add Surrounding |
| n | gsd | global | Delete Surrounding |
| n | gsf | global | Find Right Surrounding |
| n | gsh | global | Highlight Surrounding |
| n | gsn | global | Update &#96;MiniSurround.config.n_lines&#96; |
| n | gsr | global | Replace Surrounding |
| n | gx | global | Opens filepath or URI under cursor with the system handler (file explorer, web browser, …) |
| n | gy | buffer | Goto T[y]pe Definition |
| n | j | global | v:count == 0 ? 'gj' : 'j' |
| n | k | global | v:count == 0 ? 'gk' : 'k' |
| n | n | global | Next result (centered) |
| n | s | global | Flash |
| n | t | global | Lua callback |
| n | z | buffer | which-key-trigger |
| n | z= | buffer | which-key-trigger spelling |
| n | zM | global | Close all folds |
| n | zR | global | Open all folds |
| o | % | global | <Plug>(MatchitOperationForward) |
| o | , | global | Lua callback |
| o | ; | global | Lua callback |
| o | <C-Space> | global | Treesitter Incremental Selection |
| o | <M-i> | global | Lua callback |
| o | <Plug>(MatchitOperationBackward) | global | :<C-U>call matchit#Match_wrapper('',0,'o')<CR> |
| o | <Plug>(MatchitOperationForward) | global | :<C-U>call matchit#Match_wrapper('',1,'o')<CR> |
| o | <Plug>(MatchitOperationMultiBackward) | global | :<C-U>call matchit#MultiMatch("bW", "o")<CR> |
| o | <Plug>(MatchitOperationMultiForward) | global | :<C-U>call matchit#MultiMatch("W",  "o")<CR> |
| o | F | global | Lua callback |
| o | N | global | Prev Search Result |
| o | R | global | Treesitter Search |
| o | S | global | Flash Treesitter |
| o | T | global | Lua callback |
| o | [% | global | <Plug>(MatchitOperationMultiBackward) |
| o | [A | buffer | Prev Parameter End |
| o | [C | buffer | Prev Class End |
| o | [F | buffer | Prev Function End |
| o | [a | buffer | Prev Parameter Start |
| o | [c | buffer | Prev Class Start |
| o | [f | buffer | Prev Function Start |
| o | [i | global | jump to top edge of scope |
| o | ]% | global | <Plug>(MatchitOperationMultiForward) |
| o | ]A | buffer | Next Parameter End |
| o | ]C | buffer | Next Class End |
| o | ]F | buffer | Next Function End |
| o | ]a | buffer | Next Parameter Start |
| o | ]c | buffer | Next Class Start |
| o | ]f | buffer | Next Function Start |
| o | ]i | global | jump to bottom edge of scope |
| o | a | global | Around textobject |
| o | ai | global | full scope |
| o | al | global | Around last textobject |
| o | an | global | Around next textobject |
| o | f | global | Lua callback |
| o | g% | global | <Plug>(MatchitOperationBackward) |
| o | g[ | global | Move to left "around" |
| o | g] | global | Move to right "around" |
| o | gc | global | Comment textobject |
| o | i | global | Inside textobject |
| o | ih | buffer | GitSigns Select Hunk |
| o | ii | global | inner scope |
| o | il | global | Inside last textobject |
| o | in | global | Inside next textobject |
| o | n | global | Next Search Result |
| o | r | global | Remote Flash |
| o | s | global | Flash |
| o | t | global | Lua callback |
| s | <C-A> | global | Increment (visual) |
| s | <C-B> | global | Scroll Backward |
| s | <C-F> | global | Scroll Forward |
| s | <C-S> | global | Save File |
| s | <C-X> | global | Decrement (visual) |
| s | <Esc> | global | Escape and Clear hlsearch |
| s | <M-j> | global | Move Down |
| s | <M-k> | global | Move Up |
| s | <S-Tab> | global | vim.snippet.jump if active, otherwise <S-Tab> |
| s | <Tab> | global | vim.snippet.jump if active, otherwise <Tab> |
| s | <leader>D | global | Delete to void |
| s | <leader>a | global | +ai |
| s | <leader>as | global | Send to Claude |
| s | <leader>y | global | Yank to clipboard |
| s | J | global | Move selection down |
| s | K | global | Move selection up |
| t | <C-/> | global | Terminal (Root Dir) |
| t | <C-Bslash> | global | Toggle terminal |
| t | <C-_> | global | which_key_ignore |
| x | # | global | :help v_#-default |
| x | % | global | <Plug>(MatchitVisualForward) |
| x | * | global | :help v_star-default |
| x | , | global | Lua callback |
| x | ; | global | Lua callback |
| x | <C-A> | global | Increment (visual) |
| x | <C-S> | global | Save File |
| x | <C-Space> | global | Treesitter Incremental Selection |
| x | <C-X> | global | Decrement (visual) |
| x | <Down> | global | Down |
| x | <M-i> | global | Lua callback |
| x | <M-j> | global | Move Down |
| x | <M-k> | global | Move Up |
| x | <Plug>(MatchitVisualBackward) | global | :<C-U>call matchit#Match_wrapper('',0,'v')<CR>m'gv&#96;&#96; |
| x | <Plug>(MatchitVisualForward) | global | :<C-U>call matchit#Match_wrapper('',1,'v')<CR>:if col("''") != col("$") &#124; exe ":normal! m'" &#124; endif<CR>gv&#96;&#96; |
| x | <Plug>(MatchitVisualMultiBackward) | global | :<C-U>call matchit#MultiMatch("bW", "n")<CR>m'gv&#96;&#96; |
| x | <Plug>(MatchitVisualMultiForward) | global | :<C-U>call matchit#MultiMatch("W",  "n")<CR>m'gv&#96;&#96; |
| x | <Plug>(MatchitVisualTextObject) | global | <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward) |
| x | <Up> | global | Up |
| x | <leader>D | global | Delete to void |
| x | <leader>a | global | +ai |
| x | <leader>aa | global | Toggle (CopilotChat) |
| x | <leader>ap | global | Prompt Actions (CopilotChat) |
| x | <leader>aq | global | Quick Chat (CopilotChat) |
| x | <leader>as | global | Send to Claude |
| x | <leader>ax | global | Clear (CopilotChat) |
| x | <leader>cF | global | Format Injected Langs |
| x | <leader>ca | buffer | Code Action |
| x | <leader>cc | buffer | Run Codelens |
| x | <leader>cf | global | Format |
| x | <leader>de | global | Eval |
| x | <leader>gB | global | Git Browse (open) |
| x | <leader>gY | global | Git Browse (copy) |
| x | <leader>ghr | buffer | Reset Hunk |
| x | <leader>ghs | buffer | Stage Hunk |
| x | <leader>sW | global | Visual selection or word (cwd) |
| x | <leader>sr | global | Search and Replace |
| x | <leader>sw | global | Visual selection or word (Root Dir) |
| x | <leader>y | global | Yank to clipboard |
| x | <lt> | global | <lt>gv |
| x | > | global | >gv |
| x | @ | global | :help v_@-default |
| x | F | global | Lua callback |
| x | J | global | Move selection down |
| x | K | global | Move selection up |
| x | N | global | Prev Search Result |
| x | Q | global | :help v_Q-default |
| x | R | global | Treesitter Search |
| x | S | global | Flash Treesitter |
| x | T | global | Lua callback |
| x | [% | global | <Plug>(MatchitVisualMultiBackward) |
| x | [A | buffer | Prev Parameter End |
| x | [C | buffer | Prev Class End |
| x | [F | buffer | Prev Function End |
| x | [N | global | Select previous sibling node |
| x | [a | buffer | Prev Parameter Start |
| x | [c | buffer | Prev Class Start |
| x | [f | buffer | Prev Function Start |
| x | [i | global | jump to top edge of scope |
| x | [n | global | Select previous node |
| x | \r | buffer | Run Lua |
| x | ]% | global | <Plug>(MatchitVisualMultiForward) |
| x | ]A | buffer | Next Parameter End |
| x | ]C | buffer | Next Class End |
| x | ]F | buffer | Next Function End |
| x | ]N | global | Select next sibling node |
| x | ]a | buffer | Next Parameter Start |
| x | ]c | buffer | Next Class Start |
| x | ]f | buffer | Next Function Start |
| x | ]i | global | jump to bottom edge of scope |
| x | ]n | global | Select next node |
| x | a | global | Around textobject |
| x | a% | global | <Plug>(MatchitVisualTextObject) |
| x | ai | global | full scope |
| x | al | global | Around last textobject |
| x | an | global | Around next textobject |
| x | f | global | Lua callback |
| x | g% | global | <Plug>(MatchitVisualBackward) |
| x | g[ | global | Move to left "around" |
| x | g] | global | Move to right "around" |
| x | gc | global | Toggle comment |
| x | gra | global | vim.lsp.buf.code_action() |
| x | gsa | global | Add Surrounding |
| x | gx | global | Opens filepath or URI under cursor with the system handler (file explorer, web browser, …) |
| x | i | global | Inside textobject |
| x | ih | buffer | GitSigns Select Hunk |
| x | ii | global | inner scope |
| x | il | global | Inside last textobject |
| x | in | global | Inside next textobject |
| x | j | global | v:count == 0 ? 'gj' : 'j' |
| x | k | global | v:count == 0 ? 'gk' : 'k' |
| x | n | global | Next Search Result |
| x | p | global | Paste (keep register) |
| x | s | global | Flash |
| x | t | global | Lua callback |


## Neovim custom configuration and enabled extras

### ~/dotfiles/.config/nvim/lazyvim.json

```json
{
  "extras": [
    "lazyvim.plugins.extras.ai.claudecode",
    "lazyvim.plugins.extras.ai.copilot-chat",
    "lazyvim.plugins.extras.ai.copilot-native",
    "lazyvim.plugins.extras.coding.mini-surround",
    "lazyvim.plugins.extras.dap.core",
    "lazyvim.plugins.extras.dap.nlua",
    "lazyvim.plugins.extras.editor.aerial",
    "lazyvim.plugins.extras.editor.harpoon2",
    "lazyvim.plugins.extras.lang.docker",
    "lazyvim.plugins.extras.lang.json",
    "lazyvim.plugins.extras.lang.markdown",
    "lazyvim.plugins.extras.lang.python",
    "lazyvim.plugins.extras.lang.rust",
    "lazyvim.plugins.extras.lang.sql",
    "lazyvim.plugins.extras.lang.tailwind",
    "lazyvim.plugins.extras.lang.typescript",
    "lazyvim.plugins.extras.lang.yaml",
    "lazyvim.plugins.extras.test.core",
    "lazyvim.plugins.extras.vscode"
  ],
  "install_version": 8,
  "news": {
    "NEWS.md": "11866"
  },
  "version": 8
}
```

### ~/dotfiles/.config/nvim/lazy-lock.json

```json
{
  "CopilotChat.nvim": { "branch": "main", "commit": "2025f92022bef434de0511c5157a19974a9377a4" },
  "LazyVim": { "branch": "main", "commit": "83d90f339defdb109a6ede333865a66ffc7ef6aa" },
  "SchemaStore.nvim": { "branch": "main", "commit": "19936230448bfb3dfd4314070e8bc499ceb55928" },
  "aerial.nvim": { "branch": "master", "commit": "585db11015abccf673dc5bd6502714d5655554be" },
  "blink.cmp": { "branch": "main", "commit": "78336bc89ee5365633bcf754d93df01678b5c08f" },
  "bufferline.nvim": { "branch": "main", "commit": "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3" },
  "catppuccin": { "branch": "main", "commit": "0303a7208dba448c459767486a38a6ec05c4216b" },
  "claudecode.nvim": { "branch": "main", "commit": "102d835c964069c9c5e37abaf05ae4f9c3ee6f00" },
  "conform.nvim": { "branch": "master", "commit": "619363c30309d29ffa631e67c8183f2a72caa373" },
  "crates.nvim": { "branch": "main", "commit": "694357861ec9ebf12475ddcdd04ea45a0923c32d" },
  "dial.nvim": { "branch": "master", "commit": "f2634758455cfa52a8acea6f142dcd6271a1bf57" },
  "flash.nvim": { "branch": "main", "commit": "fcea7ff883235d9024dc41e638f164a450c14ca2" },
  "friendly-snippets": { "branch": "main", "commit": "6cd7280adead7f586db6fccbd15d2cac7e2188b9" },
  "gitsigns.nvim": { "branch": "main", "commit": "dd3f588bacbeb041be6facf1742e42097f62165d" },
  "grug-far.nvim": { "branch": "main", "commit": "5506c2f59dc9ab2ed6c233585412b24d31d51521" },
  "harpoon": { "branch": "harpoon2", "commit": "87b1a3506211538f460786c23f98ec63ad9af4e5" },
  "lazy.nvim": { "branch": "main", "commit": "85c7ff3711b730b4030d03144f6db6375044ae82" },
  "lazydev.nvim": { "branch": "main", "commit": "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d" },
  "lualine.nvim": { "branch": "master", "commit": "221ce6b2d999187044529f49da6554a92f740a96" },
  "markdown-preview.nvim": { "branch": "master", "commit": "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee" },
  "mason-lspconfig.nvim": { "branch": "main", "commit": "0a695750d747db1e7e70bcf0267ef8951c95fc83" },
  "mason-nvim-dap.nvim": { "branch": "main", "commit": "9a10e096703966335bd5c46c8c875d5b0690dade" },
  "mason.nvim": { "branch": "main", "commit": "16ba83bfc8a25f52bb545134f5bee082b195c460" },
  "mini.ai": { "branch": "main", "commit": "deacc8e9cf05df0297e3b14a08c2f8a415045c6f" },
  "mini.icons": { "branch": "main", "commit": "520995f1d75da0e4cc901ee95080b1ff2bc46b94" },
  "mini.nvim": { "branch": "main", "commit": "232ceeb14f7f7e849056309b85cb2fed712db46f" },
  "mini.pairs": { "branch": "main", "commit": "30cf2f01c4aaa2033db67376b9924fa2442c05d6" },
  "mini.surround": { "branch": "main", "commit": "d12d8e6ea8e4d9d3e6fb0e3ff11c84fcce2299ac" },
  "neo-tree.nvim": { "branch": "main", "commit": "b83de592f2a8bdd749a00668a8253878cd801f15" },
  "neotest": { "branch": "master", "commit": "ad991822b7076b1d940b33a9d6d0d30416d5df81" },
  "neotest-python": { "branch": "master", "commit": "e6df4f1892f6137f58135917db24d1655937d831" },
  "noice.nvim": { "branch": "main", "commit": "7bfd942445fb63089b59f97ca487d605e715f155" },
  "nui.nvim": { "branch": "main", "commit": "de740991c12411b663994b2860f1a4fd0937c130" },
  "nvim-dap": { "branch": "master", "commit": "531771530d4f82ad2d21e436e3cc052d68d7aebb" },
  "nvim-dap-python": { "branch": "master", "commit": "1808458eba2b18f178f990e01376941a42c7f93b" },
  "nvim-dap-ui": { "branch": "master", "commit": "1a66cabaa4a4da0be107d5eda6d57242f0fe7e49" },
  "nvim-dap-virtual-text": { "branch": "master", "commit": "fbdb48c2ed45f4a8293d0d483f7730d24467ccb6" },
  "nvim-lint": { "branch": "master", "commit": "d48f3a76189d03b2239f6df1b2f7e3fa8353743b" },
  "nvim-lspconfig": { "branch": "master", "commit": "9573948c38bfabeec353ae7dd7d3ffec4c506a6b" },
  "nvim-nio": { "branch": "master", "commit": "21f5324bfac14e22ba26553caf69ec76ae8a7662" },
  "nvim-treesitter": { "branch": "main", "commit": "4916d6592ede8c07973490d9322f187e07dfefac" },
  "nvim-treesitter-textobjects": { "branch": "main", "commit": "851e865342e5a4cb1ae23d31caf6e991e1c99f1e" },
  "nvim-ts-autotag": { "branch": "main", "commit": "88c1453db4ba7dd24131086fe51fdf74e587d275" },
  "one-small-step-for-vimkind": { "branch": "main", "commit": "1af6ffb9b5229a856e8090fa2f690e0931a5aace" },
  "persistence.nvim": { "branch": "main", "commit": "b20b2a7887bd39c1a356980b45e03250f3dce49c" },
  "plenary.nvim": { "branch": "master", "commit": "74b06c6c75e4eeb3108ec01852001636d85a932b" },
  "render-markdown.nvim": { "branch": "main", "commit": "5adf0895310c1904e5abfaad40a2baad7fe44a07" },
  "rustaceanvim": { "branch": "main", "commit": "8727e34809a7448b10ebc660c1425c3e808a0004" },
  "snacks.nvim": { "branch": "main", "commit": "882c996cf28183f4d63640de0b4c02ec886d01f2" },
  "todo-comments.nvim": { "branch": "main", "commit": "31e3c38ce9b29781e4422fc0322eb0a21f4e8668" },
  "tokyonight.nvim": { "branch": "main", "commit": "cdc07ac78467a233fd62c493de29a17e0cf2b2b6" },
  "trouble.nvim": { "branch": "main", "commit": "bd67efe408d4816e25e8491cc5ad4088e708a69a" },
  "ts-comments.nvim": { "branch": "main", "commit": "123a9fb12e7229342f807ec9e6de478b1102b041" },
  "undotree": { "branch": "master", "commit": "6fa6b57cda8459e1e4b2ca34df702f55242f4e4d" },
  "venv-selector.nvim": { "branch": "main", "commit": "cc4bb3975de8835291f9bb45889e96c6b2795fc4" },
  "vim-dadbod": { "branch": "master", "commit": "6d1d41da4873a445c5605f2005ad2c68c99d8770" },
  "vim-dadbod-completion": { "branch": "master", "commit": "a8dac0b3cf6132c80dc9b18bef36d4cf7a9e1fe6" },
  "vim-dadbod-ui": { "branch": "master", "commit": "07e92e22114cc5b1ba4938d99897d85b58e20475" },
  "vim-fugitive": { "branch": "master", "commit": "3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0" },
  "vim-illuminate": { "branch": "master", "commit": "0d1e93684da00ab7c057410fecfc24f434698898" },
  "vim-tmux-navigator": { "branch": "master", "commit": "e41c431a0c7b7388ae7ba341f01a0d217eb3a432" },
  "which-key.nvim": { "branch": "main", "commit": "3aab2147e74890957785941f0c1ad87d0a44c15a" }
}
```

### ~/dotfiles/.config/nvim/lua/config/keymaps.lua

```lua
-- KEYMAP GRAMMAR
-- <leader>f  → Find (files, grep, recent, buffers)
-- <leader>g  → Git (lazygit, blame, diff, hunks)
-- <leader>c  → Code (LSP: actions, rename, format)
-- <leader>d  → Debug (DAP: breakpoints, run, step)
-- <leader>t  → Test (neotest: nearest, file, all)
-- <leader>x  → Diagnostics (trouble, quickfix)
-- <leader>h / H → Harpoon menu / add; <leader>gh → Git hunks
-- <leader>u  → UI Toggles
-- <leader>w  → Windows
-- <leader>b  → Buffers
-- <leader>q  → Quit/Session
-- <M-1-4>    → Harpoon fast jump (Alt+number)
-- ][ prefixes → Next/prev: buffer, hunk, diagnostic, quickfix

local map = vim.keymap.set

-- ─── Insert mode ─────────────────────────────────────────────────────────────
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("c", "<C-a>", "<Home>", { desc = "Line start" })
map("c", "<C-e>", "<End>", { desc = "Line end" })

-- ─── Navigation ──────────────────────────────────────────────────────────────
-- Center cursor on large jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "n", "nzzzv", { desc = "Next result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev result (centered)" })
map("n", "G", "Gzz", { desc = "End of file (centered)" })

-- Consistent up/down on wrapped lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Keep cursor when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- ─── Search ──────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ─── Editing ─────────────────────────────────────────────────────────────────
-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Paste without overwriting register
map("x", "p", '"_dP', { desc = "Paste (keep register)" })

-- Delete to void register
map({ "n", "v" }, "<leader>D", '"_d', { desc = "Delete to void" })

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- Rename word under cursor globally in file
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename word in file" })

-- Make current file executable
map("n", "<leader>cx", function()
  local path = vim.api.nvim_buf_get_name(0)
  local stat = vim.uv.fs_stat(path)
  if not stat or stat.type ~= "file" then
    vim.notify("Save a file before making it executable", vim.log.levels.WARN)
    return
  end
  local ok, err = vim.uv.fs_chmod(path, bit.bor(stat.mode, 73))
  vim.notify(ok and "File is executable" or tostring(err), ok and vim.log.levels.INFO or vim.log.levels.ERROR)
end, { desc = "Make file executable" })

-- ─── Harpoon (extends LazyVim harpoon2 extra defaults) ───────────────────────
-- LazyVim extra sets: <leader>h (menu), <leader>H (add), <leader>1-9 (jump)
-- These Alt shortcuts give instant 1-key jumping:
-- Harpoon/undotree/fugitive are disabled in VS Code by the vscode extra,
-- so only define their keymaps in real Neovim.
if not vim.g.vscode then
  map("n", "<M-1>", function() require("harpoon"):list():select(1) end, { desc = "Harpoon mark 1" })
  map("n", "<M-2>", function() require("harpoon"):list():select(2) end, { desc = "Harpoon mark 2" })
  map("n", "<M-3>", function() require("harpoon"):list():select(3) end, { desc = "Harpoon mark 3" })
  map("n", "<M-4>", function() require("harpoon"):list():select(4) end, { desc = "Harpoon mark 4" })
  map("n", "[m", function() require("harpoon"):list():prev() end, { desc = "Harpoon prev" })
  map("n", "]m", function() require("harpoon"):list():next() end, { desc = "Harpoon next" })
end

-- ─── Quickfix / Location list ────────────────────────────────────────────────
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
map("n", "]Q", "<cmd>clast<CR>zz", { desc = "Last quickfix" })
map("n", "[Q", "<cmd>cfirst<CR>zz", { desc = "First quickfix" })
map("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next loclist" })
map("n", "[l", "<cmd>lprev<CR>zz", { desc = "Prev loclist" })

-- ─── Windows ─────────────────────────────────────────────────────────────────
-- LazyVim already sets <leader>| and <leader>- for splits
-- These complement with resize
map("n", "<leader>we", "<C-w>=", { desc = "Equalize splits" })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Grow split up" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Shrink split down" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Grow split right" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Shrink split left" })

-- ─── Fold ────────────────────────────────────────────────────────────────────
-- Use ufo if it's installed, otherwise fall back to the built-in fold commands.
map("n", "zR", function()
  local ok, ufo = pcall(require, "ufo")
  if ok then ufo.openAllFolds() else vim.cmd("normal! zR") end
end, { desc = "Open all folds" })
map("n", "zM", function()
  local ok, ufo = pcall(require, "ufo")
  if ok then ufo.closeAllFolds() else vim.cmd("normal! zM") end
end, { desc = "Close all folds" })

if not vim.g.vscode then
  require("config.keymap_catalog").setup()
end
```

### ~/dotfiles/.config/nvim/lua/plugins/dap.lua

```lua
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
```

### ~/dotfiles/.config/nvim/lua/plugins/editor.lua

```lua
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
      { "[s", "<cmd>AerialPrev<CR>", desc = "Aerial prev symbol" },
      { "]s", "<cmd>AerialNext<CR>", desc = "Aerial next symbol" },
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
    event = "LazyFile",
    config = function(_, opts) require("illuminate").configure(opts) end,
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
```

### ~/dotfiles/.config/nvim/lua/plugins/git.lua

```lua
return {
  -- Fugitive: the definitive git plugin for interactive staging, blame, history
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "Gclog" },
    keys = {
      { "<leader>gF", "<cmd>Git<CR>", desc = "Fugitive (interactive stage)" },
      { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
      { "<leader>gL", "<cmd>0Gclog<CR>", desc = "File git history" },
      { "<leader>gW", "<cmd>Gwrite<CR>", desc = "Git stage file (write)" },
      { "<leader>gO", "<cmd>Gread<CR>", desc = "Git checkout file (read)" },
    },
  },

  -- Gitsigns: enhance LazyVim defaults with more features
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      },
    },
  },
}
```

### ~/dotfiles/.config/nvim/lua/plugins/neo-tree.lua

```lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Show hidden files by default
        hide_dotfiles = false,
        hide_gitignored = true,
      },
      follow_current_file = {
        enabled = true, -- Focus the active file in the tree
      },
    },
  },
}
```

### ~/dotfiles/.config/nvim/lua/plugins/render-markdown.lua

```lua
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- optional
    opts = {},
    ft = { "markdown" },
  },
}
```

### ~/dotfiles/.config/nvim/lua/plugins/snacks.lua

```lua
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
      { [[<C-\>]], function() Snacks.terminal.toggle() end, desc = "Toggle terminal", mode = { "n", "t" } },
      { "<leader>ft", function() Snacks.terminal() end, desc = "Float terminal" },

      -- Zen mode
      { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
      { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom buffer" },

      -- Scratch buffer
      { "<leader>.", function() Snacks.scratch() end, desc = "Scratch buffer" },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select scratch" },

      -- Notifications

      -- Git (lazygit via snacks — LazyVim sets <leader>gg already)
      { "<leader>gl", function() Snacks.lazygit.log_file() end, desc = "Lazygit file log" },
    },
  },
}
```

### ~/dotfiles/.config/nvim/lua/plugins/theme.lua

```lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true, -- Optional: matches your terminal transparency
      integrations = {
        telescope = true,
        treesitter = true,
        notify = true,
        mini = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- "glass" (lua/themeforge, generated by ~/dotfiles/themeforge) follows the active HyDE theme + mode.
      -- Catppuccin above stays installed as a fallback: set this back to "catppuccin" to revert.
      colorscheme = "glass",
    },
  },
}
```

### ~/dotfiles/.config/nvim/lua/plugins/tmux-navigator.lua

```lua
if vim.g.vscode then return {} end

return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  init = function() vim.g.tmux_navigator_no_mappings = 1 end,
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate left (Neovim/tmux)" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate down (Neovim/tmux)" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate up (Neovim/tmux)" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate right (Neovim/tmux)" },
    { "<leader>wp", "<cmd>TmuxNavigatePrevious<cr>", desc = "Previous tmux pane" },
  },
}
```

## Neovim context-specific installed plugin mappings

These definitions apply when the named plugin, filetype, LSP, picker, completion popup or plugin window is active. Source extracts retain line numbers and nearby context; definitions may include disabled alternatives and are not all globally active shortcuts.

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/autocmds.lua

```lua
...
73:   },
74:   callback = function(event)
75:     vim.bo[event.buf].buflisted = false
76:     vim.schedule(function()
77:       vim.keymap.set("n", "q", function()
78:         vim.cmd("close")
79:         pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
80:       end, {
81:         buffer = event.buf,
82:         silent = true,
83:         desc = "Quit buffer",
84:       })
85:     end)
86:   end,
87: })
88: 
89: -- make it easier to close man-files when opened inline
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/init.lua

```lua
...
15:   end,
16:   -- load the default settings
17:   defaults = {
18:     autocmds = true, -- lazyvim.config.autocmds
19:     keymaps = true, -- lazyvim.config.keymaps
20:     -- lazyvim.config.options can't be configured here since that's loaded before lazyvim setup
21:     -- if you want to disable loading options, add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua
22:   },
23:   news = {
24:     -- When enabled, NEWS.md will be shown when changed.
25:     -- This only contains big new features and breaking changes.
26:     lazyvim = true,
27:     -- Same but for Neovim's news.txt
28:     neovim = false,
29:   },
30:   -- icons used by other plugins
31:   -- stylua: ignore
32:   icons = {
33:     misc = {
...
35:     },
36:     ft = {
37:       octo = " ",
38:       gh = " ",
39:       ["markdown.gh"] = " ",
40:     },
41:     dap = {
42:       Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
43:       Breakpoint          = " ",
44:       BreakpointCondition = " ",
45:       BreakpointRejected  = { " ", "DiagnosticError" },
46:       LogPoint            = ".>",
47:     },
48:     diagnostics = {
49:       Error = " ",
50:       Warn  = " ",
51:       Hint  = " ",
...
188:     callback = function()
189:       if lazy_autocmds then
190:         M.load("autocmds")
191:       end
192:       M.load("keymaps")
193:       if lazy_clipboard ~= nil then
194:         vim.opt.clipboard = lazy_clipboard
195:       end
196: 
197:       LazyVim.format.setup()
198:       LazyVim.news.setup()
199:       LazyVim.root.setup()
200: 
201:       vim.api.nvim_create_user_command("LazyExtras", function()
202:         LazyVim.extras.show()
203:       end, { desc = "Manage LazyVim extras" })
204: 
...
281:   ---@diagnostic disable-next-line: return-type-mismatch
282:   return type(M.kind_filter) == "table" and type(M.kind_filter.default) == "table" and M.kind_filter.default or nil
283: end
284: 
285: ---@param name "autocmds" | "options" | "keymaps"
286: function M.load(name)
287:   local function _load(mod)
288:     if require("lazy.core.cache").find(mod)[1] then
289:       LazyVim.try(function()
290:         require(mod)
291:       end, { msg = "Failed loading " .. mod })
292:     end
293:   end
294:   local pattern = "LazyVim" .. name:sub(1, 1):upper() .. name:sub(2)
295:   -- always load lazyvim, then user file
296:   if M.defaults[name] or name == "options" then
297:     _load("lazyvim.config." .. name)
...
317:   if plugin then
318:     vim.opt.rtp:append(plugin.dir)
319:   end
320: 
321:   package.preload["lazyvim.plugins.lsp.format"] = function()
322:     LazyVim.deprecate([[require("lazyvim.plugins.lsp.format")]], [[LazyVim.format]])
323:     return LazyVim.format
324:   end
325: 
326:   -- delay notifications till vim.notify was replaced or after 500ms
327:   LazyVim.lazy_notify()
328: 
329:   -- load options here, before lazy init while sourcing plugin modules
330:   -- this is needed to make sure options will be correctly applied
331:   -- after installing missing plugins
332:   M.load("options")
333: 
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua

```lua
...
1: -- This file is automatically loaded by lazyvim.config.init
2: 
3: -- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
4: -- use `vim.keymap.set` instead
5: local map = LazyVim.safe_keymap_set
6: 
7: -- better up/down
8: map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
9: map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
10: map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
11: map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
12: 
13: -- Move to window using the <ctrl> hjkl keys
14: map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
15: map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
16: map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
17: map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
18: 
19: -- Resize window using <ctrl> arrow keys
20: map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
21: map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
22: map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
23: map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
24: 
25: -- Move Lines
26: map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
27: map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
28: map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
29: map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
30: map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
31: map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
32: 
33: -- buffers
34: map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
35: map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
36: map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
37: map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
38: map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
39: map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
40: map("n", "<leader>bd", function()
41:   Snacks.bufdelete()
42: end, { desc = "Delete Buffer" })
43: map("n", "<leader>bo", function()
44:   Snacks.bufdelete.other()
45: end, { desc = "Delete Other Buffers" })
46: map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
47: 
48: -- Clear search and stop snippet on escape
49: map({ "i", "n", "s" }, "<esc>", function()
50:   vim.cmd("noh")
51:   LazyVim.cmp.actions.snippet_stop()
52:   return "<esc>"
53: end, { expr = true, desc = "Escape and Clear hlsearch" })
54: 
55: -- Clear search, diff update and redraw
56: -- taken from runtime/lua/_editor.lua
57: map(
58:   "n",
59:   "<leader>ur",
60:   "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
61:   { desc = "Redraw / Clear hlsearch / Diff Update" }
62: )
63: 
64: -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
65: map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
66: map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
67: map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
68: map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
69: map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
70: map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
71: 
72: -- Add undo break-points
...
74: map("i", ".", ".<c-g>u")
75: map("i", ";", ";<c-g>u")
76: 
77: -- save file
78: map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
79: 
80: --keywordprg
81: map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })
82: 
83: -- better indenting
84: map("x", "<", "<gv")
85: map("x", ">", ">gv")
86: 
87: -- commenting
88: map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
89: map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
90: 
91: -- lazy
92: map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
93: 
94: -- new file
95: map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
96: 
97: -- location list
98: map("n", "<leader>xl", function()
99:   local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
100:   if not success and err then
101:     vim.notify(err, vim.log.levels.ERROR)
102:   end
103: end, { desc = "Location List" })
104: 
105: -- quickfix list
106: map("n", "<leader>xq", function()
107:   local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
108:   if not success and err then
109:     vim.notify(err, vim.log.levels.ERROR)
110:   end
111: end, { desc = "Quickfix List" })
112: 
113: map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
114: map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
115: 
116: -- formatting
117: map({ "n", "x" }, "<leader>cf", function()
118:   LazyVim.format({ force = true })
119: end, { desc = "Format" })
120: 
121: -- diagnostic
122: local diagnostic_goto = function(next, severity)
123:   return function()
124:     vim.diagnostic.jump({
125:       count = (next and 1 or -1) * vim.v.count1,
126:       severity = severity and vim.diagnostic.severity[severity] or nil,
127:       float = true,
128:     })
129:   end
130: end
131: map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
132: map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
133: map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
134: map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
135: map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
136: map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
137: map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
138: 
139: -- stylua: ignore start
140: 
141: -- toggle options
142: LazyVim.format.snacks_toggle():map("<leader>uf")
143: LazyVim.format.snacks_toggle(true):map("<leader>uF")
144: Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
145: Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
146: Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
147: Snacks.toggle.diagnostics():map("<leader>ud")
148: Snacks.toggle.line_number():map("<leader>ul")
149: Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
150: Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
151: Snacks.toggle.treesitter():map("<leader>uT")
152: Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background" }):map("<leader>ub")
153: Snacks.toggle.dim():map("<leader>uD")
154: Snacks.toggle.animate():map("<leader>ua")
155: Snacks.toggle.indent():map("<leader>ug")
156: Snacks.toggle.scroll():map("<leader>uS")
157: Snacks.toggle.profiler():map("<leader>dpp")
158: Snacks.toggle.profiler_highlights():map("<leader>dph")
159: 
160: if vim.lsp.inlay_hint then
161:   Snacks.toggle.inlay_hints():map("<leader>uh")
162: end
163: 
164: -- lazygit
165: if vim.fn.executable("lazygit") == 1 then
166:   map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
167:   map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
168: end
169: 
170: map("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
171: map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
172: map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
173: map("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" })
174: map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
175: map({"n", "x" }, "<leader>gY", function()
176:   Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
177: end, { desc = "Git Browse (copy)" })
178: 
179: -- quit
180: map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
181: 
182: -- highlights under cursor
183: map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
184: map("n", "<leader>uI", function() vim.treesitter.inspect_tree() vim.api.nvim_input("I") end, { desc = "Inspect Tree" })
185: 
186: -- LazyVim Changelog
187: map("n", "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })
188: 
189: -- floating terminal
190: map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
191: map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
192: map({"n","t"}, "<c-/>",function() Snacks.terminal.focus(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
193: map({"n","t"}, "<c-_>",function() Snacks.terminal.focus(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })
194: 
195: -- windows
196: map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
197: map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
198: map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
199: Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
200: Snacks.toggle.zen():map("<leader>uz")
201: 
202: -- tabs
203: map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
204: map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
205: map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
206: map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
207: map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
208: map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
209: map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
210: 
211: -- lua
212: map({"n", "x"}, "<localleader>r", function() Snacks.debug.run() end, { desc = "Run Lua", ft = "lua" })
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/health.lua

```lua
...
36:   end
37: 
38:   start("LazyVim nvim-treesitter")
39:   local tsok, health = LazyVim.treesitter.check()
40:   local keys = vim.tbl_keys(health) ---@type string[]
41:   table.sort(keys)
42:   for _, k in pairs(keys) do
43:     (health[k] and ok or error)(("`%s` is %s"):format(k, health[k] and "installed" or "not installed"))
44:   end
45:   if not tsok then
46:     info(
47:       "See the requirements at [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)"
48:     )
49:     info("Run `:checkhealth nvim-treesitter` for more information.")
50:     if vim.fn.has("win32") == 1 and not health["C compiler"] then
51:       info("Install a C compiler with `winget install --id=BrechtSanders.WinLibs.POSIX.UCRT -e`")
52:     end
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/editor.lua

```lua
...
4:   {
5:     "MagicDuck/grug-far.nvim",
6:     opts = { headerMaxWidth = 80 },
7:     cmd = { "GrugFar", "GrugFarWithin" },
8:     keys = {
9:       {
10:         "<leader>sr",
11:         function()
12:           local grug = require("grug-far")
13:           local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
14:           grug.open({
15:             transient = true,
16:             prefills = {
17:               filesFilter = ext and ext ~= "" and "*." .. ext or nil,
18:             },
19:           })
20:         end,
21:         mode = { "n", "x" },
22:         desc = "Search and Replace",
...
33:     vscode = true,
34:     ---@type Flash.Config
35:     opts = {},
36:     -- stylua: ignore
37:     keys = {
38:       { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
39:       { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
40:       { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
41:       { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
42:       { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
43:       -- Simulate nvim-treesitter incremental selection
44:       { "<c-space>", mode = { "n", "o", "x" },
45:         function()
46:           require("flash").treesitter({
47:             actions = {
48:               ["<c-space>"] = "next",
49:               ["<BS>"] = "prev"
50:             }
51:           }) 
52:         end, desc = "Treesitter Incremental Selection" },
53:     },
54:   },
55: 
56:   -- which-key helps you remember key bindings by showing a popup
57:   -- with the active keybindings of the command you started typing.
58:   {
59:     "folke/which-key.nvim",
60:     event = "VeryLazy",
61:     opts_extend = { "spec" },
...
64:       defaults = {},
65:       spec = {
66:         {
67:           mode = { "n", "x" },
68:           { "<leader><tab>", group = "tabs" },
69:           { "<leader>c", group = "code" },
70:           { "<leader>d", group = "debug" },
71:           { "<leader>dp", group = "profiler" },
72:           { "<leader>f", group = "file/find" },
73:           { "<leader>g", group = "git" },
74:           { "<leader>gh", group = "hunks" },
75:           { "<leader>q", group = "quit/session" },
76:           { "<leader>s", group = "search" },
77:           { "<leader>u", group = "ui" },
78:           { "<leader>x", group = "diagnostics/quickfix" },
79:           { "[", group = "prev" },
80:           { "]", group = "next" },
81:           { "g", group = "goto" },
82:           { "gs", group = "surround" },
83:           { "z", group = "fold" },
84:           {
85:             "<leader>b",
86:             group = "buffer",
87:             expand = function()
88:               return require("which-key.extras").expand.buf()
89:             end,
90:           },
91:           {
92:             "<leader>w",
93:             group = "windows",
94:             proxy = "<c-w>",
95:             expand = function()
96:               return require("which-key.extras").expand.win()
97:             end,
98:           },
99:           -- better descriptions
100:           { "gx", desc = "Open with system app" },
101:         },
102:       },
103:     },
104:     keys = {
105:       {
106:         "<leader>?",
107:         function()
108:           require("which-key").show({ global = false })
109:         end,
110:         desc = "Buffer Keymaps (which-key)",
111:       },
112:       {
113:         "<c-w><space>",
114:         function()
115:           require("which-key").show({ keys = "<c-w>", loop = true })
116:         end,
117:         desc = "Window Hydra Mode (which-key)",
118:       },
119:     },
120:     config = function(_, opts)
121:       local wk = require("which-key")
122:       wk.setup(opts)
123:       if not vim.tbl_isempty(opts.defaults) then
124:         LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
125:         wk.register(opts.defaults)
126:       end
127:     end,
...
152:       on_attach = function(buffer)
153:         local gs = package.loaded.gitsigns
154: 
155:         local function map(mode, l, r, desc)
156:           vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
157:         end
158: 
159:         -- stylua: ignore start
160:         map("n", "]h", function()
161:           if vim.wo.diff then
162:             vim.cmd.normal({ "]c", bang = true })
163:           else
164:             gs.nav_hunk("next")
165:           end
166:         end, "Next Hunk")
167:         map("n", "[h", function()
168:           if vim.wo.diff then
...
172:           end
173:         end, "Prev Hunk")
174:         map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
175:         map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
176:         map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
177:         map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
178:         map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
179:         map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
180:         map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
181:         map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
182:         map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
183:         map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
184:         map("n", "<leader>ghd", gs.diffthis, "Diff This")
185:         map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
186:         map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
187:       end,
188:     },
189:   },
190:   {
191:     "gitsigns.nvim",
192:     opts = function()
193:       Snacks.toggle({
194:         name = "Git Signs",
195:         get = function()
196:           return require("gitsigns.config").config.signcolumn
197:         end,
198:         set = function(state)
199:           require("gitsigns").toggle_signs(state)
200:         end,
201:       }):map("<leader>uG")
202:     end,
203:   },
204: 
205:   -- better diagnostics list and others
206:   {
207:     "folke/trouble.nvim",
208:     cmd = { "Trouble" },
209:     opts = {
210:       modes = {
211:         lsp = {
212:           win = { position = "right" },
213:         },
214:       },
215:     },
216:     keys = {
217:       { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
218:       { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
219:       { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
220:       { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
221:       { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
222:       { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
223:       {
224:         "[q",
225:         function()
226:           if require("trouble").is_open() then
227:             require("trouble").prev({ skip_groups = true, jump = true })
228:           else
229:             local ok, err = pcall(vim.cmd.cprev)
230:             if not ok then
231:               vim.notify(err, vim.log.levels.ERROR)
232:             end
233:           end
234:         end,
...
258:     cmd = { "TodoTrouble", "TodoTelescope" },
259:     event = "LazyFile",
260:     opts = {},
261:     -- stylua: ignore
262:     keys = {
263:       { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
264:       { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
265:       { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
266:       { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
267:       { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
268:       { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
269:     },
270:   },
271: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ai/avante.lua

```lua
...
11:       selection = {
12:         hint_display = "none",
13:       },
14:       behaviour = {
15:         auto_set_keymaps = false,
16:       },
17:     },
18:     cmd = {
19:       "AvanteAsk",
20:       "AvanteBuild",
21:       "AvanteChat",
22:       "AvanteClear",
23:       "AvanteEdit",
24:       "AvanteFocus",
25:       "AvanteHistory",
26:       "AvanteModels",
27:       "AvanteRefresh",
...
29:       "AvanteStop",
30:       "AvanteSwitchProvider",
31:       "AvanteToggle",
32:     },
33:     keys = {
34:       { "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "Ask Avante" },
35:       { "<leader>ac", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
36:       { "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Edit Avante" },
37:       { "<leader>af", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
38:       { "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante History" },
39:       { "<leader>am", "<cmd>AvanteModels<CR>", desc = "Select Avante Model" },
40:       { "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat" },
41:       { "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider" },
42:       { "<leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante" },
43:       { "<leader>as", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
44:       { "<leader>at", "<cmd>AvanteToggle<CR>", desc = "Toggle Avante" },
45:     },
46:   },
47: 
48:   -- support for image pasting
49:   {
50:     "HakonHarnes/img-clip.nvim",
51:     event = "VeryLazy",
52:     optional = true,
53:     opts = {
54:       -- recommended settings
55:       default = {
56:         embed_image_as_base64 = false,
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ai/claudecode.lua

```lua
...
1: return {
2:   "coder/claudecode.nvim",
3:   opts = {},
4:   keys = {
5:     { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
6:     { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
7:     { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
8:     { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
9:     { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
10:     { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
11:     { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
12:     {
13:       "<leader>as",
14:       "<cmd>ClaudeCodeTreeAdd<cr>",
15:       desc = "Add file",
16:       ft = { "NvimTree", "neo-tree", "oil" },
17:     },
18:     -- Diff management
19:     { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
20:     { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
21:   },
22: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ai/codeium.lua

```lua
...
11:       virtual_text = {
12:         enabled = not vim.g.ai_cmp,
13:         key_bindings = {
14:           accept = false, -- handled by nvim-cmp / blink.cmp
15:           next = "<M-]>",
16:           prev = "<M-[>",
17:         },
18:       },
19:     },
20:   },
21: 
22:   -- add ai_accept action
23:   {
24:     "Exafunction/codeium.nvim",
25:     opts = function()
26:       LazyVim.cmp.actions.ai_accept = function()
27:         if require("codeium.virtual_text").get_current_completion_item() then
28:           LazyVim.create_undo()
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ai/copilot-chat.lua

```lua
...
17:           width = 0.4,
18:         },
19:       }
20:     end,
21:     keys = {
22:       { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
23:       { "<leader>a", "", desc = "+ai", mode = { "n", "x" } },
24:       {
25:         "<leader>aa",
26:         function()
27:           return require("CopilotChat").toggle()
28:         end,
29:         desc = "Toggle (CopilotChat)",
30:         mode = { "n", "x" },
31:       },
32:       {
33:         "<leader>ax",
34:         function()
35:           return require("CopilotChat").reset()
36:         end,
37:         desc = "Clear (CopilotChat)",
38:         mode = { "n", "x" },
39:       },
40:       {
41:         "<leader>aq",
42:         function()
43:           vim.ui.input({
44:             prompt = "Quick Chat: ",
45:           }, function(input)
46:             if input ~= "" then
47:               require("CopilotChat").ask(input)
48:             end
49:           end)
50:         end,
51:         desc = "Quick Chat (CopilotChat)",
52:         mode = { "n", "x" },
53:       },
54:       {
55:         "<leader>ap",
56:         function()
57:           require("CopilotChat").select_prompt()
58:         end,
59:         desc = "Prompt Actions (CopilotChat)",
60:         mode = { "n", "x" },
61:       },
62:     },
63:     config = function(_, opts)
64:       local chat = require("CopilotChat")
65: 
66:       vim.api.nvim_create_autocmd("BufEnter", {
67:         pattern = "copilot-chat",
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ai/copilot-native.lua

```lua
...
26:     opts = {
27:       servers = {
28:         copilot = {
29:           -- stylua: ignore
30:           keys = {
31:             {
32:               "<M-]>",
33:               function() vim.lsp.inline_completion.select({ count = 1 }) end,
34:               desc = "Next Copilot Suggestion",
35:               mode = { "i", "n" },
36:             },
37:             {
38:               "<M-[>",
39:               function() vim.lsp.inline_completion.select({ count = -1 }) end,
40:               desc = "Prev Copilot Suggestion",
41:               mode = { "i", "n" },
42:             },
43:           },
44:         },
45:       },
46:       setup = {
47:         copilot = function()
48:           vim.schedule(function()
49:             vim.lsp.inline_completion.enable()
50:           end)
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ai/copilot.lua

```lua
...
10:       suggestion = {
11:         enabled = not vim.g.ai_cmp,
12:         auto_trigger = true,
13:         hide_during_completion = vim.g.ai_cmp,
14:         keymap = {
15:           accept = false, -- handled by nvim-cmp / blink.cmp
16:           next = "<M-]>",
17:           prev = "<M-[>",
18:         },
19:       },
20:       panel = { enabled = false },
21:       filetypes = {
22:         markdown = true,
23:         help = true,
24:       },
25:     },
26:   },
27: 
28:   -- copilot-language-server
29:   {
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ai/sidekick.lua

```lua
...
72:         end,
73:         set = function(state)
74:           require("sidekick.nes").enable(state)
75:         end,
76:       }):map("<leader>uN")
77:     end,
78:     -- stylua: ignore
79:     keys = {
80:       -- nes is also useful in normal mode
81:       { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
82:       { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
83:       {
84:         "<c-.>",
85:         function() require("sidekick.cli").focus() end,
86:         desc = "Sidekick Focus",
87:         mode = { "n", "t", "i", "x" },
88:       },
89:       {
90:         "<leader>aa",
91:         function() require("sidekick.cli").toggle() end,
92:         desc = "Sidekick Toggle CLI",
93:       },
94:       {
95:         "<leader>as",
96:         function() require("sidekick.cli").select() end,
97:         -- Or to select only installed tools:
98:         -- require("sidekick.cli").select({ filter = { installed = true } })
99:         desc = "Select CLI",
100:       },
101:       {
102:         "<leader>ad",
103:         function() require("sidekick.cli").close() end,
104:         desc = "Detach a CLI Session",
105:       },
106:       {
107:         "<leader>at",
108:         function() require("sidekick.cli").send({ msg = "{this}" }) end,
109:         mode = { "x", "n" },
110:         desc = "Send This",
111:       },
112:       {
113:         "<leader>af",
114:         function() require("sidekick.cli").send({ msg = "{file}" }) end,
115:         desc = "Send File",
116:       },
117:       {
118:         "<leader>av",
119:         function() require("sidekick.cli").send({ msg = "{selection}" }) end,
120:         mode = { "x" },
121:         desc = "Send Visual Selection",
122:       },
123:       {
124:         "<leader>ap",
125:         function() require("sidekick.cli").prompt() end,
126:         mode = { "n", "x" },
127:         desc = "Sidekick Select Prompt",
128:       },
129:     },
130:   },
131: 
132:   {
133:     "folke/snacks.nvim",
134:     optional = true,
135:     opts = {
136:       picker = {
...
140:           end,
141:         },
142:         win = {
143:           input = {
144:             keys = {
145:               ["<a-a>"] = {
146:                 "sidekick_send",
147:                 mode = { "n", "i" },
148:               },
149:             },
150:           },
151:         },
152:       },
153:     },
154:   },
155: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ai/supermaven.lua

```lua
...
6:       "SupermavenUseFree",
7:       "SupermavenUsePro",
8:     },
9:     opts = {
10:       keymaps = {
11:         accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
12:       },
13:       disable_inline_completion = vim.g.ai_cmp,
14:       ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
15:     },
16:   },
17: 
18:   -- add ai_accept action
19:   {
20:     "supermaven-inc/supermaven-nvim",
21:     opts = function()
22:       require("supermaven-nvim.completion_preview").suggestion_group = "SupermavenSuggestion"
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/blink.lua

```lua
...
82:       },
83: 
84:       cmdline = {
85:         enabled = true,
86:         keymap = {
87:           preset = "cmdline",
88:           ["<Right>"] = false,
89:           ["<Left>"] = false,
90:         },
91:         completion = {
92:           list = { selection = { preselect = false } },
93:           menu = {
94:             auto_show = function(ctx)
95:               return vim.fn.getcmdtype() == ":"
96:             end,
97:           },
98:           ghost_text = { enabled = true },
99:         },
100:       },
101: 
102:       keymap = {
103:         preset = "enter",
104:         ["<C-y>"] = { "select_and_accept" },
105:       },
106:     },
107:     ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
108:     config = function(_, opts)
109:       if opts.snippets and opts.snippets.preset == "default" then
110:         opts.snippets.expand = LazyVim.cmp.expand
111:       end
112:       -- setup compat sources
113:       local enabled = opts.sources.default
114:       for _, source in ipairs(opts.sources.compat or {}) do
115:         opts.sources.providers[source] = vim.tbl_deep_extend(
116:           "force",
...
122:         end
123:       end
124: 
125:       -- add ai_accept to <Tab> key
126:       if not opts.keymap["<Tab>"] then
127:         if opts.keymap.preset == "super-tab" then -- super-tab
128:           opts.keymap["<Tab>"] = {
129:             require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
130:             LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
131:             "fallback",
132:           }
133:         else -- other presets
134:           opts.keymap["<Tab>"] = {
135:             LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
136:             "fallback",
137:           }
138:         end
139:       end
140: 
141:       -- Unset custom prop to pass blink.cmp validation
142:       opts.sources.compat = nil
143: 
144:       -- check if we need to override symbol kinds
145:       for _, provider in pairs(opts.sources.providers or {}) do
146:         ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/luasnip.lua

```lua
...
58:       }
59:       table.insert(opts.sources, { name = "luasnip" })
60:     end,
61:     -- stylua: ignore
62:     keys = {
63:       { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
64:       { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
65:     },
66:   },
67: 
68:   -- blink.cmp integration
69:   {
70:     "saghen/blink.cmp",
71:     optional = true,
72:     opts = {
73:       snippets = {
74:         preset = "luasnip",
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/mini-snippets.lua

```lua
...
81:         -- Following the behavior of vim.snippets,
82:         -- the intended usage of <esc> is to be able to temporarily exit into normal mode for quick edits.
83:         --
84:         -- If you'd rather stop the snippet on <esc>, activate the line below in your own config:
85:         -- mappings = { stop = "<esc>" }, -- <c-c> by default, see :h MiniSnippets-session
86: 
87:         expand = {
88:           select = function(snippets, insert)
89:             -- Close completion window on snippet select - vim.ui.select
90:             -- Needed to remove virtual text for fzf-lua and telescope, but not for mini.pick...
91:             local select = expand_select_override or MiniSnippets.default_select
92:             select(snippets, insert)
93:           end,
94:         },
95:       }
96:     end,
97:   },
...
124:       end
125:     end,
126:     -- stylua: ignore
127:     -- counterpart to <tab> defined in cmp.mappings
128:     keys = include_in_completion and { { "<s-tab>", function() jump("prev") end, mode = "i" } } or nil,
129:   },
130: 
131:   -- blink.cmp integration
132:   {
133:     "saghen/blink.cmp",
134:     optional = true,
135:     opts = function(_, opts)
136:       -- Return early
137:       if include_in_completion then
138:         opts.snippets = { preset = "mini_snippets" }
139:         return
140:       end
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/mini-surround.lua

```lua
...
3: -- to select the text inside, change or modify the surrounding characters,
4: -- and more.
5: return {
6:   "nvim-mini/mini.surround",
7:   keys = function(_, keys)
8:     -- Populate the keys based on the user's options
9:     local opts = LazyVim.opts("mini.surround")
10:     local mappings = {
11:       { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "x" } },
12:       { opts.mappings.delete, desc = "Delete Surrounding" },
13:       { opts.mappings.find, desc = "Find Right Surrounding" },
14:       { opts.mappings.find_left, desc = "Find Left Surrounding" },
15:       { opts.mappings.highlight, desc = "Highlight Surrounding" },
16:       { opts.mappings.replace, desc = "Replace Surrounding" },
17:       { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
18:     }
19:     mappings = vim.tbl_filter(function(m)
20:       return m[1] and #m[1] > 0
21:     end, mappings)
22:     return vim.list_extend(mappings, keys)
23:   end,
24:   opts = {
25:     mappings = {
26:       add = "gsa", -- Add surrounding in Normal and Visual modes
27:       delete = "gsd", -- Delete surrounding
28:       find = "gsf", -- Find surrounding (to the right)
29:       find_left = "gsF", -- Find surrounding (to the left)
30:       highlight = "gsh", -- Highlight surrounding
31:       replace = "gsr", -- Replace surrounding
32:       update_n_lines = "gsn", -- Update `n_lines`
33:     },
34:   },
35: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/neogen.lua

```lua
...
1: return {
2:   "danymat/neogen",
3:   dependencies = LazyVim.has("mini.snippets") and { "mini.snippets" } or {},
4:   cmd = "Neogen",
5:   keys = {
6:     {
7:       "<leader>cn",
8:       function()
9:         require("neogen").generate()
10:       end,
11:       desc = "Generate Annotations (Neogen)",
12:     },
13:   },
14:   opts = function(_, opts)
15:     if opts.snippet_engine ~= nil then
16:       return
17:     end
18: 
19:     local map = {
20:       ["LuaSnip"] = "luasnip",
21:       ["mini.snippets"] = "mini",
22:       ["nvim-snippy"] = "snippy",
23:       ["vim-vsnip"] = "vsnip",
24:     }
25: 
26:     for plugin, engine in pairs(map) do
27:       if LazyVim.has(plugin) then
28:         opts.snippet_engine = engine
29:         return
30:       end
31:     end
32: 
33:     if vim.snippet then
34:       opts.snippet_engine = "nvim"
35:     end
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/nvim-cmp.lua

```lua
...
38:           completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
39:         },
40:         preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
41:         mapping = cmp.mapping.preset.insert({
42:           ["<C-b>"] = cmp.mapping.scroll_docs(-4),
43:           ["<C-f>"] = cmp.mapping.scroll_docs(4),
44:           ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
45:           ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
46:           ["<C-Space>"] = cmp.mapping.complete(),
47:           ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
48:           ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
49:           ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
50:           ["<C-CR>"] = function(fallback)
51:             cmp.abort()
52:             fallback()
53:           end,
54:           ["<tab>"] = function(fallback)
55:             return LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
56:           end,
57:         }),
58:         sources = cmp.config.sources({
59:           { name = "lazydev" },
60:           { name = "nvim_lsp" },
61:           { name = "path" },
62:         }, {
63:           { name = "buffer" },
64:         }),
65:         formatting = {
66:           format = function(entry, item)
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/yanky.lua

```lua
...
9:       sync_with_ring = not vim.env.SSH_CONNECTION,
10:     },
11:     highlight = { timer = 150 },
12:   },
13:   keys = {
14:     {
15:       "<leader>p",
16:       function()
17:         if LazyVim.pick.picker.name == "telescope" then
18:           require("telescope").extensions.yank_history.yank_history({})
19:         elseif LazyVim.pick.picker.name == "snacks" then
20:           Snacks.picker.yanky()
21:         else
22:           vim.cmd([[YankyRingHistory]])
23:         end
24:       end,
25:       mode = { "n", "x" },
26:       desc = "Open Yank History",
27:     },
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/dap/core.lua

```lua
...
31:       },
32:     },
33: 
34:     -- stylua: ignore
35:     keys = {
36:       { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
37:       { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
38:       { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
39:       { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
40:       { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
41:       { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
42:       { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
43:       { "<leader>dj", function() require("dap").down() end, desc = "Down" },
44:       { "<leader>dk", function() require("dap").up() end, desc = "Up" },
45:       { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
46:       { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
47:       { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
48:       { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
49:       { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
50:       { "<leader>ds", function() require("dap").session() end, desc = "Session" },
51:       { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
52:       { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
53:     },
54: 
55:     config = function()
56:       -- load mason-nvim-dap here, after all adapters have been setup
57:       if LazyVim.has("mason-nvim-dap.nvim") then
58:         require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
59:       end
60: 
61:       vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
62: 
63:       for name, sign in pairs(LazyVim.config.icons.dap) do
64:         sign = type(sign) == "table" and sign or { sign }
...
81:   {
82:     "rcarriga/nvim-dap-ui",
83:     dependencies = { "nvim-neotest/nvim-nio" },
84:     -- stylua: ignore
85:     keys = {
86:       { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
87:       { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "x"} },
88:     },
89:     opts = {},
90:     config = function(_, opts)
91:       local dap = require("dap")
92:       local dapui = require("dapui")
93:       dapui.setup(opts)
94:       dap.listeners.after.event_initialized["dapui_config"] = function()
95:         dapui.open({})
96:       end
97:       dap.listeners.before.event_terminated["dapui_config"] = function()
98:         dapui.close({})
99:       end
100:       dap.listeners.before.event_exited["dapui_config"] = function()
101:         dapui.close({})
102:       end
103:     end,
104:   },
105: 
106:   -- mason.nvim integration
107:   {
108:     "jay-babu/mason-nvim-dap.nvim",
109:     dependencies = "mason.nvim",
110:     cmd = { "DapInstall", "DapUninstall" },
111:     opts = {
112:       -- Makes a best effort to setup the various debuggers with
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/aerial.lua

```lua
...
41:         },
42:       }
43:       return opts
44:     end,
45:     keys = {
46:       { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
47:     },
48:   },
49: 
50:   {
51:     "folke/trouble.nvim",
52:     optional = true,
53:     keys = {
54:       { "<leader>cs", false },
55:     },
56:   },
57: 
58:   -- Telescope integration
59:   {
60:     "nvim-telescope/telescope.nvim",
61:     optional = true,
62:     opts = function()
63:       LazyVim.on_load("telescope.nvim", function()
64:         require("telescope").load_extension("aerial")
65:       end)
66:     end,
67:     keys = {
68:       {
69:         "<leader>ss",
70:         "<cmd>Telescope aerial<cr>",
71:         desc = "Goto Symbol (Aerial)",
72:       },
73:     },
74:   },
75: 
76:   -- edgy integration
77:   {
78:     "folke/edgy.nvim",
79:     optional = true,
80:     opts = function(_, opts)
81:       local edgy_idx = LazyVim.plugin.extra_idx("ui.edgy")
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/dial.lua

```lua
...
15:   "monaqa/dial.nvim",
16:   recommended = true,
17:   desc = "Increment and decrement numbers, dates, and more",
18:   -- stylua: ignore
19:   keys = {
20:     { "<C-a>", function() return M.dial(true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
21:     { "<C-x>", function() return M.dial(false) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
22:     { "g<C-a>", function() return M.dial(true, true) end, expr = true, desc = "Increment", mode = {"n", "x"} },
23:     { "g<C-x>", function() return M.dial(false, true) end, expr = true, desc = "Decrement", mode = {"n", "x"} },
24:   },
25:   opts = function()
26:     local augend = require("dial.augend")
27: 
28:     local logical_alias = augend.constant.new({
29:       elements = { "&&", "||" },
30:       word = false,
31:       cyclic = true,
32:     })
33: 
34:     local ordinal_numbers = augend.constant.new({
35:       -- elements through which we cycle. When we increment, we go down
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/fzf.lua

```lua
...
48:       local config = fzf.config
49:       local actions = fzf.actions
50: 
51:       -- Quickfix
52:       config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
53:       config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
54:       config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
55:       config.defaults.keymap.fzf["ctrl-x"] = "jump"
56:       config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
57:       config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
58:       config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
59:       config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
60: 
61:       -- Trouble
62:       if LazyVim.has("trouble.nvim") then
63:         config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
64:       end
65: 
66:       -- Toggle root dir / cwd
67:       config.defaults.actions.files["ctrl-r"] = function(_, ctx)
68:         local o = vim.deepcopy(ctx.__call_opts)
69:         o.root = o.root == false
70:         o.cwd = nil
71:         o.buf = ctx.__CTX.bufnr
72:         LazyVim.pick.open(ctx.__INFO.cmd, o)
73:       end
74:       config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
75:       config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")
76: 
77:       local img_previewer ---@type string[]?
78:       for _, v in ipairs({
79:         { cmd = "ueberzug", args = {} },
80:         { cmd = "chafa", args = { "{file}", "--format=symbols" } },
81:         { cmd = "viu", args = { "-b" } },
82:       }) do
83:         if vim.fn.executable(v.cmd) == 1 then
84:           img_previewer = vim.list_extend({ v.cmd }, v.args)
85:           break
86:         end
...
89:       return {
90:         "default-title",
91:         fzf_colors = true,
92:         fzf_opts = {
93:           ["--no-scrollbar"] = true,
94:         },
95:         defaults = {
96:           -- formatter = "path.filename_first",
97:           formatter = "path.dirname_first",
98:         },
99:         previewers = {
100:           builtin = {
101:             extensions = {
102:               ["png"] = img_previewer,
103:               ["jpg"] = img_previewer,
104:               ["jpeg"] = img_previewer,
105:               ["gif"] = img_previewer,
106:               ["webp"] = img_previewer,
107:             },
108:             ueberzug_scaler = "fit_contain",
109:           },
110:         },
111:         -- Custom LazyVim option to configure vim.ui.select
112:         ui_select = function(fzf_opts, items)
113:           return vim.tbl_deep_extend("force", fzf_opts, {
114:             prompt = " ",
115:             winopts = {
116:               title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
117:               title_pos = "center",
118:             },
...
150:         },
151:         files = {
152:           cwd_prompt = false,
153:           actions = {
154:             ["alt-i"] = { actions.toggle_ignore },
155:             ["alt-h"] = { actions.toggle_hidden },
156:           },
157:         },
158:         grep = {
159:           actions = {
160:             ["alt-i"] = { actions.toggle_ignore },
161:             ["alt-h"] = { actions.toggle_hidden },
162:           },
163:         },
164:         lsp = {
165:           symbols = {
166:             symbol_hl = function(s)
167:               return "TroubleIcon" .. s
168:             end,
169:             symbol_fmt = function(s)
170:               return s:lower() .. "\t"
171:             end,
172:             child_prefix = false,
173:           },
...
204:           return vim.ui.select(...)
205:         end
206:       end)
207:     end,
208:     keys = {
209:       { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
210:       { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
211:       {
212:         "<leader>,",
213:         "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
214:         desc = "Switch Buffer",
215:       },
216:       { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
217:       { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
218:       { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
219:       -- find
220:       { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
221:       { "<leader>fB", "<cmd>FzfLua buffers<cr>", desc = "Buffers (all)" },
222:       { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
223:       { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
224:       { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
225:       { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
226:       { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
227:       { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
228:       -- git
229:       { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
230:       { "<leader>gd", "<cmd>FzfLua git_diff<cr>", desc = "Git Diff (files)" },
231:       { "<leader>gl", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
232:       { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
233:       { "<leader>gS", "<cmd>FzfLua git_stash<cr>", desc = "Git Stash" },
234:       -- search
235:       { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
236:       { "<leader>s/", "<cmd>FzfLua search_history<cr>", desc = "Search History" },
237:       { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
238:       { "<leader>sb", "<cmd>FzfLua lines<cr>", desc = "Buffer Lines" },
239:       { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
240:       { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
241:       { "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
242:       { "<leader>sD", "<cmd>FzfLua diagnostics_document<cr>", desc = "Buffer Diagnostics" },
243:       { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
244:       { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
245:       { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
246:       { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
247:       { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
248:       { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
249:       { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
250:       { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
251:       { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
252:       { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
253:       { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
254:       { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
255:       { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
256:       { "<leader>sw", LazyVim.pick("grep_visual"), mode = "x", desc = "Selection (Root Dir)" },
257:       { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "x", desc = "Selection (cwd)" },
258:       { "<leader>uC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
259:       {
260:         "<leader>ss",
261:         function()
262:           require("fzf-lua").lsp_document_symbols({
263:             regex_filter = symbols_filter,
264:           })
265:         end,
266:         desc = "Goto Symbol",
267:       },
268:       {
269:         "<leader>sS",
270:         function()
271:           require("fzf-lua").lsp_live_workspace_symbols({
272:             regex_filter = symbols_filter,
273:           })
274:         end,
275:         desc = "Goto Symbol (Workspace)",
276:       },
277:     },
278:   },
279: 
280:   {
281:     "folke/todo-comments.nvim",
282:     optional = true,
283:     -- stylua: ignore
284:     keys = {
285:       { "<leader>st", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
286:       { "<leader>sT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
287:     },
288:   },
289: 
290:   {
291:     "neovim/nvim-lspconfig",
292:     opts = {
293:       servers = {
294:         -- stylua: ignore
295:         ["*"] = {
296:           keys = {
297:             { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>", desc = "Goto Definition", has = "definition" },
298:             { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>", desc = "References", nowait = true },
299:             { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
300:             { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
301:           }
302:         },
303:       },
304:     },
305:   },
306: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/harpoon2.lua

```lua
...
8:     settings = {
9:       save_on_toggle = true,
10:     },
11:   },
12:   keys = function()
13:     local keys = {
14:       {
15:         "<leader>H",
16:         function()
17:           require("harpoon"):list():add()
18:         end,
19:         desc = "Harpoon File",
20:       },
21:       {
22:         "<leader>h",
23:         function()
24:           local harpoon = require("harpoon")
25:           harpoon.ui:toggle_quick_menu(harpoon:list())
26:         end,
27:         desc = "Harpoon Quick Menu",
28:       },
29:     }
30: 
31:     for i = 1, 9 do
32:       table.insert(keys, {
33:         "<leader>" .. i,
34:         function()
35:           require("harpoon"):list():select(i)
36:         end,
37:         desc = "Harpoon to File " .. i,
38:       })
39:     end
40:     return keys
41:   end,
42: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/illuminate.lua

```lua
...
30:           else
31:             m.pause()
32:           end
33:         end,
34:       }):map("<leader>ux")
35: 
36:       local function map(key, dir, buffer)
37:         vim.keymap.set("n", key, function()
38:           require("illuminate")["goto_" .. dir .. "_reference"](false)
39:         end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
40:       end
41: 
42:       map("]]", "next")
43:       map("[[", "prev")
44: 
45:       -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
46:       vim.api.nvim_create_autocmd("FileType", {
47:         callback = function()
48:           local buffer = vim.api.nvim_get_current_buf()
49:           map("]]", "next", buffer)
50:           map("[[", "prev", buffer)
51:         end,
52:       })
53:     end,
54:     keys = {
55:       { "]]", desc = "Next Reference" },
56:       { "[[", desc = "Prev Reference" },
57:     },
58:   },
59: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/inc-rename.lua

```lua
...
13:   {
14:     "neovim/nvim-lspconfig",
15:     opts = {
16:       servers = {
17:         ["*"] = {
18:           keys = {
19:             {
20:               "<leader>cr",
21:               function()
22:                 local inc_rename = require("inc_rename")
23:                 return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
24:               end,
25:               expr = true,
26:               desc = "Rename (inc-rename.nvim)",
27:               has = "rename",
28:             },
29:           },
30:         },
31:       },
32:     },
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/leap.lua

```lua
...
5:   -- easily jump to any location and enhanced f/t motions for Leap
6:   {
7:     url = "https://codeberg.org/andyg/leap.nvim.git",
8:     enabled = true,
9:     keys = function()
10:       ---@type LazyKeysSpec[]
11:       local ret = {}
12:       for _, key in ipairs({ "f", "F", "t", "T" }) do
13:         ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
14:       end
15:       return ret
16:     end,
17:     opts = { labeled_modes = "nx" },
18:   },
19:   {
20:     url = "https://codeberg.org/andyg/leap.nvim.git",
21:     enabled = true,
22:     keys = {
23:       { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
24:       { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
25:       { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
26:     },
27:     config = function(_, opts)
28:       local leap = require("leap")
29:       for k, v in pairs(opts) do
30:         leap.opts[k] = v
31:       end
32:       leap.add_default_mappings(true)
33:       vim.keymap.del({ "x", "o" }, "x")
34:       vim.keymap.del({ "x", "o" }, "X")
35:     end,
36:   },
37: 
38:   -- rename surround mappings from gs to gz to prevent conflict with leap
39:   {
40:     "nvim-mini/mini.surround",
41:     optional = true,
42:     opts = {
43:       mappings = {
44:         add = "gza", -- Add surrounding in Normal and Visual modes
45:         delete = "gzd", -- Delete surrounding
46:         find = "gzf", -- Find surrounding (to the right)
47:         find_left = "gzF", -- Find surrounding (to the left)
48:         highlight = "gzh", -- Highlight surrounding
49:         replace = "gzr", -- Replace surrounding
50:         update_n_lines = "gzn", -- Update `n_lines`
51:       },
52:     },
53:     keys = {
54:       { "gz", "", desc = "+surround" },
55:     },
56:   },
57: 
58:   -- makes some plugins dot-repeatable like leap
59:   { "tpope/vim-repeat", event = "VeryLazy" },
60: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/mini-diff.lua

```lua
...
8:   -- setup mini.diff
9:   {
10:     "nvim-mini/mini.diff",
11:     event = "VeryLazy",
12:     keys = {
13:       {
14:         "<leader>go",
15:         function()
16:           require("mini.diff").toggle_overlay(0)
17:         end,
18:         desc = "Toggle mini.diff overlay",
19:       },
20:     },
21:     opts = {
22:       view = {
23:         style = "sign",
24:         signs = {
25:           add = "▎",
26:           change = "▎",
...
48:           vim.defer_fn(function()
49:             vim.cmd([[redraw!]])
50:           end, 200)
51:         end,
52:       }):map("<leader>uG")
53:     end,
54:   },
55: 
56:   -- lualine integration
57:   {
58:     "nvim-lualine/lualine.nvim",
59:     opts = function(_, opts)
60:       local x = opts.sections.lualine_x
61:       for _, comp in ipairs(x) do
62:         if comp[1] == "diff" then
63:           comp.source = function()
64:             local summary = vim.b.minidiff_summary
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/mini-files.lua

```lua
...
11:       -- Disabled by default in LazyVim because neo-tree is used for that
12:       use_as_default_explorer = false,
13:     },
14:   },
15:   keys = {
16:     {
17:       "<leader>fm",
18:       function()
19:         require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
20:       end,
21:       desc = "Open mini.files (Directory of Current File)",
22:     },
23:     {
24:       "<leader>fM",
25:       function()
26:         require("mini.files").open(vim.uv.cwd(), true)
27:       end,
28:       desc = "Open mini.files (cwd)",
29:     },
30:   },
31:   config = function(_, opts)
32:     require("mini.files").setup(opts)
33: 
34:     local show_dotfiles = true
35:     local filter_show = function(fs_entry)
36:       return true
...
63:       local desc = "Open in " .. direction .. " split"
64:       if close_on_file then
65:         desc = desc .. " and close"
66:       end
67:       vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
68:     end
69: 
70:     local files_set_cwd = function()
71:       local cur_entry_path = MiniFiles.get_fs_entry().path
72:       local cur_directory = vim.fs.dirname(cur_entry_path)
73:       if cur_directory ~= nil then
74:         vim.fn.chdir(cur_directory)
75:       end
76:     end
77: 
78:     vim.api.nvim_create_autocmd("User", {
79:       pattern = "MiniFilesBufferCreate",
80:       callback = function(args)
81:         local buf_id = args.data.buf_id
82: 
83:         vim.keymap.set(
84:           "n",
85:           opts.mappings and opts.mappings.toggle_hidden or "g.",
86:           toggle_dotfiles,
87:           { buffer = buf_id, desc = "Toggle hidden files" }
88:         )
89: 
90:         vim.keymap.set(
91:           "n",
92:           opts.mappings and opts.mappings.change_cwd or "gc",
93:           files_set_cwd,
94:           { buffer = args.data.buf_id, desc = "Set cwd" }
95:         )
96: 
97:         map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
98:         map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
99:         map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S", "horizontal", true)
100:         map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
101:       end,
102:     })
103: 
104:     vim.api.nvim_create_autocmd("User", {
105:       pattern = "MiniFilesActionRename",
106:       callback = function(event)
107:         Snacks.rename.on_rename_file(event.data.from, event.data.to)
108:       end,
109:     })
110:   end,
111: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/neo-tree.lua

```lua
...
3:   -- file explorer
4:   {
5:     "nvim-neo-tree/neo-tree.nvim",
6:     cmd = "Neotree",
7:     keys = {
8:       {
9:         "<leader>fe",
10:         function()
11:           require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
12:         end,
13:         desc = "Explorer NeoTree (Root Dir)",
14:       },
15:       {
16:         "<leader>fE",
17:         function()
18:           require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
19:         end,
20:         desc = "Explorer NeoTree (cwd)",
21:       },
22:       { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
23:       { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
24:       {
25:         "<leader>ge",
26:         function()
27:           require("neo-tree.command").execute({ source = "git_status", toggle = true })
28:         end,
29:         desc = "Git Explorer",
30:       },
31:       {
32:         "<leader>be",
33:         function()
34:           require("neo-tree.command").execute({ source = "buffers", toggle = true })
35:         end,
36:         desc = "Buffer Explorer",
37:       },
38:     },
39:     deactivate = function()
40:       vim.cmd([[Neotree close]])
41:     end,
42:     init = function()
43:       -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
44:       -- because `cwd` is not set up properly.
...
66:         follow_current_file = { enabled = true },
67:         use_libuv_file_watcher = true,
68:       },
69:       window = {
70:         mappings = {
71:           ["l"] = "open",
72:           ["h"] = "close_node",
73:           ["<space>"] = "none",
74:           ["Y"] = {
75:             function(state)
76:               local node = state.tree:get_node()
77:               local path = node:get_id()
78:               vim.fn.setreg("+", path, "c")
79:             end,
80:             desc = "Copy Path to Clipboard",
81:           },
82:           ["O"] = {
83:             function(state)
84:               require("lazy.util").open(state.tree:get_node().path, { system = true })
85:             end,
86:             desc = "Open with System Application",
87:           },
88:           ["P"] = { "toggle_preview", config = { use_float = false } },
89:         },
90:       },
91:       default_component_configs = {
92:         indent = {
93:           with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
94:           expander_collapsed = "",
95:           expander_expanded = "",
96:           expander_highlight = "NeoTreeExpander",
97:         },
98:         git_status = {
99:           symbols = {
100:             unstaged = "󰄱",
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/outline.lua

```lua
...
1: return {
2:   -- Disable `<leader>cs` keymap so it doesn't conflict with `outline.nvim`
3:   {
4:     "folke/trouble.nvim",
5:     optional = true,
6:     keys = {
7:       { "<leader>cs", false },
8:     },
9:   },
10:   {
11:     "hedyhli/outline.nvim",
12:     keys = { { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
13:     cmd = "Outline",
14:     opts = function()
15:       local defaults = require("outline.config").defaults
16:       local opts = {
17:         symbols = {
18:           icons = {},
19:           filter = vim.deepcopy(LazyVim.config.kind_filter),
20:         },
21:         keymaps = {
22:           up_and_jump = "<up>",
23:           down_and_jump = "<down>",
24:         },
25:       }
26: 
27:       for kind, symbol in pairs(defaults.symbols.icons) do
28:         opts.symbols.icons[kind] = {
29:           icon = LazyVim.config.icons.kinds[kind] or symbol.icon,
30:           hl = symbol.hl,
31:         }
32:       end
33:       return opts
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/overseer.lua

```lua
...
18:     },
19:     opts = {
20:       dap = false,
21:       task_list = {
22:         keymaps = {
23:           ["<C-j>"] = false,
24:           ["<C-k>"] = false,
25:         },
26:       },
27:       form = {
28:         win_opts = {
29:           winblend = 0,
30:         },
31:       },
32:       task_win = {
33:         win_opts = {
34:           winblend = 0,
35:         },
36:       },
37:     },
38:     -- stylua: ignore
39:     keys = {
40:       { "<leader>ow", "<cmd>OverseerToggle!<cr>",    desc = "Task list" },
41:       { "<leader>oo", "<cmd>OverseerRun<cr>",        desc = "Run task" },
42:       { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
43:     },
44:   },
45:   {
46:     "folke/which-key.nvim",
47:     optional = true,
48:     opts = {
49:       spec = {
50:         { "<leader>o", group = "overseer" },
51:       },
52:     },
53:   },
54:   {
55:     "folke/edgy.nvim",
56:     optional = true,
57:     opts = function(_, opts)
58:       opts.right = opts.right or {}
59:       table.insert(opts.right, {
60:         title = "Overseer",
61:         ft = "OverseerList",
62:         open = function()
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/refactoring.lua

```lua
...
9:     local opts = {
10:       fzf_opts = {},
11:       fzf_colors = true,
12:       actions = {
13:         ["default"] = function(selected)
14:           refactoring.refactor(selected[1])
15:         end,
16:       },
17:     }
18:     fzf_lua.fzf_exec(results, opts)
19:   else
20:     refactoring.select_refactor()
21:   end
22: end
23: 
24: return {
25:   {
...
28:     dependencies = {
29:       "nvim-lua/plenary.nvim",
30:       "nvim-treesitter/nvim-treesitter",
31:     },
32:     keys = {
33:       { "<leader>r", "", desc = "+refactor", mode = { "n", "x" } },
34:       {
35:         "<leader>rs",
36:         pick,
37:         mode = { "n", "x" },
38:         desc = "Refactor",
39:       },
40:       {
41:         "<leader>ri",
42:         function()
43:           return require("refactoring").refactor("Inline Variable")
44:         end,
45:         mode = { "n", "x" },
46:         desc = "Inline Variable",
47:         expr = true,
48:       },
49:       {
50:         "<leader>rb",
51:         function()
52:           return require("refactoring").refactor("Extract Block")
53:         end,
54:         mode = { "n", "x" },
55:         desc = "Extract Block",
56:         expr = true,
57:       },
58:       {
59:         "<leader>rf",
60:         function()
61:           return require("refactoring").refactor("Extract Block To File")
62:         end,
63:         mode = { "n", "x" },
64:         desc = "Extract Block To File",
65:         expr = true,
66:       },
67:       {
68:         "<leader>rP",
69:         function()
70:           require("refactoring").debug.printf({ below = false })
71:         end,
72:         desc = "Debug Print",
73:       },
74:       {
75:         "<leader>rp",
76:         function()
77:           require("refactoring").debug.print_var({ normal = true })
78:         end,
79:         mode = { "n", "x" },
80:         desc = "Debug Print Variable",
81:       },
82:       {
83:         "<leader>rc",
84:         function()
85:           require("refactoring").debug.cleanup({})
86:         end,
87:         desc = "Debug Cleanup",
88:       },
89:       {
90:         "<leader>rf",
91:         function()
92:           return require("refactoring").refactor("Extract Function")
93:         end,
94:         mode = { "n", "x" },
95:         desc = "Extract Function",
96:         expr = true,
97:       },
98:       {
99:         "<leader>rF",
100:         function()
101:           return require("refactoring").refactor("Extract Function To File")
102:         end,
103:         mode = { "n", "x" },
104:         desc = "Extract Function To File",
105:         expr = true,
106:       },
107:       {
108:         "<leader>rx",
109:         function()
110:           return require("refactoring").refactor("Extract Variable")
111:         end,
112:         mode = { "n", "x" },
113:         desc = "Extract Variable",
114:         expr = true,
115:       },
116:       {
117:         "<leader>rp",
118:         function()
119:           require("refactoring").debug.print_var()
120:         end,
121:         mode = { "n", "x" },
122:         desc = "Debug Print Variable",
123:       },
124:     },
125:     opts = {
126:       prompt_func_return_type = {
127:         go = false,
128:         java = false,
129:         cpp = false,
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/snacks_explorer.lua

```lua
...
2:   desc = "Snacks File Explorer",
3:   recommended = true,
4:   "folke/snacks.nvim",
5:   opts = { explorer = {} },
6:   keys = {
7:     {
8:       "<leader>fe",
9:       function()
10:         Snacks.explorer({ cwd = LazyVim.root() })
11:       end,
12:       desc = "Explorer Snacks (root dir)",
13:     },
14:     {
15:       "<leader>fE",
16:       function()
17:         Snacks.explorer()
18:       end,
19:       desc = "Explorer Snacks (cwd)",
20:     },
21:     { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
22:     { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
23:   },
24: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/snacks_picker.lua

```lua
...
33:     opts = {
34:       picker = {
35:         win = {
36:           input = {
37:             keys = {
38:               ["<a-c>"] = {
39:                 "toggle_cwd",
40:                 mode = { "n", "i" },
41:               },
42:             },
43:           },
44:         },
45:         actions = {
46:           ---@param p snacks.Picker
47:           toggle_cwd = function(p)
48:             local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
49:             local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
50:             local current = p:cwd()
...
54:         },
55:       },
56:     },
57:     -- stylua: ignore
58:     keys = {
59:       { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
60:       { "<leader>/", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },
61:       { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
62:       { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
63:       { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
64:       -- find
65:       { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
66:       { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
67:       { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
68:       { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
69:       { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
70:       { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
71:       { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
72:       { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
73:       { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
74:       -- git
75:       { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
76:       { "<leader>gD", function() Snacks.picker.git_diff({ base = "origin", group = true }) end, desc = "Git Diff (origin)" },
77:       { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
78:       { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
79:       { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
80:       { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
81:       { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
82:       { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
83:       -- Grep
84:       { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
85:       { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
86:       { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
87:       { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
88:       { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
89:       { "<leader>sw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
90:       { "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
91:       -- search
92:       { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
93:       { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
94:       { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
95:       { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
96:       { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
97:       { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
98:       { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
99:       { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
100:       { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
101:       { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
102:       { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
103:       { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
104:       { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
105:       { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
106:       { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
107:       { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
108:       { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
109:       { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
110:       -- ui
111:       { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
112:     },
113:   },
114:   {
115:     "folke/snacks.nvim",
116:     opts = function(_, opts)
117:       if LazyVim.has("trouble.nvim") then
118:         return vim.tbl_deep_extend("force", opts or {}, {
119:           picker = {
120:             actions = {
121:               trouble_open = function(...)
122:                 return require("trouble.sources.snacks").actions.trouble_open.action(...)
123:               end,
124:             },
125:             win = {
126:               input = {
127:                 keys = {
128:                   ["<a-t>"] = {
129:                     "trouble_open",
130:                     mode = { "n", "i" },
131:                   },
132:                 },
133:               },
134:             },
135:           },
136:         })
137:       end
138:     end,
139:   },
140:   {
141:     "neovim/nvim-lspconfig",
142:     opts = {
143:       servers = {
144:         ["*"] = {
145:           -- stylua: ignore
146:           keys = {
147:             { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
148:             { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
149:             { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
150:             { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
151:             { "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
152:             { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
153:             { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming", has = "callHierarchy/incomingCalls" },
154:             { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing", has = "callHierarchy/outgoingCalls" },
155:           },
156:         },
157:       },
158:     },
159:   },
160:   {
161:     "folke/todo-comments.nvim",
162:     optional = true,
163:     -- stylua: ignore
164:     keys = {
165:       { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
166:       { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
167:     },
168:   },
169:   {
170:     "folke/snacks.nvim",
171:     opts = function(_, opts)
172:       table.insert(opts.dashboard.preset.keys, 3, {
173:         icon = " ",
174:         key = "p",
175:         desc = "Projects",
176:         action = ":lua Snacks.picker.projects()",
177:       })
178:     end,
...
230:         opts = {
231:           picker = {
232:             win = {
233:               input = {
234:                 keys = {
235:                   ["<a-s>"] = { "flash", mode = { "n", "i" } },
236:                   ["s"] = { "flash" },
237:                 },
238:               },
239:             },
240:             actions = {
241:               flash = function(picker)
242:                 require("flash").jump({
243:                   pattern = "^",
244:                   label = { after = { 0, 0 } },
245:                   search = {
246:                     mode = "search",
247:                     exclude = {
248:                       function(win)
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/editor/telescope.lua

```lua
...
38:           })
39:         )
40:       end
41:       ---@diagnostic disable-next-line: inject-field
42:       opts.attach_mappings = function(_, map)
43:         -- opts.desc is overridden by telescope, until it's changed there is this fix
44:         map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd Directory" })
45:         return true
46:       end
47:     end
48: 
49:     require("telescope.builtin")[builtin](opts)
50:   end,
51: }
52: if not LazyVim.pick.register(picker) then
53:   return {}
54: end
...
85:           end)
86:         end,
87:       },
88:     },
89:     keys = {
90:       {
91:         "<leader>,",
92:         "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
93:         desc = "Switch Buffer",
94:       },
95:       { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
96:       { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
97:       { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
98:       -- find
99:       {
100:         "<leader>fb",
101:         "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
102:         desc = "Buffers",
103:       },
104:       { "<leader>fB", "<cmd>Telescope buffers<cr>", desc = "Buffers (all)" },
105:       { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
106:       { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
107:       { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
108:       { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
109:       { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
110:       { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
111:       -- git
112:       { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
113:       { "<leader>gl", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
114:       { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
115:       { "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "Git Stash" },
116:       -- search
117:       { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
118:       { "<leader>s/", "<cmd>Telescope search_history<cr>", desc = "Search History" },
119:       { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
120:       { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Lines" },
121:       { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
122:       { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
123:       { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
124:       { "<leader>sD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer Diagnostics" },
125:       { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
126:       { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
127:       { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
128:       { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
129:       { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
130:       { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
131:       { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
132:       { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
133:       { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
134:       { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
135:       { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
136:       { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
137:       { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
138:       { "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
139:       { "<leader>sw", LazyVim.pick("grep_string"), mode = "x", desc = "Selection (Root Dir)" },
140:       { "<leader>sW", LazyVim.pick("grep_string", { root = false }), mode = "x", desc = "Selection (cwd)" },
141:       { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
142:       {
143:         "<leader>ss",
144:         function()
145:           require("telescope.builtin").lsp_document_symbols({
146:             symbols = LazyVim.config.get_kind_filter(),
147:           })
148:         end,
149:         desc = "Goto Symbol",
150:       },
151:       {
152:         "<leader>sS",
153:         function()
154:           require("telescope.builtin").lsp_dynamic_workspace_symbols({
155:             symbols = LazyVim.config.get_kind_filter(),
156:           })
157:         end,
158:         desc = "Goto Symbol (Workspace)",
159:       },
160:     },
161:     opts = function()
162:       local actions = require("telescope.actions")
163: 
164:       local open_with_trouble = function(...)
...
205:               end
206:             end
207:             return 0
208:           end,
209:           mappings = {
210:             i = {
211:               ["<c-t>"] = open_with_trouble,
212:               ["<a-t>"] = open_with_trouble,
213:               ["<a-i>"] = find_files_no_ignore,
214:               ["<a-h>"] = find_files_with_hidden,
215:               ["<C-Down>"] = actions.cycle_history_next,
216:               ["<C-Up>"] = actions.cycle_history_prev,
217:               ["<C-f>"] = actions.preview_scrolling_down,
218:               ["<C-b>"] = actions.preview_scrolling_up,
219:             },
220:             n = {
221:               ["q"] = actions.close,
222:             },
223:           },
224:         },
225:         pickers = {
226:           find_files = {
227:             find_command = find_command,
228:             hidden = true,
229:           },
230:         },
231:       }
232:     end,
233:   },
...
258:           end,
259:         })
260:       end
261:       opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
262:         mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
263:       })
264:     end,
265:   },
266: 
267:   -- better vim.ui with telescope
268:   {
269:     "stevearc/dressing.nvim",
270:     lazy = true,
271:     init = function()
272:       ---@diagnostic disable-next-line: duplicate-set-field
273:       vim.ui.select = function(...)
274:         require("lazy").load({ plugins = { "dressing.nvim" } })
...
285:   {
286:     "neovim/nvim-lspconfig",
287:     opts = {
288:       servers = {
289:         ["*"] = {
290:           -- stylua: ignore
291:           keys = {
292:             { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
293:             { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
294:             { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
295:             { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
296:           },
297:         },
298:       },
299:     },
300:   },
301: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/formatting/black.lua

```lua
...
18:     "stevearc/conform.nvim",
19:     optional = true,
20:     opts = {
21:       formatters_by_ft = {
22:         ["python"] = { "black" },
23:       },
24:     },
25:   },
26: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/ansible.lua

```lua
...
19:   },
20:   {
21:     "mfussenegger/nvim-ansible",
22:     ft = { "yaml" },
23:     keys = {
24:       {
25:         "<leader>ta",
26:         function()
27:           require("ansible").run()
28:         end,
29:         ft = "yaml.ansible",
30:         desc = "Ansible Run Playbook/Role",
31:         silent = true,
32:       },
33:     },
34:   },
35: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/clangd.lua

```lua
...
35:           declaration = "",
36:           expression = "",
37:           specifier = "",
38:           statement = "",
39:           ["template argument"] = "",
40:         },
41:         kind_icons = {
42:           Compound = "",
43:           Recovery = "",
44:           TranslationUnit = "",
45:           PackExpansion = "",
46:           TemplateTypeParm = "",
47:           TemplateTemplateParm = "",
48:           TemplateParamObject = "",
49:         },
50:       },
51:     },
...
57:     opts = {
58:       servers = {
59:         -- Ensure mason installs the server
60:         clangd = {
61:           keys = {
62:             { "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
63:           },
64:           root_markers = {
65:             "compile_commands.json",
66:             "compile_flags.txt",
67:             "configure.ac", -- AutoTools
68:             "Makefile",
69:             "configure.ac",
70:             "configure.in",
71:             "config.h.in",
72:             "meson.build",
73:             "meson_options.txt",
74:             "build.ninja",
...
117:     },
118:     opts = function()
119:       local dap = require("dap")
120:       if not dap.adapters["codelldb"] then
121:         require("dap").adapters["codelldb"] = {
122:           type = "server",
123:           host = "localhost",
124:           port = "${port}",
125:           executable = {
126:             command = "codelldb",
127:             args = {
128:               "--port",
129:               "${port}",
130:             },
131:           },
132:         }
133:       end
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/clojure.lua

```lua
...
57:       -- print color codes if baleia.nvim is available
58:       local colorize = require("lazyvim.util").has("baleia.nvim")
59: 
60:       if colorize then
61:         vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 0
62:       else
63:         vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 1
64:       end
65: 
66:       -- disable diagnostics in log buffer and colorize it
67:       vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
68:         pattern = "conjure-log-*",
69:         callback = function()
70:           local buffer = vim.api.nvim_get_current_buf()
71:           vim.diagnostic.enable(false, { bufnr = buffer })
72: 
73:           if colorize and vim.g.conjure_baleia then
74:             vim.g.conjure_baleia.automatically(buffer)
75:           end
76: 
77:           vim.keymap.set(
78:             { "n", "x" },
79:             "[c",
80:             "<CMD>call search('^; -\\+$', 'bw')<CR>",
81:             { silent = true, buffer = true, desc = "Jumps to the begining of previous evaluation output." }
82:           )
83:           vim.keymap.set(
84:             { "n", "x" },
85:             "]c",
86:             "<CMD>call search('^; -\\+$', 'w')<CR>",
87:             { silent = true, buffer = true, desc = "Jumps to the begining of next evaluation output." }
88:           )
89:         end,
90:       })
91: 
92:       -- prefer LSP for jump-to-definition and symbol-doc, and use conjure
93:       -- alternatives with <localleader>K and <localleader>gd
94:       vim.g["conjure#mapping#doc_word"] = "K"
95:       vim.g["conjure#mapping#def_word"] = "gd"
96:     end,
97:   },
98: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/dart.lua

```lua
...
32:       "sidlatau/neotest-dart",
33:     },
34:     opts = {
35:       adapters = {
36:         ["neotest-dart"] = {},
37:       },
38:     },
39:   },
40: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/dotnet.lua

```lua
...
41:       servers = {
42:         fsautocomplete = {},
43:         omnisharp = {
44:           handlers = {
45:             ["textDocument/definition"] = function(...)
46:               return require("omnisharp_extended").handler(...)
47:             end,
48:           },
49:           keys = {
50:             {
51:               "gd",
52:               LazyVim.has("telescope.nvim") and function()
53:                 require("omnisharp_extended").telescope_lsp_definitions()
54:               end or function()
55:                 require("omnisharp_extended").lsp_definitions()
56:               end,
57:               desc = "Goto Definition",
58:             },
59:           },
60:           enable_roslyn_analyzers = true,
61:           organize_imports_on_format = true,
...
69:     optional = true,
70:     opts = function()
71:       local dap = require("dap")
72:       if not dap.adapters["netcoredbg"] then
73:         require("dap").adapters["netcoredbg"] = {
74:           type = "executable",
75:           command = vim.fn.exepath("netcoredbg"),
76:           args = { "--interpreter=vscode" },
77:           options = {
78:             detached = false,
79:           },
80:         }
81:       end
82:       for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
83:         if not dap.configurations[lang] then
84:           dap.configurations[lang] = {
85:             {
...
104:       "Nsidorenco/neotest-vstest",
105:     },
106:     opts = {
107:       adapters = {
108:         ["neotest-vstest"] = {
109:           -- Here we can set options for neotest-vstest
110:         },
111:       },
112:     },
113:   },
114: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/elixir.lua

```lua
...
9:     "neovim/nvim-lspconfig",
10:     opts = {
11:       servers = {
12:         elixirls = {
13:           keys = {
14:             {
15:               "<leader>cp",
16:               function()
17:                 local params = vim.lsp.util.make_position_params()
18:                 LazyVim.lsp.execute({
19:                   title = "toPipe",
20:                   filter = "elixirls",
21:                   command = "manipulatePipes:serverid",
22:                   arguments = { "toPipe", params.textDocument.uri, params.position.line, params.position.character },
23:                 })
24:               end,
25:               desc = "To Pipe",
26:             },
27:             {
28:               "<leader>cP",
29:               function()
30:                 local params = vim.lsp.util.make_position_params()
31:                 LazyVim.lsp.execute({
32:                   title = "fromPipe",
33:                   filter = "elixirls",
34:                   command = "manipulatePipes:serverid",
35:                   arguments = { "fromPipe", params.textDocument.uri, params.position.line, params.position.character },
36:                 })
37:               end,
38:               desc = "From Pipe",
39:             },
40:           },
...
57:       "jfpedroza/neotest-elixir",
58:     },
59:     opts = {
60:       adapters = {
61:         ["neotest-elixir"] = {},
62:       },
63:     },
64:   },
65:   {
66:     "nvimtools/none-ls.nvim",
67:     optional = true,
68:     opts = function(_, opts)
69:       local nls = require("null-ls")
70:       opts.sources = vim.list_extend(opts.sources or {}, {
71:         nls.builtins.diagnostics.credo.with({
72:           condition = function(utils)
73:             return utils.root_has_file(".credo.exs")
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/go.lua

```lua
...
143:       "fredrikaverpil/neotest-golang",
144:     },
145:     opts = {
146:       adapters = {
147:         ["neotest-golang"] = {
148:           -- Here we can set options for neotest-golang, e.g.
149:           -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
150:           dap_go_enabled = true, -- requires leoluz/nvim-dap-go
151:         },
152:       },
153:     },
154:   },
155: 
156:   -- Filetype icons
157:   {
158:     "nvim-mini/mini.icons",
159:     opts = {
160:       file = {
161:         [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
162:       },
163:       filetype = {
164:         gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
165:       },
166:     },
167:   },
168: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/haskell.lua

```lua
...
15:   {
16:     "mrcjkb/haskell-tools.nvim",
17:     version = false,
18:     ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
19:     keys = {
20:       {
21:         "<localleader>e",
22:         "<cmd>HlsEvalAll<cr>",
23:         ft = "haskell",
24:         desc = "Evaluate All",
25:       },
26:       {
27:         "<localleader>h",
28:         function()
29:           require("haskell-tools").hoogle.hoogle_signature()
30:         end,
31:         ft = "haskell",
...
73:       { "mrcjkb/neotest-haskell" },
74:     },
75:     opts = {
76:       adapters = {
77:         ["neotest-haskell"] = {},
78:       },
79:     },
80:   },
81: 
82:   {
83:     "mrcjkb/haskell-snippets.nvim",
84:     dependencies = { "L3MON4D3/LuaSnip" },
85:     ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
86:     config = function()
87:       local haskell_snippets = require("haskell-snippets").all
88:       require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
89:     end,
...
100:           LazyVim.on_load("telescope.nvim", function()
101:             require("telescope").load_extension("ht")
102:           end)
103:         end,
104:         keys = {
105:           {
106:             "<localleader>H",
107:             "<cmd>Telescope hoogle<cr>",
108:             ft = "haskell",
109:             desc = "Hoogle",
110:           },
111:         },
112:       },
113:     },
114:   },
115: 
116:   {
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/java.lua

```lua
...
186:         pattern = java_filetypes,
187:         callback = attach_jdtls,
188:       })
189: 
190:       -- Setup keymap and dap after the lsp is fully attached.
191:       -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
192:       -- https://neovim.io/doc/user/lsp.html#LspAttach
193:       vim.api.nvim_create_autocmd("LspAttach", {
194:         callback = function(args)
195:           local client = vim.lsp.get_client_by_id(args.data.client_id)
196:           if client and client.name == "jdtls" then
197:             local wk = require("which-key")
198:             wk.add({
199:               {
200:                 mode = "n",
201:                 buffer = args.buf,
202:                 { "<leader>cx", group = "extract" },
203:                 { "<leader>cxv", require("jdtls").extract_variable_all, desc = "Extract Variable" },
204:                 { "<leader>cxc", require("jdtls").extract_constant, desc = "Extract Constant" },
205:                 { "<leader>cgs", require("jdtls").super_implementation, desc = "Goto Super" },
206:                 { "<leader>cgS", require("jdtls.tests").goto_subjects, desc = "Goto Subjects" },
207:                 { "<leader>co", require("jdtls").organize_imports, desc = "Organize Imports" },
208:               },
209:             })
210:             wk.add({
211:               {
212:                 mode = "x",
213:                 buffer = args.buf,
214:                 { "<leader>cx", group = "extract" },
215:                 {
216:                   "<leader>cxm",
217:                   [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
218:                   desc = "Extract Method",
219:                 },
220:                 {
221:                   "<leader>cxv",
222:                   [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
223:                   desc = "Extract Variable",
224:                 },
225:                 {
226:                   "<leader>cxc",
227:                   [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
228:                   desc = "Extract Constant",
229:                 },
230:               },
231:             })
232: 
233:             if LazyVim.has("mason.nvim") then
234:               local mason_registry = require("mason-registry")
235:               if opts.dap and LazyVim.has("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
236:                 -- custom init for Java debugger
237:                 require("jdtls").setup_dap(opts.dap)
238:                 if opts.dap_main then
...
240:                 end
241: 
242:                 -- Java Test require Java debugger to work
243:                 if opts.test and mason_registry.is_installed("java-test") then
244:                   -- custom keymaps for Java test runner (not yet compatible with neotest)
245:                   wk.add({
246:                     {
247:                       mode = "n",
248:                       buffer = args.buf,
249:                       { "<leader>t", group = "test" },
250:                       {
251:                         "<leader>tt",
252:                         function()
253:                           require("jdtls.dap").test_class({
254:                             config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides or nil,
255:                           })
256:                         end,
257:                         desc = "Run All Test",
258:                       },
259:                       {
260:                         "<leader>tr",
261:                         function()
262:                           require("jdtls.dap").test_nearest_method({
263:                             config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides or nil,
264:                           })
265:                         end,
266:                         desc = "Run Nearest Test",
267:                       },
268:                       { "<leader>tT", require("jdtls.dap").pick_test, desc = "Run Test" },
269:                     },
270:                   })
271:                 end
272:               end
273:             end
274: 
275:             -- User can set additional keymaps in opts.on_attach
276:             if opts.on_attach then
277:               opts.on_attach(args)
278:             end
279:           end
280:         end,
281:       })
282: 
283:       -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
284:       attach_jdtls()
285:     end,
286:   },
287: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/lean.lua

```lua
...
65: 
66:     -- Enable suggested mappings?
67:     --
68:     -- false by default, true to enable
69:     mappings = true,
70: 
71:     -- Infoview support
72:     infoview = {
73:       -- Automatically open an infoview on entering a Lean buffer?
74:       -- Should be a function that will be called anytime a new Lean file
75:       -- is opened. Return true to open an infoview, otherwise false.
76:       -- Setting this to `true` is the same as `function() return true end`,
77:       -- i.e. autoopen for any Lean file, or setting it to `false` is the
78:       -- same as `function() return false end`, i.e. never autoopen.
79:       autoopen = true,
80: 
81:       -- Set infoview windows' starting dimensions.
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/markdown.lua

```lua
...
14:     "stevearc/conform.nvim",
15:     optional = true,
16:     opts = {
17:       formatters = {
18:         ["markdown-toc"] = {
19:           condition = function(_, ctx)
20:             for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
21:               if line:find("<!%-%- toc %-%->") then
22:                 return true
23:               end
24:             end
25:           end,
26:         },
27:         ["markdownlint-cli2"] = {
28:           condition = function(_, ctx)
29:             local diag = vim.tbl_filter(function(d)
30:               return d.source == "markdownlint"
31:             end, vim.diagnostic.get(ctx.buf))
32:             return #diag > 0
33:           end,
34:         },
35:       },
36:       formatters_by_ft = {
37:         ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
38:         ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
39:       },
40:     },
41:   },
42:   {
43:     "mason-org/mason.nvim",
44:     opts = { ensure_installed = { "markdownlint-cli2", "markdown-toc" } },
45:   },
46:   {
47:     "nvimtools/none-ls.nvim",
48:     optional = true,
49:     opts = function(_, opts)
50:       local nls = require("null-ls")
...
78:     build = function()
79:       require("lazy").load({ plugins = { "markdown-preview.nvim" } })
80:       vim.fn["mkdp#util#install"]()
81:     end,
82:     keys = {
83:       {
84:         "<leader>cp",
85:         ft = "markdown",
86:         "<cmd>MarkdownPreviewToggle<cr>",
87:         desc = "Markdown Preview",
88:       },
89:     },
90:     config = function()
91:       vim.cmd([[do FileType]])
92:     end,
93:   },
94: 
95:   {
96:     "MeanderingProgrammer/render-markdown.nvim",
...
114:       Snacks.toggle({
115:         name = "Render Markdown",
116:         get = require("render-markdown").get,
117:         set = require("render-markdown").set,
118:       }):map("<leader>um")
119:     end,
120:   },
121: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/php.lua

```lua
...
93:     },
94:     opts = {
95:       adapters = {
96:         "neotest-pest",
97:         ["neotest-phpunit"] = {
98:           root_ignore_files = { "tests/Pest.php" },
99:         },
100:       },
101:     },
102:   },
103: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/python.lua

```lua
...
68:       "nvim-neotest/neotest-python",
69:     },
70:     opts = {
71:       adapters = {
72:         ["neotest-python"] = {
73:           -- Here you can specify the settings for the adapter, i.e.
74:           -- runner = "pytest",
75:           -- python = ".venv/bin/python",
76:         },
77:       },
78:     },
79:   },
80:   {
81:     "mfussenegger/nvim-dap",
82:     optional = true,
83:     dependencies = {
84:       "mfussenegger/nvim-dap-python",
85:       -- stylua: ignore
86:       keys = {
87:         { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
88:         { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
89:       },
90:       config = function()
91:         require("dap-python").setup("debugpy-adapter")
92:       end,
93:     },
94:   },
95: 
96:   {
97:     "linux-cultist/venv-selector.nvim",
98:     cmd = "VenvSelect",
99:     opts = {
100:       options = {
...
103:       },
104:     },
105:     --  Call config for Python files and load the cached venv automatically
106:     ft = "python",
107:     keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
108:   },
109: 
110:   {
111:     "hrsh7th/nvim-cmp",
112:     optional = true,
113:     opts = function(_, opts)
114:       opts.auto_brackets = opts.auto_brackets or {}
115:       table.insert(opts.auto_brackets, "python")
116:     end,
117:   },
118: 
119:   -- Don't mess up DAP adapters provided by nvim-dap-python
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/r.lua

```lua
...
15:         on_filetype = function()
16:           -- This function will be called at the FileType event
17:           -- of files supported by R.nvim. This is an
18:           -- opportunity to create mappings local to buffers.
19:           vim.keymap.set("n", "<Enter>", "<Plug>RDSendLine", { buffer = true })
20:           vim.keymap.set("x", "<Enter>", "<Plug>RSendSelection", { buffer = true })
21: 
22:           local wk = require("which-key")
23:           wk.add({
24:             buffer = true,
25:             mode = { "n", "x" },
26:             { "<localleader>a", group = "all" },
27:             { "<localleader>b", group = "between marks" },
28:             { "<localleader>c", group = "chunks" },
29:             { "<localleader>f", group = "functions" },
30:             { "<localleader>g", group = "goto" },
31:             { "<localleader>i", group = "install" },
32:             { "<localleader>k", group = "knit" },
...
77:       "shunsambongi/neotest-testthat",
78:     },
79:     opts = {
80:       adapters = {
81:         ["neotest-testthat"] = {},
82:       },
83:     },
84:   },
85: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/ruby.lua

```lua
...
73:       "olimorris/neotest-rspec",
74:     },
75:     opts = {
76:       adapters = {
77:         ["neotest-rspec"] = {
78:           -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
79:           -- rspec_cmd = function()
80:           --   return vim.tbl_flatten({
81:           --     "bundle",
82:           --     "exec",
83:           --     "rspec",
84:           --   })
85:           -- end,
86:         },
87:       },
88:     },
89:   },
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/rust.lua

```lua
...
59:     ft = { "rust" },
60:     opts = {
61:       server = {
62:         on_attach = function(_, bufnr)
63:           vim.keymap.set("n", "<leader>cR", function()
64:             vim.cmd.RustLsp("codeAction")
65:           end, { desc = "Code Action", buffer = bufnr })
66:           vim.keymap.set("n", "<leader>dr", function()
67:             vim.cmd.RustLsp("debuggables")
68:           end, { desc = "Rust Debuggables", buffer = bufnr })
69:         end,
70:         default_settings = {
71:           -- rust-analyzer language server configuration
72:           ["rust-analyzer"] = {
73:             cargo = {
74:               allFeatures = true,
75:               loadOutDirsFromCheck = true,
76:               buildScripts = {
77:                 enable = true,
78:               },
79:             },
80:             -- Add clippy lints for Rust if using rust-analyzer
81:             checkOnSave = diagnostics == "rust-analyzer",
82:             -- Enable diagnostics if using rust-analyzer
83:             diagnostics = {
84:               enable = diagnostics == "rust-analyzer",
...
142:     "nvim-neotest/neotest",
143:     optional = true,
144:     opts = {
145:       adapters = {
146:         ["rustaceanvim.neotest"] = {},
147:       },
148:     },
149:   },
150: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/scala.lua

```lua
...
13:     "scalameta/nvim-metals",
14:     dependencies = {
15:       "nvim-lua/plenary.nvim",
16:     },
17:     keys = {
18:       {
19:         "<leader>me",
20:         function()
21:           require("telescope").extensions.metals.commands()
22:         end,
23:         desc = "Metals commands",
24:       },
25:       {
26:         "<leader>mc",
27:         function()
28:           require("metals").compile_cascade()
29:         end,
30:         desc = "Metals compile cascade",
31:       },
32:       {
33:         "<leader>mh",
34:         function()
35:           require("metals").hover_worksheet()
36:         end,
37:         desc = "Metals hover worksheet",
38:       },
39:     },
40:     ft = { "scala", "sbt", "java" },
41:     opts = function()
42:       local metals_config = require("metals").bare_config()
43: 
44:       metals_config.init_options.statusBarProvider = "off"
45: 
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/sql.lua

```lua
...
76:   {
77:     "kristijanhusak/vim-dadbod-ui",
78:     cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
79:     dependencies = "vim-dadbod",
80:     keys = {
81:       { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
82:     },
83:     init = function()
84:       local data_path = vim.fn.stdpath("data")
85: 
86:       vim.g.db_ui_auto_execute_table_helpers = 1
87:       vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
88:       vim.g.db_ui_show_database_icon = true
89:       vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
90:       vim.g.db_ui_use_nerd_fonts = true
91:       vim.g.db_ui_use_nvim_notify = true
92: 
93:       -- NOTE: The default behavior of auto-execution of queries on save is disabled
94:       -- this is useful when you have a big query that you don't want to run every time
95:       -- you save the file running those queries can crash neovim to run use the
96:       -- default keymap: <leader>S
97:       vim.g.db_ui_execute_on_save = false
98:     end,
99:   },
100: 
101:   -- Treesitter
102:   {
103:     "nvim-treesitter/nvim-treesitter",
104:     optional = true,
105:     opts = { ensure_installed = { "sql" } },
106:   },
107: 
108:   -- Edgy integration
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/terraform.lua

```lua
...
52:       formatters_by_ft = {
53:         hcl = { "packer_fmt" },
54:         terraform = { "terraform_fmt" },
55:         tf = { "terraform_fmt" },
56:         ["terraform-vars"] = { "terraform_fmt" },
57:       },
58:     },
59:   },
60:   {
61:     "nvim-telescope/telescope.nvim",
62:     optional = true,
63:     specs = {
64:       {
65:         "ANGkeith/telescope-terraform-doc.nvim",
66:         ft = { "terraform", "hcl" },
67:         config = function()
68:           LazyVim.on_load("telescope.nvim", function()
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/tex.lua

```lua
...
25:   {
26:     "lervag/vimtex",
27:     lazy = false, -- lazy-loading will disable inverse search
28:     config = function()
29:       vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
30:       vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
31:     end,
32:     keys = {
33:       { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
34:     },
35:   },
36: 
37:   -- Correctly setup lspconfig for LaTeX 🚀
38:   {
39:     "neovim/nvim-lspconfig",
40:     optional = true,
41:     opts = {
42:       servers = {
43:         texlab = {
44:           keys = {
45:             { "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
46:           },
47:         },
48:       },
49:     },
50:   },
51: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/typescript/biome.lua

```lua
...
53:         table.insert(opts.formatters_by_ft[ft], "biome-check")
54:       end
55: 
56:       opts.formatters = opts.formatters or {}
57:       opts.formatters["biome-check"] = {
58:         require_cwd = true,
59:       }
60:     end,
61:   },
62: 
63:   -- none-ls support
64:   {
65:     "nvimtools/none-ls.nvim",
66:     optional = true,
67:     opts = function(_, opts)
68:       local nls = require("null-ls")
69:       opts.sources = opts.sources or {}
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/typescript/init.lua

```lua
...
91: 
92:       local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
93: 
94:       local vscode = require("dap.ext.vscode")
95:       vscode.type_to_filetypes["node"] = js_filetypes
96:       vscode.type_to_filetypes["pwa-node"] = js_filetypes
97: 
98:       for _, language in ipairs(js_filetypes) do
99:         if not dap.configurations[language] then
100:           local runtimeExecutable = nil
101:           if language:find("typescript") then
102:             runtimeExecutable = vim.fn.executable("tsx") == 1 and "tsx" or "ts-node"
103:           end
104:           dap.configurations[language] = {
105:             {
106:               type = "pwa-node",
107:               request = "launch",
108:               name = "Launch file",
...
155:   {
156:     "nvim-mini/mini.icons",
157:     opts = {
158:       file = {
159:         [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
160:         [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
161:         [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
162:         [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
163:         ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
164:         ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
165:         ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
166:         ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
167:         ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
168:       },
169:     },
170:   },
171: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/typescript/vtsls.lua

```lua
...
56:                 variableTypes = { enabled = false },
57:               },
58:             },
59:           },
60:           keys = {
61:             {
62:               "gD",
63:               function()
64:                 local win = vim.api.nvim_get_current_win()
65:                 local params = vim.lsp.util.make_position_params(win, "utf-16")
66:                 LazyVim.lsp.execute({
67:                   command = "typescript.goToSourceDefinition",
68:                   arguments = { params.textDocument.uri, params.position },
69:                   open = true,
70:                 })
71:               end,
72:               desc = "Goto Source Definition",
...
82:               end,
83:               desc = "File References",
84:             },
85:             {
86:               "<leader>cM",
87:               LazyVim.lsp.action["source.addMissingImports.ts"],
88:               desc = "Add missing imports",
89:             },
90:             {
91:               "<leader>cD",
92:               LazyVim.lsp.action["source.fixAll.ts"],
93:               desc = "Fix all diagnostics",
94:             },
95:             {
96:               "<leader>cV",
97:               function()
98:                 LazyVim.lsp.execute({
99:                   title = "Select TypeScript Version",
100:                   filter = "vtsls",
101:                   command = "typescript.selectTypeScriptVersion",
102:                 })
103:               end,
104:               desc = "Select TS workspace version",
105:             },
106:           },
107:         },
108:       },
109:       setup = {
110:         vtsls = function(_, opts)
111:           Snacks.util.lsp.on({ name = "vtsls" }, function(buffer, client)
112:             client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
113:               ---@type string, string, lsp.Range
114:               local action, uri, range = unpack(command.arguments)
115: 
116:               local function move(newf)
117:                 client:request("workspace/executeCommand", {
118:                   command = command.command,
119:                   arguments = { action, uri, range, newf },
120:                 })
121:               end
122: 
123:               local fname = vim.uri_to_fname(uri)
124:               client:request("workspace/executeCommand", {
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/typst.lua

```lua
...
16:     "neovim/nvim-lspconfig",
17:     opts = {
18:       servers = {
19:         tinymist = {
20:           keys = {
21:             {
22:               "<leader>cP",
23:               function()
24:                 local buf_name = vim.api.nvim_buf_get_name(0)
25:                 local file_name = vim.fn.fnamemodify(buf_name, ":t")
26:                 LazyVim.lsp.execute({
27:                   title = "Pin Main",
28:                   filter = "tinymist",
29:                   command = "tinymist.pinMain",
30:                   arguments = { buf_name },
31:                 })
32:                 LazyVim.info("Tinymist: Pinned " .. file_name)
33:               end,
34:               desc = "Pin main file",
...
55: 
56:   {
57:     "chomosuke/typst-preview.nvim",
58:     cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
59:     keys = {
60:       {
61:         "<leader>cp",
62:         ft = "typst",
63:         "<cmd>TypstPreviewToggle<cr>",
64:         desc = "Toggle Typst Preview",
65:       },
66:     },
67:     opts = {
68:       dependencies_bin = {
69:         tinymist = "tinymist",
70:       },
71:     },
72:   },
73: 
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/zig.lua

```lua
...
24:       "lawrence-laz/neotest-zig",
25:     },
26:     opts = {
27:       adapters = {
28:         ["neotest-zig"] = {},
29:       },
30:     },
31:   },
32: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/test/core.lua

```lua
...
11:       -- The adapter will then be automatically loaded with the config.
12:       adapters = {},
13:       -- Example for loading neotest-golang with a custom config
14:       -- adapters = {
15:       --   ["neotest-golang"] = {
16:       --     go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
17:       --     dap_go_enabled = true,
18:       --   },
19:       -- },
20:       status = { virtual_text = true },
21:       output = { open_on_run = true },
22:       quickfix = {
23:         open = function()
24:           if LazyVim.has("trouble.nvim") then
25:             require("trouble").open({ mode = "quickfix", focus = false })
26:           else
27:             vim.cmd("copen")
...
103: 
104:       require("neotest").setup(opts)
105:     end,
106:     -- stylua: ignore
107:     keys = {
108:       {"<leader>t", "", desc = "+test"},
109:       { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to Test (Neotest)" },
110:       { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
111:       { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
112:       { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
113:       { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
114:       { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
115:       { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
116:       { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
117:       { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
118:       { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
119:     },
120:   },
121:   {
122:     "mfussenegger/nvim-dap",
123:     optional = true,
124:     -- stylua: ignore
125:     keys = {
126:       { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
127:     },
128:   },
129: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ui/edgy.lua

```lua
...
2:   -- Create and display predefined window layouts.
3:   {
4:     "folke/edgy.nvim",
5:     event = "VeryLazy",
6:     keys = {
7:       {
8:         "<leader>ue",
9:         function()
10:           require("edgy").toggle()
11:         end,
12:         desc = "Edgy Toggle",
13:       },
14:       -- stylua: ignore
15:       { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
16:     },
17:     opts = function()
18:       local opts = {
19:         bottom = {
20:           {
21:             ft = "toggleterm",
22:             size = { height = 0.4 },
23:             filter = function(buf, win)
24:               return vim.api.nvim_win_get_config(win).relative == ""
25:             end,
26:           },
27:           {
...
50:         },
51:         right = {
52:           { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
53:         },
54:         keys = {
55:           -- increase width
56:           ["<c-Right>"] = function(win)
57:             win:resize("width", 2)
58:           end,
59:           -- decrease width
60:           ["<c-Left>"] = function(win)
61:             win:resize("width", -2)
62:           end,
63:           -- increase height
64:           ["<c-Up>"] = function(win)
65:             win:resize("height", 2)
66:           end,
67:           -- decrease height
68:           ["<c-Down>"] = function(win)
69:             win:resize("height", -2)
70:           end,
71:         },
72:       }
73: 
74:       if LazyVim.has("neo-tree.nvim") then
75:         local pos = {
76:           filesystem = "left",
77:           buffers = "top",
78:           git_status = "right",
79:           document_symbols = "bottom",
80:           diagnostics = "bottom",
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ui/indent-blankline.lua

```lua
...
17:         end,
18:         set = function(state)
19:           require("ibl").setup_buffer(0, { enabled = state })
20:         end,
21:       }):map("<leader>ug")
22: 
23:       return {
24:         indent = {
25:           char = "│",
26:           tab_char = "│",
27:         },
28:         scope = { show_start = false, show_end = false },
29:         exclude = {
30:           filetypes = {
31:             "Trouble",
32:             "alpha",
33:             "dashboard",
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ui/mini-animate.lua

```lua
...
18:       -- don't use animate when scrolling with the mouse
19:       local mouse_scrolled = false
20:       for _, scroll in ipairs({ "Up", "Down" }) do
21:         local key = "<ScrollWheel" .. scroll .. ">"
22:         vim.keymap.set({ "", "i" }, key, function()
23:           mouse_scrolled = true
24:           return key
25:         end, { expr = true })
26:       end
27: 
28:       vim.api.nvim_create_autocmd("FileType", {
29:         pattern = "grug-far",
30:         callback = function()
31:           vim.b.minianimate_disable = true
32:         end,
33:       })
34: 
35:       -- schedule setting the mapping to override the default mapping from `keymaps.lua`
36:       -- seems `keymaps.lua` is the last event to execute on `VeryLazy` and it overwrites it
37:       vim.schedule(function()
38:         Snacks.toggle({
39:           name = "Mini Animate",
40:           get = function()
41:             return not vim.g.minianimate_disable
42:           end,
43:           set = function(state)
44:             vim.g.minianimate_disable = not state
45:           end,
46:         }):map("<leader>ua")
47:       end)
48: 
49:       local animate = require("mini.animate")
50:       return vim.tbl_deep_extend("force", opts, {
51:         resize = {
52:           timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
53:         },
54:         scroll = {
55:           timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
56:           subscroll = animate.gen_subscroll.equal({
57:             predicate = function(total_scroll)
58:               if mouse_scrolled then
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/ui/treesitter-context.lua

```lua
...
13:         else
14:           tsc.disable()
15:         end
16:       end,
17:     }):map("<leader>ut")
18:     return { mode = "cursor", max_lines = 3 }
19:   end,
20: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/util/chezmoi.lua

```lua
...
3:     require("telescope").extensions.chezmoi.find_files()
4:   elseif LazyVim.pick.picker.name == "fzf" then
5:     local fzf_lua = require("fzf-lua")
6:     local actions = {
7:       ["enter"] = function(selected)
8:         fzf_lua.actions.vimcmd_entry("ChezmoiEdit", selected, { cwd = vim.env.HOME })
9:       end,
10:     }
11:     fzf_lua.files({
12:       cmd = "chezmoi managed --include=files,symlinks",
13:       actions = actions,
14:       cwd = vim.env.HOME,
15:       hidden = false,
16:     })
17:   elseif LazyVim.pick.picker.name == "snacks" then
18:     local results = require("chezmoi.commands").list({
19:       args = {
...
53:   {
54:     -- highlighting for chezmoi files template files
55:     "alker0/chezmoi.vim",
56:     init = function()
57:       vim.g["chezmoi#use_tmp_buffer"] = 1
58:       vim.g["chezmoi#source_dir_path"] = vim.env.HOME .. "/.local/share/chezmoi"
59:     end,
60:   },
61:   {
62:     "xvzc/chezmoi.nvim",
63:     cmd = { "ChezmoiEdit" },
64:     keys = {
65:       {
66:         "<leader>sz",
67:         pick_chezmoi,
68:         desc = "Chezmoi",
69:       },
70:     },
71:     opts = {
72:       edit = {
73:         watch = false,
74:         force = false,
75:       },
76:       notification = {
77:         on_open = true,
78:         on_apply = true,
...
142:   {
143:     "nvim-mini/mini.icons",
144:     opts = {
145:       file = {
146:         [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
147:         [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
148:         [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
149:         [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
150:         ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
151:         ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
152:         ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
153:         ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
154:         ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
155:         ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
156:         ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
157:       },
158:     },
159:   },
160: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/util/dot.lua

```lua
...
33: 
34:       vim.filetype.add({
35:         extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
36:         filename = {
37:           ["vifmrc"] = "vim",
38:         },
39:         pattern = {
40:           [".*/waybar/config"] = "jsonc",
41:           [".*/mako/config"] = "dosini",
42:           [".*/kitty/.+%.conf"] = "kitty",
43:           [".*/hypr/.+%.conf"] = "hyprlang",
44:           ["%.env%.[%w_.-]+"] = "sh",
45:         },
46:       })
47:       vim.treesitter.language.register("bash", "kitty")
48: 
49:       add("git_config")
50: 
51:       if have("hypr") then
52:         add("hyprlang")
53:       end
54: 
55:       if have("fish") then
56:         add("fish")
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/util/gh.lua

```lua
...
12:     config = function(_, opts)
13:       require("litee.lib").setup()
14:       require("litee.gh").setup(opts)
15:     end,
16:     keys = {
17:       { "<leader>G", "", desc = "+Github" },
18:       { "<leader>Gc", "", desc = "+Commits" },
19:       { "<leader>Gcc", "<cmd>GHCloseCommit<cr>", desc = "Close" },
20:       { "<leader>Gce", "<cmd>GHExpandCommit<cr>", desc = "Expand" },
21:       { "<leader>Gco", "<cmd>GHOpenToCommit<cr>", desc = "Open To" },
22:       { "<leader>Gcp", "<cmd>GHPopOutCommit<cr>", desc = "Pop Out" },
23:       { "<leader>Gcz", "<cmd>GHCollapseCommit<cr>", desc = "Collapse" },
24:       { "<leader>Gi", "", desc = "+Issues" },
25:       { "<leader>Gip", "<cmd>GHPreviewIssue<cr>", desc = "Preview" },
26:       { "<leader>Gio", "<cmd>GHOpenIssue<cr>", desc = "Open" },
27:       { "<leader>Gl", "", desc = "+Litee" },
28:       { "<leader>Glt", "<cmd>LTPanel<cr>", desc = "Toggle Panel" },
29:       { "<leader>Gp", "", desc = "+Pull Request" },
30:       { "<leader>Gpc", "<cmd>GHClosePR<cr>", desc = "Close" },
31:       { "<leader>Gpd", "<cmd>GHPRDetails<cr>", desc = "Details" },
32:       { "<leader>Gpe", "<cmd>GHExpandPR<cr>", desc = "Expand" },
33:       { "<leader>Gpo", "<cmd>GHOpenPR<cr>", desc = "Open" },
34:       { "<leader>Gpp", "<cmd>GHPopOutPR<cr>", desc = "PopOut" },
35:       { "<leader>Gpr", "<cmd>GHRefreshPR<cr>", desc = "Refresh" },
36:       { "<leader>Gpt", "<cmd>GHOpenToPR<cr>", desc = "Open To" },
37:       { "<leader>Gpz", "<cmd>GHCollapsePR<cr>", desc = "Collapse" },
38:       { "<leader>Gr", "", desc = "+Review" },
39:       { "<leader>Grb", "<cmd>GHStartReview<cr>", desc = "Begin" },
40:       { "<leader>Grc", "<cmd>GHCloseReview<cr>", desc = "Close" },
41:       { "<leader>Grd", "<cmd>GHDeleteReview<cr>", desc = "Delete" },
42:       { "<leader>Gre", "<cmd>GHExpandReview<cr>", desc = "Expand" },
43:       { "<leader>Grs", "<cmd>GHSubmitReview<cr>", desc = "Submit" },
44:       { "<leader>Grz", "<cmd>GHCollapseReview<cr>", desc = "Collapse" },
45:       { "<leader>Gt", "", desc = "+Threads" },
46:       { "<leader>Gtc", "<cmd>GHCreateThread<cr>", desc = "Create" },
47:       { "<leader>Gtn", "<cmd>GHNextThread<cr>", desc = "Next" },
48:       { "<leader>Gtt", "<cmd>GHToggleThread<cr>", desc = "Toggle" },
49:     },
50:   },
51: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/util/gitui.lua

```lua
...
3:   -- Ensure GitUI tool is installed
4:   {
5:     "mason-org/mason.nvim",
6:     opts = { ensure_installed = { "gitui" } },
7:     keys = {
8:       {
9:         "<leader>gG",
10:         function()
11:           Snacks.terminal({ "gitui" })
12:         end,
13:         desc = "GitUi (cwd)",
14:       },
15:       {
16:         "<leader>gg",
17:         function()
18:           Snacks.terminal({ "gitui" }, { cwd = LazyVim.root.get() })
19:         end,
20:         desc = "GitUi (Root Dir)",
21:       },
22:     },
23:     init = function()
24:       -- delete lazygit keymap for file history
25:       vim.api.nvim_create_autocmd("User", {
26:         pattern = "LazyVimKeymaps",
27:         once = true,
28:         callback = function()
29:           pcall(vim.keymap.del, "n", "<leader>gf")
30:           pcall(vim.keymap.del, "n", "<leader>gl")
31:         end,
32:       })
33:     end,
34:   },
35: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/util/octo.lua

```lua
...
4:   { import = "lazyvim.plugins.extras.lang.git" },
5: 
6:   {
7:     "folke/snacks.nvim",
8:     keys = { -- disable conflicting keymaps
9:       { "<leader>gi", false },
10:       { "<leader>gI", false },
11:       { "<leader>gp", false },
12:       { "<leader>gP", false },
13:     },
14:   },
15: 
16:   -- Octo
17:   {
18:     "pwntester/octo.nvim",
19:     cmd = "Octo",
20:     event = { { event = "BufReadCmd", pattern = "octo://*" } },
21:     opts = {
22:       enable_builtin = true,
23:       default_to_projects_v2 = true,
24:       default_merge_method = "squash",
25:       picker = "telescope",
26:     },
27:     keys = {
28:       { "<leader>gi", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
29:       { "<leader>gI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
30:       { "<leader>gp", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
31:       { "<leader>gP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
32:       { "<leader>gr", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
33:       { "<leader>gS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },
34: 
35:       { "<localleader>a", "", desc = "+assignee (Octo)", ft = "octo" },
36:       { "<localleader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
37:       { "<localleader>l", "", desc = "+label (Octo)", ft = "octo" },
38:       { "<localleader>i", "", desc = "+issue (Octo)", ft = "octo" },
39:       { "<localleader>r", "", desc = "+react (Octo)", ft = "octo" },
40:       { "<localleader>p", "", desc = "+pr (Octo)", ft = "octo" },
41:       { "<localleader>pr", "", desc = "+rebase (Octo)", ft = "octo" },
42:       { "<localleader>ps", "", desc = "+squash (Octo)", ft = "octo" },
43:       { "<localleader>v", "", desc = "+review (Octo)", ft = "octo" },
44:       { "<localleader>g", "", desc = "+goto_issue (Octo)", ft = "octo" },
45:       { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
46:       { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
47:     },
48:   },
49: 
50:   -- Octo Picker
51:   {
52:     "pwntester/octo.nvim",
53:     opts = function(_, opts)
54:       vim.treesitter.language.register("markdown", "octo")
55:       if LazyVim.has_extra("editor.telescope") then
56:         opts.picker = "telescope"
57:       elseif LazyVim.has_extra("editor.fzf") then
58:         opts.picker = "fzf-lua"
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/util/project.lua

```lua
...
19:     end
20: 
21:     local opts = {
22:       fzf_opts = {
23:         ["--header"] = string.format(
24:           ":: <%s> to %s | <%s> to %s | <%s> to %s | <%s> to %s | <%s> to %s",
25:           ansi_from_hl("FzfLuaHeaderBind", "ctrl-t"),
26:           ansi_from_hl("FzfLuaHeaderText", "tabedit"),
27:           ansi_from_hl("FzfLuaHeaderBind", "ctrl-s"),
28:           ansi_from_hl("FzfLuaHeaderText", "live_grep"),
29:           ansi_from_hl("FzfLuaHeaderBind", "ctrl-r"),
30:           ansi_from_hl("FzfLuaHeaderText", "oldfiles"),
31:           ansi_from_hl("FzfLuaHeaderBind", "ctrl-w"),
32:           ansi_from_hl("FzfLuaHeaderText", "change_dir"),
33:           ansi_from_hl("FzfLuaHeaderBind", "ctrl-d"),
34:           ansi_from_hl("FzfLuaHeaderText", "delete")
35:         ),
36:       },
37:       fzf_colors = true,
38:       actions = {
39:         ["default"] = {
40:           function(selected)
41:             fzf_lua.files({ cwd = selected[1] })
42:           end,
43:         },
44:         ["ctrl-t"] = {
45:           function(selected)
46:             vim.cmd("tabedit")
47:             fzf_lua.files({ cwd = selected[1] })
48:           end,
49:         },
50:         ["ctrl-s"] = {
51:           function(selected)
52:             fzf_lua.live_grep({ cwd = selected[1] })
53:           end,
54:         },
55:         ["ctrl-r"] = {
56:           function(selected)
57:             fzf_lua.oldfiles({ cwd = selected[1] })
58:           end,
59:         },
60:         ["ctrl-w"] = {
61:           function(selected)
62:             local path = selected[1]
63:             local ok = project.set_pwd(path)
64:             if ok then
65:               vim.api.nvim_win_close(0, false)
66:               LazyVim.info("Change project dir to " .. path)
67:             end
68:           end,
69:         },
70:         ["ctrl-d"] = function(selected)
71:           local path = selected[1]
72:           local choice = vim.fn.confirm("Delete '" .. path .. "' project? ", "&Yes\n&No")
73:           if choice == 1 then
74:             history.delete_project({ value = path })
75:           end
76:           pick()
77:         end,
78:       },
79:     }
80: 
81:     fzf_lua.fzf_exec(results, opts)
82:   end
...
108: 
109:   {
110:     "nvim-telescope/telescope.nvim",
111:     optional = true,
112:     keys = {
113:       { "<leader>fp", pick, desc = "Projects" },
114:     },
115:   },
116: 
117:   {
118:     "ibhagwan/fzf-lua",
119:     optional = true,
120:     keys = {
121:       { "<leader>fp", pick, desc = "Projects" },
122:     },
123:   },
124: 
125:   {
126:     "goolord/alpha-nvim",
127:     optional = true,
128:     opts = function(_, dashboard)
129:       local button = dashboard.button("P", " " .. " Projects (util.project)", pick)
130:       button.opts.hl = "AlphaButtons"
131:       button.opts.hl_shortcut = "AlphaShortcut"
132:       table.insert(dashboard.section.buttons.val, 4, button)
133:     end,
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/util/rest.lua

```lua
...
1: vim.filetype.add({
2:   extension = {
3:     ["http"] = "http",
4:   },
5: })
6: return {
7:   {
8:     "mistweaverco/kulala.nvim",
9:     ft = "http",
10:     keys = {
11:       { "<leader>R", "", desc = "+Rest" },
12:       { "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
13:       { "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL", ft = "http" },
14:       { "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl", ft = "http" },
15:       { "<leader>Re", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Set environment", ft = "http" },
16:       {
17:         "<leader>Rg",
18:         "<cmd>lua require('kulala').download_graphql_schema()<cr>",
19:         desc = "Download GraphQL schema",
20:         ft = "http",
21:       },
22:       { "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request", ft = "http" },
23:       { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request", ft = "http" },
24:       { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request", ft = "http" },
25:       { "<leader>Rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window", ft = "http" },
26:       { "<leader>Rr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
27:       { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request", ft = "http" },
28:       { "<leader>RS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats", ft = "http" },
29:       { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body", ft = "http" },
30:     },
31:     opts = {},
32:   },
33:   {
34:     "nvim-treesitter/nvim-treesitter",
35:     opts = {
36:       ensure_installed = { "http", "graphql" },
37:     },
38:   },
39: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/vscode.lua

```lua
...
30:   return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
31: end
32: vim.g.snacks_animate = false
33: 
34: -- Add some vscode specific keymaps
35: vim.api.nvim_create_autocmd("User", {
36:   pattern = "LazyVimKeymapsDefaults",
37:   callback = function()
38:     -- VSCode-specific keymaps for search and navigation
39:     vim.keymap.set("n", "<leader><space>", "<cmd>Find<cr>")
40:     vim.keymap.set("n", "<leader>/", function()
41:       vscode.call("workbench.action.findInFiles")
42:     end)
43:     vim.keymap.set("n", "<leader>ss", function()
44:       vscode.call("workbench.action.gotoSymbol")
45:     end)
46: 
47:     -- Toggle VS Code integrated terminal
48:     for _, lhs in ipairs({ "<leader>ft", "<leader>fT", "<c-/>" }) do
49:       vim.keymap.set("n", lhs, function()
50:         vscode.call("workbench.action.terminal.toggleTerminal")
51:       end)
52:     end
53: 
54:     -- Navigate VSCode tabs like lazyvim buffers
55:     vim.keymap.set("n", "<S-h>", function()
56:       vscode.call("workbench.action.previousEditor")
57:     end)
58:     vim.keymap.set("n", "<S-l>", function()
59:       vscode.call("workbench.action.nextEditor")
60:     end)
61:   end,
62: })
63: 
64: return {
65:   {
66:     "snacks.nvim",
67:     opts = {
68:       bigfile = { enabled = false },
69:       dashboard = { enabled = false },
70:       indent = { enabled = false },
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/formatting.lua

```lua
...
22:     "stevearc/conform.nvim",
23:     dependencies = { "mason.nvim" },
24:     lazy = true,
25:     cmd = "ConformInfo",
26:     keys = {
27:       {
28:         "<leader>cF",
29:         function()
30:           require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
31:         end,
32:         mode = { "n", "x" },
33:         desc = "Format Injected Langs",
34:       },
35:     },
36:     init = function()
37:       -- Install the conform formatter on VeryLazy
38:       LazyVim.on_very_lazy(function()
39:         LazyVim.format.register({
40:           name = "conform.nvim",
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/linting.lua

```lua
...
12:         -- Use the "*" filetype to run linters on all filetypes.
13:         -- ['*'] = { 'global linter' },
14:         -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
15:         -- ['_'] = { 'fallback linter' },
16:         -- ["*"] = { "typos" },
17:       },
18:       -- LazyVim extension to easily override linter options
19:       -- or add custom linters.
20:       ---@type table<string,table>
21:       linters = {
22:         -- -- Example of using selene only when a selene.toml file is present
23:         -- selene = {
24:         --   -- `condition` is another LazyVim extension that allows you to
25:         --   -- dynamically enable/disable linters based on the context.
26:         --   condition = function(ctx)
27:         --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
28:         --   end,
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/lsp/init.lua

```lua
...
64:         ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean, keys?:LazyKeysLspSpec[]}
65:         ---@type table<string, lazyvim.lsp.Config|boolean>
66:         servers = {
67:           -- configuration for all lsp servers
68:           ["*"] = {
69:             capabilities = {
70:               workspace = {
71:                 fileOperations = {
72:                   didRename = true,
73:                   willRename = true,
74:                 },
75:               },
76:             },
77:             -- stylua: ignore
78:             keys = {
79:               { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
80:               { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
81:               { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
82:               { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
83:               { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
84:               { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
85:               { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
86:               { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
87:               { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
88:               { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" }, has = "codeAction" },
89:               { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, has = "codeLens" },
90:               { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
91:               { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
92:               { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
93:               { "<leader>cA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
94:               { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
95:                 desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
96:               { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
97:                 desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
98:               { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
99:                 desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
100:               { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
101:                 desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
102:               {
103:                 "<leader>co",
104:                 LazyVim.lsp.action["source.organizeImports"],
105:                 desc = "Organize Imports",
106:                 has = "codeAction",
107:                 enabled = function(buf)
108:                   local code_actions = vim.tbl_filter(function(action)
109:                     return action:find("^source%.organizeImports%.?$")
110:                   end, LazyVim.lsp.code_actions({ bufnr = buf }))
111:                   return #code_actions > 0
112:                 end
113:               },
114:             },
115:           },
116:           stylua = { enabled = false },
117:           lua_ls = {
118:             -- mason = false, -- set to false if you don't want this server to be installed with mason
119:             -- Use this to add any additional keymaps
120:             -- for specific lsp servers
121:             -- ---@type LazyKeysSpec[]
122:             -- keys = {},
123:             settings = {
124:               Lua = {
125:                 workspace = {
126:                   checkThirdParty = false,
127:                 },
128:                 codeLens = {
129:                   enable = true,
130:                 },
131:                 completion = {
132:                   callSnippet = "Replace",
133:                 },
134:                 doc = {
...
155:           --   require("typescript").setup({ server = opts })
156:           --   return true
157:           -- end,
158:           -- Specify * to use this function as a fallback for any server
159:           -- ["*"] = function(server, opts) end,
160:         },
161:       }
162:       return ret
163:     end,
164:     ---@param opts PluginLspOpts
165:     config = function(_, opts)
166:       -- setup autoformat
167:       LazyVim.format.register(LazyVim.lsp.formatter())
168: 
169:       -- setup keymaps
170:       local names = vim.tbl_keys(opts.servers) ---@type string[]
171:       table.sort(names)
172:       for _, server in ipairs(names) do
173:         local server_opts = opts.servers[server]
174:         if type(server_opts) == "table" and server_opts.keys then
175:           require("lazyvim.plugins.lsp.keymaps").set({ name = server ~= "*" and server or nil }, server_opts.keys)
176:         end
177:       end
178: 
179:       -- inlay hints
180:       if opts.inlay_hints.enabled then
181:         Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
182:           if
183:             vim.api.nvim_buf_is_valid(buffer)
184:             and vim.bo[buffer].buftype == ""
185:             and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
186:           then
187:             vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
...
224:       vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
225: 
226:       if opts.capabilities then
227:         LazyVim.deprecate("lsp-config.opts.capabilities", "Use lsp-config.opts.servers['*'].capabilities instead")
228:         opts.servers["*"] = vim.tbl_deep_extend("force", opts.servers["*"] or {}, {
229:           capabilities = opts.capabilities,
230:         })
231:       end
232: 
233:       if opts.servers["*"] then
234:         vim.lsp.config("*", opts.servers["*"])
235:       end
236: 
237:       -- get all the servers that are available through mason-lspconfig
238:       local have_mason = LazyVim.has("mason-lspconfig.nvim")
239:       local mason_all = have_mason
240:           and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
...
281:   {
282: 
283:     "mason-org/mason.nvim",
284:     cmd = "Mason",
285:     keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
286:     build = ":MasonUpdate",
287:     opts_extend = { "ensure_installed" },
288:     opts = {
289:       ensure_installed = {
290:         "stylua",
291:         "shfmt",
292:       },
293:     },
294:     ---@param opts MasonSettings | {ensure_installed: string[]}
295:     config = function(_, opts)
296:       require("mason").setup(opts)
297:       local mr = require("mason-registry")
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/lsp/keymaps.lua

```lua
...
1: local M = {}
2: 
3: ---@type LazyKeysLspSpec[]|nil
4: M._keys = {}
5: 
6: ---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], enabled?:(fun(buf:number):boolean)}
7: ---@alias LazyKeysLsp LazyKeys|{has?:string|string[], enabled?:fun(buf:number):boolean}
8: 
9: ---@deprecated
10: ---@return LazyKeysLspSpec[]
11: function M.get()
12:   LazyVim.warn({
13:     'Adding LSP keymaps via `require("lazyvim.plugins.lsp.keymaps").get()` is deprecated.',
14:     "Please set keymaps via the `keys` field in the LSP server config.",
15:     [[
16: ```lua
17: {
18:   "neovim/nvim-lspconfig",
19:   opts = {
20:     servers = {
21:       ['*'] = {
22:         keys = {
23:           { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", has = "definition"},
24:         },
25:       },
26:     },
27:   },
28: }
29: ```]],
30:   }, { stacktrace = true })
31:   vim.schedule(function()
32:     if #M._keys > 0 then
33:       M.set({}, M._keys)
34:       M._keys = {}
35:     end
36:   end)
37:   return M._keys
38: end
39: 
40: ---@param filter vim.lsp.get_clients.Filter
41: ---@param spec LazyKeysLspSpec[]
42: function M.set(filter, spec)
43:   local Keys = require("lazy.core.handler.keys")
44:   for _, keys in pairs(Keys.resolve(spec)) do
45:     ---@cast keys LazyKeysLsp
46:     local filters = {} ---@type vim.lsp.get_clients.Filter[]
...
55:     end
56: 
57:     for _, f in ipairs(filters) do
58:       local opts = Keys.opts(keys)
59:       ---@cast opts snacks.keymap.set.Opts
60:       opts.lsp = f
61:       opts.enabled = keys.enabled
62:       Snacks.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
63:     end
64:   end
65: end
66: 
67: return M
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/treesitter.lua

```lua
...
14:         LazyVim.error("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.")
15:         return
16:       end
17:       -- make sure we're using the latest treesitter util
18:       package.loaded["lazyvim.util.treesitter"] = nil
19:       LazyVim.treesitter.build(function()
20:         TS.update(nil, { summary = true })
21:       end)
22:     end,
23:     event = { "LazyFile", "VeryLazy" },
24:     cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
25:     opts_extend = { "ensure_installed" },
26:     ---@alias lazyvim.TSFeat { enable?: boolean, disable?: string[] }
27:     ---@class lazyvim.TSConfig: TSConfig
28:     opts = {
29:       -- LazyVim config for treesitter
30:       indent = { enable = true }, ---@type lazyvim.TSFeat
...
143:     opts = {
144:       move = {
145:         enable = true,
146:         set_jumps = true, -- whether to set jumps in the jumplist
147:         -- LazyVim extention to create buffer-local keymaps
148:         keys = {
149:           goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
150:           goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
151:           goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
152:           goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
153:         },
154:       },
155:     },
156:     config = function(_, opts)
157:       local TS = require("nvim-treesitter-textobjects")
158:       if not TS.setup then
159:         LazyVim.error("Please use `:Lazy` and update `nvim-treesitter`")
160:         return
161:       end
162:       TS.setup(opts)
163: 
164:       local function attach(buf)
...
168:         end
169:         ---@type table<string, table<string, string>>
170:         local moves = vim.tbl_get(opts, "move", "keys") or {}
171: 
172:         for method, keymaps in pairs(moves) do
173:           for key, query in pairs(keymaps) do
174:             local queries = type(query) == "table" and query or { query }
175:             local parts = {}
176:             for _, q in ipairs(queries) do
177:               local part = q:gsub("@", ""):gsub("%..*", "")
178:               part = part:sub(1, 1):upper() .. part:sub(2)
179:               table.insert(parts, part)
180:             end
181:             local desc = table.concat(parts, " or ")
182:             desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
183:             desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
184:             vim.keymap.set({ "n", "x", "o" }, key, function()
185:               if vim.wo.diff and key:find("[cC]") then
186:                 return vim.cmd("normal! " .. key)
187:               end
188:               require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
189:             end, {
190:               buffer = buf,
191:               desc = desc,
192:               silent = true,
193:             })
194:           end
195:         end
196:       end
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/ui.lua

```lua
...
3:   -- tabs, which include filetype icons and close buttons.
4:   {
5:     "akinsho/bufferline.nvim",
6:     event = "VeryLazy",
7:     keys = {
8:       { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
9:       { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
10:       { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
11:       { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
12:       { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
13:       { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
14:       { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
15:       { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
16:       { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
17:       { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
18:       { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
19:     },
20:     opts = {
21:       options = {
22:         -- stylua: ignore
23:         close_command = function(n) Snacks.bufdelete(n) end,
24:         -- stylua: ignore
25:         right_mouse_command = function(n) Snacks.bufdelete(n) end,
26:         diagnostics = "nvim_lsp",
27:         always_show_bufferline = false,
28:         diagnostics_indicator = function(_, _, diag)
29:           local icons = LazyVim.config.icons.diagnostics
30:           local ret = (diag.error and icons.Error .. diag.error .. " " or "")
...
197:     event = "VeryLazy",
198:     opts = {
199:       lsp = {
200:         override = {
201:           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
202:           ["vim.lsp.util.stylize_markdown"] = true,
203:           ["cmp.entry.get_documentation"] = true,
204:         },
205:       },
206:       routes = {
207:         {
208:           filter = {
209:             event = "msg_show",
210:             any = {
211:               { find = "%d+L, %d+B" },
212:               { find = "; after #%d+" },
213:               { find = "; before #%d+" },
214:             },
215:           },
...
222:         long_message_to_split = true,
223:       },
224:     },
225:     -- stylua: ignore
226:     keys = {
227:       { "<leader>sn", "", desc = "+noice"},
228:       { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
229:       { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
230:       { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
231:       { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
232:       { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
233:       { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
234:       { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
235:       { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
236:     },
237:     config = function(_, opts)
238:       -- HACK: noice shows messages from before it was enabled,
239:       -- but this is not ideal when Lazy is installing plugins,
240:       -- so clear the messages in this case.
241:       if vim.o.filetype == "lazy" then
242:         vim.cmd([[messages clear]])
243:       end
244:       require("noice").setup(opts)
245:     end,
...
250:     "nvim-mini/mini.icons",
251:     lazy = true,
252:     opts = {
253:       file = {
254:         [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
255:         ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
256:       },
257:       filetype = {
258:         dotenv = { glyph = "", hl = "MiniIconsYellow" },
259:       },
260:     },
261:     init = function()
262:       package.preload["nvim-web-devicons"] = function()
263:         require("mini.icons").mock_nvim_web_devicons()
264:         return package.loaded["nvim-web-devicons"]
265:       end
266:     end,
267:   },
268: 
269:   -- ui components
270:   { "MunifTanjim/nui.nvim", lazy = true },
271: 
272:   {
273:     "snacks.nvim",
274:     opts = {
...
277:       notifier = { enabled = true },
278:       scope = { enabled = true },
279:       scroll = { enabled = true },
280:       statuscolumn = { enabled = false }, -- we set this in options.lua
281:       toggle = { map = LazyVim.safe_keymap_set },
282:       words = { enabled = true },
283:     },
284:     -- stylua: ignore
285:     keys = {
286:       { "<leader>n", function()
287:         if Snacks.config.picker and Snacks.config.picker.enabled then
288:           Snacks.picker.notifications()
289:         else
290:           Snacks.notifier.show_history()
291:         end
292:       end, desc = "Notification History" },
293:       { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
294:     },
295:   },
296: 
297:   {
298:     "snacks.nvim",
299:     opts = {
300:       dashboard = {
301:         preset = {
302:           pick = function(cmd, opts)
303:             return LazyVim.pick(cmd, opts)()
304:           end,
305:           header = [[
...
311:           ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
312:    ]],
313:           -- stylua: ignore
314:           ---@type snacks.dashboard.Item[]
315:           keys = {
316:             { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
317:             { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
318:             { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
319:             { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
320:             { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
321:             { icon = " ", key = "s", desc = "Restore Session", section = "session" },
322:             { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
323:             { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
324:             { icon = " ", key = "q", desc = "Quit", action = ":qa" },
325:           },
326:         },
327:       },
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/util.lua

```lua
...
17:       bigfile = { enabled = true },
18:       quickfile = { enabled = true },
19:       terminal = {
20:         win = {
21:           keys = {
22:             nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
23:             nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
24:             nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
25:             nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
26:             hide_slash = { "<C-/>", "hide", desc = "Hide Terminal", mode = "t" },
27:             hide_underscore = { "<c-_>", "hide", desc = "which_key_ignore", mode = "t" },
28:           },
29:         },
30:       },
31:     },
32:     -- stylua: ignore
33:     keys = {
34:       { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
35:       { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
36:       { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
37:     },
38:   },
39: 
40:   -- Session management. This saves your session in the background,
41:   -- keeping track of open buffers, window arrangement, and more.
42:   -- You can restore sessions when returning through the dashboard.
43:   {
44:     "folke/persistence.nvim",
45:     event = "BufReadPre",
46:     opts = {},
47:     -- stylua: ignore
48:     keys = {
49:       { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
50:       { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
51:       { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
52:       { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
53:     },
54:   },
55: 
56:   -- library used by other plugins
57:   { "nvim-lua/plenary.nvim", lazy = true },
58: }
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/xtras.lua

```lua
...
1: -- Some extras need to be loaded before others
2: local prios = {
3:   ["lazyvim.plugins.extras.test.core"] = 1,
4:   ["lazyvim.plugins.extras.dap.core"] = 1,
5:   ["lazyvim.plugins.extras.coding.nvim-cmp"] = 2,
6:   ["lazyvim.plugins.extras.editor.neo-tree"] = 2,
7:   ["lazyvim.plugins.extras.ui.edgy"] = 3,
8:   ["lazyvim.plugins.extras.ai.copilot-native"] = 4,
9:   ["lazyvim.plugins.extras.coding.blink"] = 5,
10:   ["lazyvim.plugins.extras.lang.typescript"] = 5,
11:   ["lazyvim.plugins.extras.formatting.prettier"] = 10,
12:   -- default core extra priority is 20
13:   -- default priority is 50
14:   ["lazyvim.plugins.extras.editor.aerial"] = 100,
15:   ["lazyvim.plugins.extras.editor.outline"] = 100,
16:   ["lazyvim.plugins.extras.ui.alpha"] = 19,
17:   ["lazyvim.plugins.extras.ui.dashboard-nvim"] = 19,
18:   ["lazyvim.plugins.extras.ui.mini-starter"] = 19,
19: }
20: 
21: if vim.g.xtras_prios then
22:   prios = vim.tbl_deep_extend("force", prios, vim.g.xtras_prios or {})
23: end
24: 
25: local extras = {} ---@type string[]
26: local defaults = LazyVim.config.get_defaults()
27: 
28: local changed = false
29: local updated = {} ---@type string[]
30: 
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/util/cmp.lua

```lua
...
78:   if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
79:     local cursor = vim.api.nvim_win_get_cursor(0)
80:     local prev_char = vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1, {})[1]
81:     if prev_char ~= "(" and prev_char ~= ")" then
82:       local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
83:       vim.api.nvim_feedkeys(keys, "i", true)
84:     end
85:   end
86: end
87: 
88: -- This function adds missing documentation to snippets.
89: -- The documentation is a preview of the snippet.
90: ---@param window cmp.CustomEntriesView|cmp.NativeEntriesView
91: function M.add_missing_snippet_docs(window)
92:   local cmp = require("cmp")
93:   local Kind = cmp.lsp.CompletionItemKind
94:   local entries = window:get_entries()
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/util/init.lua

```lua
...
104: ---@param key string
105: ---@param values T[]
106: ---@return T[]?
107: function M.extend(t, key, values)
108:   local keys = vim.split(key, ".", { plain = true })
109:   for i = 1, #keys do
110:     local k = keys[i]
111:     t[k] = t[k] or {}
112:     if type(t) ~= "table" then
113:       return
114:     end
115:     t = t[k]
116:   end
117:   return vim.list_extend(t, values)
118: end
119: 
120: ---@param name string
...
199:     })
200:   end
201: end
202: 
203: -- Wrapper around vim.keymap.set that will
204: -- not create a keymap if a lazy key handler exists.
205: -- It will also set `silent` to true by default.
206: function M.safe_keymap_set(mode, lhs, rhs, opts)
207:   local keys = require("lazy.core.handler").handlers.keys
208:   ---@cast keys LazyKeysHandler
209:   local modes = type(mode) == "string" and { mode } or mode
210: 
211:   ---@param m string
212:   modes = vim.tbl_filter(function(m)
213:     return not (keys.have and keys:have(lhs, m))
214:   end, modes)
215: 
216:   -- do not create the keymap if a lazy keys handler exists
217:   if #modes > 0 then
218:     opts = opts or {}
219:     opts.silent = opts.silent ~= false
220:     if opts.remap and not vim.g.vscode then
221:       ---@diagnostic disable-next-line: no-unknown
222:       opts.remap = nil
223:     end
224:     Snacks.keymap.set(modes, lhs, rhs, opts)
225:   end
226: end
227: 
228: ---@generic T
229: ---@param list T[]
230: ---@return T[]
231: function M.dedup(list)
232:   local ret = {}
233:   local seen = {}
234:   for _, v in ipairs(list) do
235:     if not seen[v] then
236:       table.insert(ret, v)
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/util/json.lua

```lua
...
24:         end
25:       end
26:       return "[\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "]"
27:     else
28:       local keys = vim.tbl_keys(value)
29:       table.sort(keys)
30:       ---@diagnostic disable-next-line: no-unknown
31:       for _, k in ipairs(keys) do
32:         local e = encode(value[k], next_indent)
33:         if e then
34:           table.insert(parts, next_indent .. string.format("%q", k) .. ": " .. e)
35:         end
36:       end
37:       return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "}"
38:     end
39:   end
40: end
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/util/mini.lua

```lua
...
53: 
54:   ---@type wk.Spec[]
55:   local ret = { mode = { "o", "x" } }
56:   ---@type table<string, string>
57:   local mappings = vim.tbl_extend("force", {}, {
58:     around = "a",
59:     inside = "i",
60:     around_next = "an",
61:     inside_next = "in",
62:     around_last = "al",
63:     inside_last = "il",
64:   }, opts.mappings or {})
65:   mappings.goto_left = nil
66:   mappings.goto_right = nil
67: 
68:   for name, prefix in pairs(mappings) do
69:     name = name:gsub("^around_", ""):gsub("^inside_", "")
...
88:     end,
89:     set = function(state)
90:       vim.g.minipairs_disable = not state
91:     end,
92:   }):map("<leader>up")
93: 
94:   local pairs = require("mini.pairs")
95:   pairs.setup(opts)
96:   local open = pairs.open
97:   pairs.open = function(pair, neigh_pattern)
98:     if vim.fn.getcmdline() ~= "" then
99:       return open(pair, neigh_pattern)
100:     end
101:     local o, c = pair:sub(1, 1), pair:sub(2, 2)
102:     local line = vim.api.nvim_get_current_line()
103:     local cursor = vim.api.nvim_win_get_cursor(0)
104:     local next = line:sub(cursor[2] + 1, cursor[2] + 1)
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/util/plugin.lua

```lua
...
11: M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }
12: 
13: ---@type table<string, string>
14: M.deprecated_extras = {
15:   ["lazyvim.plugins.extras.formatting.conform"] = "`conform.nvim` is now the default **LazyVim** formatter.",
16:   ["lazyvim.plugins.extras.linting.nvim-lint"] = "`nvim-lint` is now the default **LazyVim** linter.",
17:   ["lazyvim.plugins.extras.ui.dashboard"] = "`dashboard.nvim` is now the default **LazyVim** starter.",
18:   ["lazyvim.plugins.extras.coding.native_snippets"] = "Native snippets are now the default for **Neovim >= 0.10**",
19:   ["lazyvim.plugins.extras.ui.treesitter-rewrite"] = "Disabled `treesitter-rewrite` extra for now. Not ready yet.",
20:   ["lazyvim.plugins.extras.ui.treesitter-main"] = "the `nvim-treesitter` main branch is now used by default",
21:   ["lazyvim.plugins.extras.coding.mini-ai"] = "`mini.ai` is now a core LazyVim plugin (again)",
22:   ["lazyvim.plugins.extras.lazyrc"] = "local spec files are now a lazy.nvim feature",
23:   ["lazyvim.plugins.extras.editor.trouble-v3"] = "Trouble v3 has been merged in main",
24:   ["lazyvim.plugins.extras.lang.python-semshi"] = [[The python-semshi extra has been removed,
25:   because it's causing too many issues.
26:   Either use `basedpyright`, or copy the [old extra](https://github.com/LazyVim/LazyVim/blob/c1f5fcf9c7ed2659c9d5ac41b3bb8a93e0a3c6a0/lua/lazyvim/plugins/extras/lang/python-semshi.lua#L1) to your own config.
27:   ]],
28: }
29: M.renamed_extras = {
30:   ["lazyvim.plugins.extras.lang.omnisharp"] = "lazyvim.plugins.extras.lang.dotnet",
31:   ["lazyvim.plugins.extras.formatting.biome"] = "lazyvim.plugins.extras.lang.typescript.biome",
32: }
33: 
34: M.deprecated_modules = {}
35: 
36: ---@type table<string, string>
37: M.renames = {
38:   ["windwp/nvim-spectre"] = "nvim-pack/nvim-spectre",
39:   ["jose-elias-alvarez/null-ls.nvim"] = "nvimtools/none-ls.nvim",
40:   ["null-ls.nvim"] = "none-ls.nvim",
41:   ["romgrk/nvim-treesitter-context"] = "nvim-treesitter/nvim-treesitter-context",
42:   ["glepnir/dashboard-nvim"] = "nvimdev/dashboard-nvim",
43:   ["markdown.nvim"] = "render-markdown.nvim",
44:   ["williamboman/mason.nvim"] = "mason-org/mason.nvim",
45:   ["williamboman/mason-lspconfig.nvim"] = "mason-org/mason-lspconfig.nvim",
46:   ["ggandor/leap.nvim"] = "https://codeberg.org/andyg/leap.nvim.git",
47: }
48: 
49: function M.save_core()
50:   if vim.v.vim_did_enter == 1 then
51:     return
52:   end
53:   M.core_imports = vim.deepcopy(require("lazy.core.config").spec.modules)
54: end
55: 
56: function M.setup()
57:   M.fix_imports()
58:   M.fix_renames()
...
84:   -- Add support for the LazyFile event
85:   local Event = require("lazy.core.handler.event")
86: 
87:   Event.mappings.LazyFile = { id = "LazyFile", event = M.lazy_file_events }
88:   Event.mappings["User LazyFile"] = Event.mappings.LazyFile
89: end
90: 
91: function M.fix_imports()
92:   local defaults ---@type table<string, LazyVimDefault>
93:   Plugin.Spec.import = LazyVim.inject.args(Plugin.Spec.import, function(_, spec)
94:     if M.handle_defaults and LazyVim.config.json.loaded then
95:       -- extra disabled by defaults?
96:       defaults = defaults or LazyVim.config.get_defaults()
97:       local def = defaults[spec.import]
98:       if def and def.enabled == false then
99:         return false
100:       end
```

### ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/util/treesitter.lua

```lua
...
75:   end
76: 
77:   ---@class lazyvim.util.treesitter.Health: table<string,boolean>
78:   local ret = {
79:     ["tree-sitter (CLI)"] = have("tree-sitter"),
80:     ["C compiler"] = have_cc,
81:     tar = have("tar"),
82:     curl = have("curl"),
83:   }
84:   local ok = true
85:   for _, v in pairs(ret) do
86:     ok = ok and v
87:   end
88:   return ok, ret
89: end
90: 
91: ---@param cb fun()
92: function M.build(cb)
...
95:     if ok then
96:       return cb()
97:     else
98:       local lines = { "Unmet requirements for **nvim-treesitter** `main`:" }
99:       local keys = vim.tbl_keys(health) ---@type string[]
100:       table.sort(keys)
101:       for _, k in pairs(keys) do
102:         lines[#lines + 1] = ("- %s `%s`"):format(health[k] and "✅" or "❌", k)
103:       end
104:       vim.list_extend(lines, {
105:         "",
106:         "See the requirements at [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)",
107:         "Run `:checkhealth nvim-treesitter` for more information.",
108:       })
109:       if vim.fn.has("win32") == 1 and not health["C compiler"] then
110:         lines[#lines + 1] = "Install a C compiler with `winget install --id=BrechtSanders.WinLibs.POSIX.UCRT -e`"
111:       end
```

### ~/.local/share/nvim/lazy/snacks.nvim/lua/snacks/picker/config/defaults.lua

```lua
...
102: ---@field formatters? snacks.picker.formatters.Config|{}
103: ---@field sources? snacks.picker.sources.Config|{}|table<string, snacks.picker.Config|{}>
104: ---@field layouts? table<string, snacks.picker.layout.Config>
105: --- Actions
106: ---@field actions? table<string, snacks.picker.Action.spec> actions used by keymaps
107: ---@field confirm? snacks.picker.Action.spec shortcut for confirm action
108: ---@field auto_confirm? boolean automatically confirm if there is only one item
109: ---@field main? snacks.picker.main.Config main editor window config
110: ---@field on_change? fun(picker:snacks.Picker, item?:snacks.picker.Item) called when the cursor changes
111: ---@field on_show? fun(picker:snacks.Picker) called when the picker is shown
112: ---@field on_close? fun(picker:snacks.Picker) called when the picker is closed
113: ---@field jump? snacks.picker.jump.Config|{}
114: --- Other
115: ---@field config? fun(opts:snacks.picker.Config):snacks.picker.Config? custom config function
116: ---@field db? snacks.picker.db.Config|{}
117: ---@field debug? snacks.picker.debug|{}
118: local defaults = {
...
218:   },
219:   win = {
220:     -- input window
221:     input = {
222:       keys = {
223:         -- to close the picker on ESC instead of going to normal mode,
224:         -- add the following keymap to your config
225:         -- ["<Esc>"] = { "close", mode = { "n", "i" } },
226:         ["/"] = "toggle_focus",
227:         ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
228:         ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
229:         ["<C-c>"] = { "cancel", mode = "i" },
230:         ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
231:         ["<CR>"] = { "confirm", mode = { "n", "i" } },
232:         ["<Down>"] = { "list_down", mode = { "i", "n" } },
233:         ["<Esc>"] = "cancel",
234:         ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
235:         ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
236:         ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
237:         ["<Up>"] = { "list_up", mode = { "i", "n" } },
238:         ["<a-d>"] = { "inspect", mode = { "n", "i" } },
239:         ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
240:         ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
241:         ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
242:         ["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
243:         ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
244:         ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
245:         ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
246:         ["<c-a>"] = { "select_all", mode = { "n", "i" } },
247:         ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
248:         ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
249:         ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
250:         ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
251:         ["<c-j>"] = { "list_down", mode = { "i", "n" } },
252:         ["<c-k>"] = { "list_up", mode = { "i", "n" } },
253:         ["<c-n>"] = { "list_down", mode = { "i", "n" } },
254:         ["<c-p>"] = { "list_up", mode = { "i", "n" } },
255:         ["<c-q>"] = { "qflist", mode = { "i", "n" } },
256:         ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
257:         ["<c-t>"] = { "tab", mode = { "n", "i" } },
258:         ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
259:         ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
260:         ["<c-r>#"] = { "insert_alt", mode = "i" },
261:         ["<c-r>%"] = { "insert_filename", mode = "i" },
262:         ["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
263:         ["<c-r><c-f>"] = { "insert_file", mode = "i" },
264:         ["<c-r><c-l>"] = { "insert_line", mode = "i" },
265:         ["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
266:         ["<c-r><c-w>"] = { "insert_cword", mode = "i" },
267:         ["<c-w>H"] = "layout_left",
268:         ["<c-w>J"] = "layout_bottom",
269:         ["<c-w>K"] = "layout_top",
270:         ["<c-w>L"] = "layout_right",
271:         ["?"] = "toggle_help_input",
272:         ["G"] = "list_bottom",
273:         ["gg"] = "list_top",
274:         ["j"] = "list_down",
275:         ["k"] = "list_up",
276:         ["q"] = "cancel",
277:       },
278:       b = {
279:         minipairs_disable = true,
280:       },
281:     },
282:     -- result list window
283:     list = {
284:       keys = {
285:         ["/"] = "toggle_focus",
286:         ["<2-LeftMouse>"] = "confirm",
287:         ["<CR>"] = "confirm",
288:         ["<Down>"] = "list_down",
289:         ["<Esc>"] = "cancel",
290:         ["<S-CR>"] = { { "pick_win", "jump" } },
291:         ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
292:         ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
293:         ["<Up>"] = "list_up",
294:         ["<a-d>"] = "inspect",
295:         ["<a-f>"] = "toggle_follow",
296:         ["<a-h>"] = "toggle_hidden",
297:         ["<a-i>"] = "toggle_ignored",
298:         ["<a-m>"] = "toggle_maximize",
299:         ["<a-p>"] = "toggle_preview",
300:         ["<a-w>"] = "cycle_win",
301:         ["<c-a>"] = "select_all",
302:         ["<c-b>"] = "preview_scroll_up",
303:         ["<c-d>"] = "list_scroll_down",
304:         ["<c-f>"] = "preview_scroll_down",
305:         ["<c-j>"] = "list_down",
306:         ["<c-k>"] = "list_up",
307:         ["<c-n>"] = "list_down",
308:         ["<c-p>"] = "list_up",
309:         ["<c-q>"] = "qflist",
310:         ["<c-g>"] = "print_path",
311:         ["<c-s>"] = "edit_split",
312:         ["<c-t>"] = "tab",
313:         ["<c-u>"] = "list_scroll_up",
314:         ["<c-v>"] = "edit_vsplit",
315:         ["<c-w>H"] = "layout_left",
316:         ["<c-w>J"] = "layout_bottom",
317:         ["<c-w>K"] = "layout_top",
318:         ["<c-w>L"] = "layout_right",
319:         ["?"] = "toggle_help_list",
320:         ["G"] = "list_bottom",
321:         ["gg"] = "list_top",
322:         ["i"] = "focus_input",
323:         ["j"] = "list_down",
324:         ["k"] = "list_up",
325:         ["q"] = "cancel",
326:         ["zb"] = "list_scroll_bottom",
327:         ["zt"] = "list_scroll_top",
328:         ["zz"] = "list_scroll_center",
329:       },
330:       wo = {
331:         conceallevel = 2,
332:         concealcursor = "nvc",
333:       },
334:     },
335:     -- preview window
336:     preview = {
337:       keys = {
338:         ["<Esc>"] = "cancel",
339:         ["q"] = "cancel",
340:         ["i"] = "focus_input",
341:         ["<a-w>"] = "cycle_win",
342:       },
343:     },
344:   },
345:   ---@class snacks.picker.icons
346:     -- stylua: ignore
347:   icons = {
348:     files = {
349:       enabled = true, -- show file icons
350:       dir = "󰉋 ",
351:       dir_open = "󰝰 ",
352:       file = "󰈔 "
353:     },
354:     keymaps = {
355:       nowait = "󰓅 "
356:     },
357:     tree = {
358:       vertical = "│ ",
359:       middle   = "├╴",
360:       last     = "└╴",
361:     },
362:     undo = {
363:       saved   = " ",
364:     },
365:     ui = {
366:       live        = "󰐰 ",
```

### ~/.local/share/nvim/lazy/snacks.nvim/lua/snacks/terminal.lua

```lua
...
34:     filetype = "snacks_terminal",
35:   },
36:   wo = {},
37:   stack = true, -- when enabled, multiple split windows with the same position will be stacked together (useful for terminals)
38:   keys = {
39:     q = "hide",
40:     gf = function(self)
41:       local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
42:       if f == "" then
43:         Snacks.notify.warn("No file under cursor")
44:       else
45:         self:hide()
46:         vim.schedule(function()
47:           vim.cmd("e " .. f)
48:         end)
49:       end
50:     end,
...
294:   end
295:   vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
296: 
297:   vim.api.nvim_chan_send(vim.api.nvim_open_term(buf, {}), table.concat(lines, "\r\n"))
298:   vim.keymap.set("n", "q", "<cmd>q<cr>", { silent = true, buffer = buf })
299:   vim.api.nvim_create_autocmd("TextChanged", {
300:     buffer = buf,
301:     callback = function()
302:       pcall(vim.api.nvim_win_set_cursor, 0, { #lines, 0 })
303:     end,
304:   })
305:   vim.api.nvim_create_autocmd("TermEnter", { buffer = buf, command = "stopinsert" })
306: end
307: 
308: ---@private
309: function M.health()
310:   local opts = Snacks.config.get("terminal", defaults --[[@as snacks.terminal.Opts]])
```

### ~/.local/share/nvim/lazy/blink.cmp/lua/blink/cmp/keymap/presets.lua

```lua
...
1: local presets = {}
2: 
3: --- @type table<string, table<string, blink.cmp.KeymapCommand[] | false>>
4: local presets_keymaps = {
5:   none = {},
6: 
7:   default = {
8:     ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
9:     ['<C-e>'] = { 'cancel', 'fallback' },
10:     ['<C-y>'] = { 'select_and_accept', 'fallback' },
11: 
12:     ['<Up>'] = { 'select_prev', 'fallback' },
13:     ['<Down>'] = { 'select_next', 'fallback' },
14:     ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
15:     ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
16: 
17:     ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
18:     ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
19: 
20:     ['<Tab>'] = { 'snippet_forward', 'fallback' },
21:     ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
22: 
23:     ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
24:   },
25: 
26:   cmdline = {
27:     ['<Tab>'] = { 'show_and_insert_or_accept_single', 'select_next' },
28:     ['<S-Tab>'] = {
29:       function(cmp) return cmp.show_and_insert_or_accept_single({ initial_selected_item_idx = -1 }) end,
30:       'select_prev',
31:     },
32: 
33:     ['<C-space>'] = { 'show', 'fallback' },
34: 
35:     ['<C-n>'] = { 'select_next', 'fallback' },
36:     ['<C-p>'] = { 'select_prev', 'fallback' },
37:     ['<Right>'] = { 'select_next', 'fallback' },
38:     ['<Left>'] = { 'select_prev', 'fallback' },
39: 
40:     ['<C-y>'] = { 'select_and_accept', 'fallback' },
41:     ['<C-e>'] = { 'cancel', 'fallback' },
42:     ['<End>'] = { 'hide', 'fallback' },
43:   },
44: 
45:   ['super-tab'] = {
46:     ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
47:     ['<C-e>'] = { 'cancel', 'fallback' },
48: 
49:     ['<Tab>'] = {
50:       function(cmp)
51:         if cmp.snippet_active() then
52:           return cmp.accept()
53:         else
54:           return cmp.select_and_accept()
55:         end
56:       end,
57:       'snippet_forward',
58:       'fallback',
59:     },
60:     ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
61: 
62:     ['<Up>'] = { 'select_prev', 'fallback' },
63:     ['<Down>'] = { 'select_next', 'fallback' },
64:     ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
65:     ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
66: 
67:     ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
68:     ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
69: 
70:     ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
71:   },
72: 
73:   enter = {
74:     ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
75:     ['<C-e>'] = { 'cancel', 'fallback' },
76:     ['<CR>'] = { 'accept', 'fallback' },
77: 
78:     ['<Tab>'] = { 'snippet_forward', 'fallback' },
79:     ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
80: 
81:     ['<Up>'] = { 'select_prev', 'fallback' },
82:     ['<Down>'] = { 'select_next', 'fallback' },
83:     ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
84:     ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
85: 
86:     ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
87:     ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
88: 
89:     ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
90:   },
91: }
92: 
93: --- Gets the preset keymap for the given preset name
94: --- @param name string
95: --- @return table<string, blink.cmp.KeymapCommand[] | false>
96: function presets.get(name)
97:   local preset = presets_keymaps[name]
98:   if preset == nil then error('Invalid blink.cmp keymap preset: ' .. name) end
99:   return preset
100: end
101: 
102: return presets
```

### ~/.local/share/nvim/lazy/neo-tree.nvim/lua/neo-tree/defaults.lua

```lua
...
62:   --                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
63:   sort_case_insensitive = false, -- used when sorting files and directories in the tree
64:   sort_function = nil , -- uses a custom function for sorting files and directories in the tree
65:   use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
66:   use_default_mappings = true,
67:   -- source_selector provides clickable tabs to switch between sources.
68:   source_selector = {
69:     winbar = false, -- toggle to show selector on winbar
70:     statusline = false, -- toggle to show selector on statusline
71:     show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
72:                                            -- of the top visible node when scrolled down.
73:     sources = {
74:       { source = "filesystem" },
75:       { source = "buffers" },
76:       { source = "git_status" },
77:     },
78:     content_layout = "start", -- only with `tabs_layout` = "equal", "active"
...
374:   --    globally    -> `opts.window.mappings`
375:   --    locally     -> `opt[source_name].window.mappings` to make it source specific.
376:   --
377:   -- commands = {              |  window {                 |  filesystem {
378:   --   hello = function()      |    mappings = {           |    commands = {
379:   --     print("Hello world")  |      ["<C-c>"] = "hello"  |      hello = function()
380:   --   end                     |    }                      |        print("Hello world in filesystem")
381:   -- }                         |  }                        |      end
382:   --
383:   -- see `:h neo-tree-custom-commands-global`
384:   commands = {}, -- A list of functions
385: 
386:   window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
387:              -- possible options. These can also be functions that return these options.
388:     position = "left", -- left, right, top, bottom, float, current
389:     width = 40, -- applies to left and right positions
390:     height = 15, -- applies to top and bottom positions
391:     auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
...
409:     mapping_options = {
410:       noremap = true,
411:       nowait = true,
412:     },
413:     mappings = {
414:       ["<space>"] = {
415:           "toggle_node",
416:           nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
417:       },
418:       ["<2-LeftMouse>"] = "open",
419:       ["<cr>"] = "open",
420:       -- ["<cr>"] = { "open", config = { expand_nested_files = true } }, -- expand nested file takes precedence
421:       ["<esc>"] = "cancel", -- close preview or floating neo-tree window
422:       ["P"] = {
423:         "toggle_preview",
424:         config = {
425:           use_float = true,
426:           use_snacks_image = true,
427:           use_image_nvim = true,
428:           -- title = "Neo-tree Preview", -- You can define a custom title for the preview floating window.
429:         }
430:       },
431:       ["<C-f>"] = { "scroll_preview", config = {direction = -10} },
432:       ["<C-b>"] = { "scroll_preview", config = {direction = 10} },
433:       ["l"] = "focus_preview",
434:       ["S"] = "open_split",
435:       -- ["S"] = "split_with_window_picker",
436:       ["s"] = "open_vsplit",
437:       -- ["sr"] = "open_rightbelow_vs",
438:       -- ["sl"] = "open_leftabove_vs",
439:       -- ["s"] = "vsplit_with_window_picker",
440:       ["t"] = "open_tabnew",
441:       -- ["<cr>"] = "open_drop",
442:       -- ["t"] = "open_tab_drop",
443:       ["w"] = "open_with_window_picker",
444:       ["C"] = "close_node",
445:       --["C"] = "close_all_subnodes",
446:       ["z"] = "close_all_nodes",
447:       --["Z"] = "expand_all_nodes",
448:       --["Z"] = "expand_all_subnodes",
449:       ["R"] = "refresh",
450:       ["a"] = {
451:         "add",
452:         -- some commands may take optional config options, see `:h neo-tree-mappings` for details
453:         config = {
454:           show_path = "none", -- "none", "relative", "absolute"
455:         }
456:       },
457:       ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
458:       ["d"] = "delete",
459:       ["r"] = "rename",
460:       ["y"] = "copy_to_clipboard",
461:       ["x"] = "cut_to_clipboard",
462:       ["p"] = "paste_from_clipboard",
463:       ["<C-r>"] = "clear_clipboard",
464:       ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
465:       ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
466:       ["e"] = "toggle_auto_expand_width",
467:       ["q"] = "close_window",
468:       ["?"] = "show_help",
469:       -- You can sort by command name with:
470:       -- ["?"] = { "show_help", config = { sorter = function(a, b) return a.mapping.text < b.mapping.text end } },
471:       -- The type of a and b are neotree.Help.Mapping
472:       ["<"] = "prev_source",
473:       [">"] = "next_source",
474:     },
475:   },
476:   filesystem = {
477:     window = {
478:       mappings = {
479:         ["H"] = "toggle_hidden",
480:         ["/"] = "fuzzy_finder",
481:         --["/"] = {"fuzzy_finder", config = { keep_filter_on_submit = true }},
482:         --["/"] = "filter_as_you_type", -- this was the default until v1.28
483:         ["D"] = "fuzzy_finder_directory",
484:         -- ["D"] = "fuzzy_sorter_directory",
485:         ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
486:         ["f"] = "filter_on_submit",
487:         ["<C-x>"] = "clear_filter",
488:         ["<bs>"] = "navigate_up",
489:         ["."] = "set_root",
490:         ["[g"] = "prev_git_modified",
491:         ["]g"] = "next_git_modified",
492:         ["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
493:         ["b"] = "rename_basename",
494:         ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
495:         ["oc"] = { "order_by_created", nowait = false },
496:         ["od"] = { "order_by_diagnostics", nowait = false },
497:         ["og"] = { "order_by_git_status", nowait = false },
498:         ["om"] = { "order_by_modified", nowait = false },
499:         ["on"] = { "order_by_name", nowait = false },
500:         ["os"] = { "order_by_size", nowait = false },
501:         ["ot"] = { "order_by_type", nowait = false },
502:       },
503:       fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
504:         ["<down>"] = "move_cursor_down",
505:         ["<C-n>"] = "move_cursor_down",
506:         ["<up>"] = "move_cursor_up",
507:         ["<C-p>"] = "move_cursor_up",
508:         ["<Esc>"] = "close",
509:         ["<S-CR>"] = "close_keep_filter",
510:         ["<C-CR>"] = "close_clear_filter",
511:         ["<C-w>"] = { "<C-S-w>", raw = true },
512:         {
513:           -- normal mode mappings
514:           n = {
515:             ["j"] = "move_cursor_down",
516:             ["k"] = "move_cursor_up",
517:             ["<S-CR>"] = "close_keep_filter",
518:             ["<C-CR>"] = "close_clear_filter",
519:             ["<esc>"] = "close",
520:           }
521:         }
522:         -- ["<esc>"] = "noop", -- if you want to use normal mode
523:         -- ["key"] = function(state, scroll_padding) ... end,
524:       },
525:     },
526:     async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
527:                                    -- "always" means directory scans are always async.
528:                                    -- "never"  means directory scans are never async.
529:     scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
530:                            -- "deep": Scan into directories to detect empty or grouped empty directories a priori.
531:     bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
532:     cwd_target = {
533:       sidebar = "tab",   -- sidebar is when position = left or right
534:       current = "window" -- current is when position = current
535:     },
...
634:     show_unloaded = false,    -- When working with sessions, for example, restored but unfocused buffers
635:                               -- are mark as "unloaded". Turn this on to view these unloaded buffer.
636:     terminals_first = false,  -- when true, terminals will be listed before file buffers
637:     window = {
638:       mappings = {
639:         ["<bs>"] = "navigate_up",
640:         ["."] = "set_root",
641:         ["d"] = "buffer_delete",
642:         ["bd"] = "buffer_delete",
643:         ["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
644:         ["b"] = "rename_basename",
645:         ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
646:         ["oc"] = { "order_by_created", nowait = false },
647:         ["od"] = { "order_by_diagnostics", nowait = false },
648:         ["om"] = { "order_by_modified", nowait = false },
649:         ["on"] = { "order_by_name", nowait = false },
650:         ["os"] = { "order_by_size", nowait = false },
651:         ["ot"] = { "order_by_type", nowait = false },
652:       },
653:     },
654:   },
655:   git_status = {
656:     window = {
657:       mappings = {
658:         ["A"] = "git_add_all",
659:         ["gu"] = "git_unstage_file",
660:         ["gU"] = "git_undo_last_commit",
661:         ["ga"] = "git_add_file",
662:         ["gt"] = "git_toggle_file_stage",
663:         ["gr"] = "git_revert_file",
664:         ["gc"] = "git_commit",
665:         ["gp"] = "git_push",
666:         ["gg"] = "git_commit_and_push",
667:         ["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
668:         ["b"] = "rename_basename",
669:         ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
670:         ["oc"] = { "order_by_created", nowait = false },
671:         ["od"] = { "order_by_diagnostics", nowait = false },
672:         ["om"] = { "order_by_modified", nowait = false },
673:         ["on"] = { "order_by_name", nowait = false },
674:         ["os"] = { "order_by_size", nowait = false },
675:         ["ot"] = { "order_by_type", nowait = false },
676:       },
677:     },
678:   },
679:   document_symbols = {
680:     follow_cursor = false,
681:     follow_tree_cursor = false, -- Automatically show symbol location when moving cursor in the tree
682:     client_filters = "first",
683:     renderers = {
684:       root = {
685:         {"indent"},
686:         {"icon", default="C" },
687:         {"name", zindex = 10},
...
697:         }
698:       },
699:     },
700:     window = {
701:       mappings = {
702:         ["<cr>"] = "jump_to_symbol",
703:         ["o"] = "jump_to_symbol",
704:         ["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
705:         ["d"] = "noop",
706:         ["y"] = "noop",
707:         ["x"] = "noop",
708:         ["p"] = "noop",
709:         ["c"] = "noop",
710:         ["m"] = "noop",
711:         ["a"] = "noop",
712:         ["/"] = "filter",
713:         ["f"] = "filter_on_submit",
714:       },
715:     },
716:     custom_kinds = {
717:       -- define custom kinds here (also remember to add icon and hl group to kinds)
718:       -- ccls
719:       -- [252] = 'TypeAlias',
720:       -- [253] = 'Parameter',
721:       -- [254] = 'StaticMethod',
722:       -- [255] = 'Macro',
723:     },
724:     kinds = {
725:       Unknown = { icon = "?", hl = "" },
...
767:         {"name"}
768:       }
769:     },
770:     window = {
771:       mappings = {
772:         ["<cr>"] = "toggle_node",
773:         ["<C-e>"] = "example_command",
774:         ["d"] = "show_debug_info",
775:       },
776:     },
777:   },
778: }
779: return config
```

### ~/.local/share/nvim/lazy/nvim-dap-ui/lua/dapui/config/init.lua

```lua
...
79: ---@nodoc
80: local default_config = {
81:   wrap = false,
82:   icons = { expanded = "", collapsed = "", current_frame = "" },
83:   mappings = {
84:     -- Use a table to apply multiple mappings
85:     expand = { "<CR>", "<2-LeftMouse>" },
86:     open = "o",
87:     remove = "d",
88:     edit = "e",
89:     repl = "r",
90:     toggle = "t",
91:     watch = "w",
92:   },
93:   element_mappings = {},
94:   expand_lines = vim.fn.has("nvim-0.7") == 1,
95:   force_buffers = true,
96:   layouts = {
97:     {
98:       -- You can change the order of elements in the sidebar
99:       elements = {
100:         -- Provide IDs as strings or tables with "id" and "size" keys
101:         {
102:           id = "scopes",
103:           size = 0.25, -- Can be float or integer > 1
104:         },
105:         { id = "breakpoints", size = 0.25 },
...
121:   floating = {
122:     max_height = nil,
123:     max_width = nil,
124:     border = "single",
125:     mappings = {
126:       ["close"] = { "q", "<Esc>" },
127:     },
128:   },
129:   controls = {
130:     enabled = vim.fn.exists("+winbar") == 1,
131:     element = "repl",
132:     icons = {
133:       pause = "",
134:       play = "",
135:       step_into = "",
136:       step_over = "",
137:       step_out = "",
138:       step_back = "",
...
193: 
194:   if config.layouts then
195:     filled.layouts = config.layouts
196:   end
197:   filled.mappings = fill_mappings(filled.mappings)
198: 
199:   local element_mappings = {}
200:   for elem, mappings in pairs(filled.element_mappings) do
201:     element_mappings[elem] = fill_mappings(mappings)
202:   end
203: 
204:   filled.element_mappings = element_mappings
205:   filled.floating.mappings = fill_mappings(filled.floating.mappings)
206:   for i, layout in ipairs(filled.layouts) do
207:     filled.layouts[i] = fill_elements(layout)
208:   end
209: 
210:   user_config = filled
211:   require("dapui.config.highlights").setup()
212: end
213: 
214: function dapui.config._format_default()
215:   local lines = { "Default values:", ">lua" }
216:   for line in vim.gsplit(vim.inspect(default_config), "\n", true) do
217:     table.insert(lines, "  " .. line)
```

### ~/.local/share/nvim/lazy/aerial.nvim/lua/aerial/config.lua

```lua
...
43:   --   switch_buffer - close aerial when you change buffers in the source window
44:   --   unsupported   - close aerial when attaching to a buffer that has no symbol source
45:   close_automatic_events = {},
46: 
47:   -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
48:   -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
49:   -- Additionally, if it is a string that matches "actions.<name>",
50:   -- it will use the mapping at require("aerial.actions").<name>
51:   -- Set to `false` to remove a keymap
52:   keymaps = {
53:     ["?"] = "actions.show_help",
54:     ["g?"] = "actions.show_help",
55:     ["<CR>"] = "actions.jump",
56:     ["<2-LeftMouse>"] = "actions.jump",
57:     ["<C-v>"] = "actions.jump_vsplit",
58:     ["<C-s>"] = "actions.jump_split",
59:     ["p"] = "actions.scroll",
60:     ["<C-j>"] = "actions.down_and_scroll",
61:     ["<C-k>"] = "actions.up_and_scroll",
62:     ["{"] = "actions.prev",
63:     ["}"] = "actions.next",
64:     ["[["] = "actions.prev_up",
65:     ["]]"] = "actions.next_up",
66:     ["q"] = "actions.close",
67:     ["o"] = "actions.tree_toggle",
68:     ["za"] = "actions.tree_toggle",
69:     ["O"] = "actions.tree_toggle_recursive",
70:     ["zA"] = "actions.tree_toggle_recursive",
71:     ["l"] = "actions.tree_open",
72:     ["zo"] = "actions.tree_open",
73:     ["L"] = "actions.tree_open_recursive",
74:     ["zO"] = "actions.tree_open_recursive",
75:     ["h"] = "actions.tree_close",
76:     ["zc"] = "actions.tree_close",
77:     ["H"] = "actions.tree_close_recursive",
78:     ["zC"] = "actions.tree_close_recursive",
79:     ["zr"] = "actions.tree_increase_fold_level",
80:     ["zR"] = "actions.tree_open_all",
81:     ["zm"] = "actions.tree_decrease_fold_level",
82:     ["zM"] = "actions.tree_close_all",
83:     ["zx"] = "actions.tree_sync_folds",
84:     ["zX"] = "actions.tree_sync_folds",
85:   },
86: 
87:   -- When true, don't load aerial until a command or function is called
88:   -- Defaults to true, unless `on_attach` is provided, then it defaults to false
89:   lazy_load = true,
90: 
91:   -- Disable aerial on files with this many lines
92:   disable_max_lines = 10000,
93: 
94:   -- Disable aerial on files this size or larger (in bytes)
95:   disable_max_size = 2000000, -- Default 2MB
96: 
...
303:     autojump = false,
304:     -- Show a preview of the code in the right column, when there are no child symbols
305:     preview = false,
306:     -- Keymaps in the nav window
307:     keymaps = {
308:       ["<CR>"] = "actions.jump",
309:       ["<2-LeftMouse>"] = "actions.jump",
310:       ["<C-v>"] = "actions.jump_vsplit",
311:       ["<C-s>"] = "actions.jump_split",
312:       ["h"] = "actions.left",
313:       ["l"] = "actions.right",
314:       ["<C-c>"] = "actions.close",
315:     },
316:   },
317: 
318:   lsp = {
319:     -- If true, fetch document symbols when LSP diagnostics update.
320:     diagnostics_trigger_update = false,
321: 
322:     -- Set to false to not update the symbols when there are LSP errors
323:     update_when_errors = true,
324: 
325:     -- How long to wait (in ms) after a buffer change before updating
326:     -- Only used when diagnostics_trigger_update = false
```

### ~/.local/share/nvim/lazy/mini.surround/lua/mini/surround.lua

```lua
...
657: --- This module is primarily designed after 'machakann/vim-sandwich'. To get
658: --- behavior closest to 'tpope/vim-surround' (but not identical), use this setup: >lua
659: ---
660: ---   require('mini.surround').setup({
661: ---     mappings = {
662: ---       add = 'ys',
663: ---       delete = 'ds',
664: ---       find = '',
665: ---       find_left = '',
666: ---       highlight = '',
667: ---       replace = 'cs',
668: ---
669: ---       -- Add this only if you don't want to use extended mappings
670: ---       suffix_last = '',
671: ---       suffix_next = '',
672: ---     },
673: ---     search_method = 'cover_or_next',
674: ---   })
675: ---
676: ---   -- Remap adding surrounding to Visual mode selection
677: ---   vim.keymap.del('x', 'ys')
678: ---   vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
679: ---
680: ---   -- Make special mapping for "add surrounding for line"
681: ---   vim.keymap.set('n', 'yss', 'ys_', { remap = true })
682: --- <
683: MiniSurround.config = {
684:   -- Add custom surroundings to be used on top of builtin ones. For more
685:   -- information with examples, see `:h MiniSurround.config`.
686:   custom_surroundings = nil,
687: 
688:   -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
689:   highlight_duration = 500,
690: 
691:   -- Module mappings. Use `''` (empty string) to disable one.
692:   mappings = {
693:     add = 'sa', -- Add surrounding in Normal and Visual modes
694:     delete = 'sd', -- Delete surrounding
695:     find = 'sf', -- Find surrounding (to the right)
696:     find_left = 'sF', -- Find surrounding (to the left)
697:     highlight = 'sh', -- Highlight surrounding
698:     replace = 'sr', -- Replace surrounding
699: 
700:     suffix_last = 'l', -- Suffix to search with "prev" method
701:     suffix_next = 'n', -- Suffix to search with "next" method
702:   },
703: 
704:   -- Number of lines within which surrounding is searched
...
905: --- Update `MiniSurround.config.n_lines` from user input
906: ---
907: --- Mapping example: >lua
908: ---
909: ---   vim.keymap.set('n', 'sn', '<Cmd>lua MiniSurround.update_n_lines()<CR>')
910: --- <
911: MiniSurround.update_n_lines = function()
912:   local n_lines = MiniSurround.user_input('New number of neighbor lines', MiniSurround.config.n_lines)
913:   MiniSurround.config.n_lines = math.floor(tonumber(n_lines) or MiniSurround.config.n_lines)
914: end
915: 
916: --- Ask user for input
917: ---
918: --- This is mainly a wrapper for |input()| which allows empty string as input,
919: --- cancelling with `<Esc>` and `<C-c>`, and slightly modifies prompt. Use it
920: --- to ask for input inside function custom surrounding (see |MiniSurround.config|).
921: MiniSurround.user_input = function(prompt, text)
922:   -- Major issue with both `vim.fn.input()` is that the only way to distinguish
923:   -- cancelling with `<Esc>` and entering empty string with immediate `<CR>` is
924:   -- through `cancelreturn` option (see `:h input()`). In that case the return
925:   -- of `cancelreturn` will mean actual cancel, which removes possibility of
926:   -- using that string. Although doable with very obscure string, this is not
927:   -- very clean.
928:   -- Overcome this by adding temporary keystroke listener.
929:   local was_cancelled = false
930:   vim.on_key(function(key) was_cancelled = was_cancelled or key == '\27' end, H.ns_id.input)
931: 
932:   -- Ask for input. Use `pcall` to allow `<C-c>` to cancel user input
933:   -- NOTE: it would be GREAT to make this work with `vim.ui.input()` but I
934:   -- didn't find a way to make it work without major refactor of whole module.
935:   -- The main issue is that `vim.ui.input()` is designed to perform action in
936:   -- callback and current module design is to get output immediately. Although
937:   -- naive approach of
938:   -- `local res; vim.ui.input({...}, function(input) res = input end)`
939:   -- works in default `vim.ui.input`, its reimplementations can return from it
940:   -- immediately and proceed in main event loop. Couldn't find a relatively
941:   -- simple way to stop execution of this current function until `ui.input()`'s
942:   -- callback finished execution.
943:   vim.cmd('echohl Question')
944:   local ok, res = pcall(vim.fn.input, { prompt = '(mini.surround) ' .. prompt .. ': ', default = text or '' })
...
1206:   local m = function(mode, lhs, rhs, desc) H.map(mode, lhs, rhs, { expr = true, desc = desc }) end
1207: 
1208:   --stylua: ignore start
1209:   m('n', maps.add, H.make_operator('add', nil, true), 'Add surrounding')
1210:   H.map('x', maps.add, ':<C-u>lua MiniSurround.add("visual")<CR>', { desc = 'Add surrounding to selection' })
1211: 
1212:   m('n', maps.delete,   H.make_operator('delete', nil),    'Delete surrounding')
1213:   m('n', maps_l.delete, H.make_operator('delete', 'prev'), 'Delete previous surrounding')
1214:   m('n', maps_n.delete, H.make_operator('delete', 'next'), 'Delete next surrounding')
1215: 
1216:   m('n', maps.replace,   H.make_operator('replace', nil),    'Replace surrounding')
1217:   m('n', maps_l.replace, H.make_operator('replace', 'prev'), 'Replace previous surrounding')
1218:   m('n', maps_n.replace, H.make_operator('replace', 'next'), 'Replace next surrounding')
1219: 
1220:   m('n', maps.find,   H.make_action('find', 'right', nil),    'Find right surrounding')
1221:   m('x', maps.find,   H.make_action('find', 'right', nil),    'Find right surrounding')
1222:   m('o', maps.find,   H.make_action('find', 'right', nil),    'Find right surrounding')
...
2022:   local ok, char = pcall(vim.fn.getcharstr)
2023:   needs_reminder = false
2024:   H.unecho()
2025: 
2026:   -- Terminate if couldn't get input (like with <C-c>) or it is `<Esc>`
2027:   if not ok or char == '\27' then return nil end
2028:   return char
2029: end
2030: 
2031: -- Work with positions --------------------------------------------------------
2032: H.pos_to_left = function(pos)
2033:   if pos.line == 1 and pos.col == 1 then return { line = pos.line, col = pos.col } end
2034:   if pos.col == 1 then return { line = pos.line - 1, col = H.get_line_cols(pos.line - 1) } end
2035:   return { line = pos.line, col = pos.col - 1 }
2036: end
2037: 
2038: H.pos_to_right = function(pos)
...
2293: 
2294: H.map = function(mode, lhs, rhs, opts)
2295:   if lhs == '' then return end
2296:   opts = vim.tbl_deep_extend('force', { silent = true }, opts or {})
2297:   vim.keymap.set(mode, lhs, rhs, opts)
2298:   local no_global_s_mapping = not H.has_global_mapping(mode, 's')
2299:   if no_global_s_mapping and lhs:find('^s.') ~= nil then vim.keymap.set(mode, 's', '<Nop>') end
2300: end
2301: 
2302: H.has_global_mapping = function(mode, lhs)
2303:   for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
2304:     if map.lhs == lhs then return true end
2305:   end
2306:   return false
2307: end
2308: 
2309: H.get_line_cols = function(line_num) return vim.fn.getline(line_num):len() end
2310: 
2311: H.string_find = function(s, pattern, init)
2312:   init = init or 1
2313: 
2314:   -- Match only start of full string if pattern says so.
2315:   -- This is needed because `string.find()` doesn't do this.
```

### ~/.local/share/nvim/lazy/CopilotChat.nvim/lua/CopilotChat/config.lua

```lua
...
137:   -- default prompts
138:   prompts = require('CopilotChat.config.prompts'),
139: 
140:   -- default mappings
141:   mappings = require('CopilotChat.config.mappings'),
142: }
```

## Neovim built-in commands

Installed Neovim command index, including unmodified Normal/Visual/Insert/command-line commands. Custom mappings above can replace these. Ex commands are included for completeness; this is the installed reference rather than a claim that each command has a custom key.

### /usr/share/nvim/runtime/doc/index.txt

```text
*index.txt*     Nvim


		  VIM REFERENCE MANUAL	  by Bram Moolenaar

								*index*
This file contains a list of all commands for each mode, with a tag and a
short description.  The lists are sorted on ASCII value.

Tip: When looking for certain functionality, use a search command.  E.g.,
to look for deleting something, use: "/delete".

For an overview of options see |option-list|.
For an overview of built-in functions see |functions|.
For a list of Vim variables see |vim-variable|.

                                      Type |gO| to see the table of contents.

==============================================================================
1. Insert mode						*insert-index*

Tag		Char		Insert-mode action	~
------------------------------------------------------------------------------ ~
|i_CTRL-@|	CTRL-@		insert previously inserted text and stop
				insert
|i_CTRL-A|	CTRL-A		insert previously inserted text
|i_CTRL-C|	CTRL-C		quit insert mode, without checking for
				abbreviation
|i_CTRL-D|	CTRL-D		delete one shiftwidth of indent in the current
				line
|i_CTRL-E|	CTRL-E		insert the character which is below the cursor
		CTRL-F		not used (but by default it's in 'cinkeys' to
				re-indent the current line)
|i_CTRL-G_j|	CTRL-G CTRL-J	line down, to column where inserting started
|i_CTRL-G_j|	CTRL-G j	line down, to column where inserting started
|i_CTRL-G_j|	CTRL-G <Down>	line down, to column where inserting started
|i_CTRL-G_k|	CTRL-G CTRL-K	line up, to column where inserting started
|i_CTRL-G_k|	CTRL-G k	line up, to column where inserting started
|i_CTRL-G_k|	CTRL-G <Up>	line up, to column where inserting started
|i_CTRL-G_u|	CTRL-G u	start new undoable edit
|i_CTRL-G_U|	CTRL-G U	don't break undo with next cursor movement
|i_<BS>|	<BS>		delete character before the cursor
|i_digraph|	{char1}<BS>{char2}
				enter digraph (only when 'digraph' option set)
|i_CTRL-H|	CTRL-H		same as <BS>
|i_<Tab>|	<Tab>		insert a <Tab> character
|i_CTRL-I|	CTRL-I		same as <Tab>
|i_<NL>|	<NL>		same as <CR>
|i_CTRL-J|	CTRL-J		same as <CR>
|i_CTRL-K|	CTRL-K {char1} {char2}
				enter digraph
|i_<CR>|	<CR>		begin new line
|i_CTRL-M|	CTRL-M		same as <CR>
|i_CTRL-N|	CTRL-N		find next match for keyword in front of the
				cursor
|i_CTRL-O|	CTRL-O		execute a single command and return to insert
				mode
|i_CTRL-P|	CTRL-P		find previous match for keyword in front of
				the cursor
|i_CTRL-Q|	CTRL-Q		same as CTRL-V, unless used for terminal
				control flow
|i_CTRL-SHIFT-Q|  CTRL-SHIFT-Q {char}
				like CTRL-Q unless |tui-modifyOtherKeys| is active
|i_CTRL-R|	CTRL-R {register}
				insert the contents of a register
|i_CTRL-R_CTRL-R| CTRL-R CTRL-R {register}
				insert the contents of a register literally
|i_CTRL-R_CTRL-O| CTRL-R CTRL-O {register}
				insert the contents of a register literally
				and don't auto-indent
|i_CTRL-R_CTRL-P| CTRL-R CTRL-P {register}
				insert the contents of a register literally
				and fix indent.
		CTRL-S		not used or used for terminal control flow
|i_CTRL-T|	CTRL-T		insert one shiftwidth of indent in current
				line
|i_CTRL-U|	CTRL-U		delete all entered characters in the current
				line
|i_CTRL-V|	CTRL-V {char}	insert next non-digit literally
|i_CTRL-SHIFT-V|  CTRL-SHIFT-V {char}
				like CTRL-V unless |tui-modifyOtherKeys| is active
|i_CTRL-V_digit| CTRL-V {number} insert three digit decimal number as a single
				byte.
|i_CTRL-W|	CTRL-W		delete word before the cursor
|i_CTRL-X|	CTRL-X {mode}	enter CTRL-X sub mode, see |i_CTRL-X_index|
|i_CTRL-Y|	CTRL-Y		insert the character which is above the cursor
|i_<Esc>|	<Esc>		end insert mode
|i_CTRL-[|	CTRL-[		same as <Esc>
|i_CTRL-\_CTRL-N| CTRL-\ CTRL-N	go to Normal mode
|i_CTRL-\_CTRL-G| CTRL-\ CTRL-G	go to Normal mode
		CTRL-\ a - z	reserved for extensions
		CTRL-\ others	not used
|i_CTRL-]|	CTRL-]		trigger abbreviation
|i_CTRL-^|	CTRL-^		toggle use of |:lmap| mappings
|i_CTRL-_|	CTRL-_		When 'allowrevins' set: toggle 'revins'

		<Space> to '~'	not used, except '0' and '^' followed by
				CTRL-D

|i_0_CTRL-D|	0 CTRL-D	delete all indent in the current line
|i_^_CTRL-D|	^ CTRL-D	delete all indent in the current line, restore
				it in the next line

|i_<Del>|	<Del>		delete character under the cursor

		Meta characters (0x80 to 0xff, 128 to 255)
				not used

|i_<Left>|	<Left>		cursor one character left
|i_<S-Left>|	<S-Left>	cursor one word left
|i_<C-Left>|	<C-Left>	cursor one word left
|i_<Right>|	<Right>		cursor one character right
|i_<S-Right>|	<S-Right>	cursor one word right
|i_<C-Right>|	<C-Right>	cursor one word right
|i_<Up>|	<Up>		cursor one line up
|i_<S-Up>|	<S-Up>		same as <PageUp>
|i_<Down>|	<Down>		cursor one line down
|i_<S-Down>|	<S-Down>	same as <PageDown>
|i_<Home>|	<Home>		cursor to start of line
|i_<C-Home>|	<C-Home>	cursor to start of file
|i_<End>|	<End>		cursor past end of line
|i_<C-End>|	<C-End>		cursor past end of file
|i_<PageUp>|	<PageUp>	one screenful backward
|i_<PageDown>|	<PageDown>	one screenful forward
|i_<F1>|	<F1>		same as <Help>
|i_<Help>|	<Help>		stop insert mode and display help window
|i_<Insert>|	<Insert>	toggle Insert/Replace mode
|i_<LeftMouse>|	<LeftMouse>	cursor at mouse click
|i_<ScrollWheelDown>|	<ScrollWheelDown>	move window three lines down
|i_<S-ScrollWheelDown>|	<S-ScrollWheelDown>	move window one page down
|i_<ScrollWheelUp>|	<ScrollWheelUp>		move window three lines up
|i_<S-ScrollWheelUp>|	<S-ScrollWheelUp>	move window one page up
|i_<ScrollWheelLeft>|	<ScrollWheelLeft>	move window six columns left
|i_<S-ScrollWheelLeft>|	<S-ScrollWheelLeft>	move window one page left
|i_<ScrollWheelRight>|	<ScrollWheelRight>	move window six columns right
|i_<S-ScrollWheelRight>| <S-ScrollWheelRight>	move window one page right

commands in CTRL-X submode				*i_CTRL-X_index*

|i_CTRL-X_CTRL-D|	CTRL-X CTRL-D	complete defined identifiers
|i_CTRL-X_CTRL-E|	CTRL-X CTRL-E	scroll up
|i_CTRL-X_CTRL-F|	CTRL-X CTRL-F	complete file names
|i_CTRL-X_CTRL-I|	CTRL-X CTRL-I	complete identifiers
|i_CTRL-X_CTRL-K|	CTRL-X CTRL-K	complete identifiers from dictionary
|i_CTRL-X_CTRL-L|	CTRL-X CTRL-L	complete whole lines
|i_CTRL-X_CTRL-N|	CTRL-X CTRL-N	next completion
|i_CTRL-X_CTRL-O|	CTRL-X CTRL-O	omni completion
|i_CTRL-X_CTRL-P|	CTRL-X CTRL-P	previous completion
|i_CTRL-X_CTRL-R|	CTRL-X CTRL-R	complete contents from registers
|i_CTRL-X_CTRL-S|	CTRL-X CTRL-S	spelling suggestions
|i_CTRL-X_CTRL-T|	CTRL-X CTRL-T	complete identifiers from thesaurus
|i_CTRL-X_CTRL-Y|	CTRL-X CTRL-Y	scroll down
|i_CTRL-X_CTRL-U|	CTRL-X CTRL-U	complete with 'completefunc'
|i_CTRL-X_CTRL-V|	CTRL-X CTRL-V	complete like in : command line
|i_CTRL-X_CTRL-Z|	CTRL-X CTRL-Z	stop completion, text is unchanged
|i_CTRL-X_CTRL-]|	CTRL-X CTRL-]	complete tags
|i_CTRL-X_s|		CTRL-X s	spelling suggestions

commands in completion mode (see |popupmenu-keys|)

|complete_CTRL-E| CTRL-E	stop completion and go back to original text
|complete_CTRL-Y| CTRL-Y	accept selected match and stop completion
		CTRL-L		insert one character from the current match
		<CR>		insert currently selected match
		<BS>		delete one character and redo search
		CTRL-H		same as <BS>
		<Up>		select the previous match
		<Down>		select the next match
		<PageUp>	select a match several entries back
		<PageDown>	select a match several entries forward
		other		stop completion and insert the typed character

==============================================================================
2. Normal mode						*normal-index*

CHAR	 any non-blank character
WORD	 a sequence of non-blank characters
N	 a number entered before the command
{motion} a cursor movement command
Nmove	 the text that is moved over with a {motion}
SECTION	 a section that possibly starts with '}' instead of '{'

note: 1 = cursor movement command; 2 = can be undone/redone

Tag		Char	      Note Normal-mode action	~
------------------------------------------------------------------------------ ~
		CTRL-@		   not used
|CTRL-A|	CTRL-A		2  add N to number at/after cursor
|CTRL-B|	CTRL-B		1  scroll N screens Backwards
|CTRL-C|	CTRL-C		   interrupt current (search) command
|CTRL-D|	CTRL-D		   scroll Down N lines (default: half a screen)
|CTRL-E|	CTRL-E		   scroll N lines upwards (N lines Extra)
|CTRL-F|	CTRL-F		1  scroll N screens Forward
|CTRL-G|	CTRL-G		   display current file name and position
|<BS>|		<BS>		1  same as "h"
|CTRL-H|	CTRL-H		1  same as "h"
|<Tab>|		<Tab>		1  go to N newer entry in jump list
|CTRL-I|	CTRL-I		1  same as <Tab>
|<NL>|		<NL>		1  same as "j"
|<S-NL>|	<S-NL>		1  same as CTRL-F
|CTRL-J|	CTRL-J		1  same as "j"
		CTRL-K		   not used
|CTRL-L|	CTRL-L		   redraw screen
|<CR>|		<CR>		1  cursor to the first CHAR N lines lower
|<S-CR>|	<S-CR>		1  same as CTRL-F
|CTRL-M|	CTRL-M		1  same as <CR>
|CTRL-N|	CTRL-N		1  same as "j"
|CTRL-O|	CTRL-O		1  go to N older entry in jump list
|CTRL-P|	CTRL-P		1  same as "k"
		CTRL-Q		   not used, or used for terminal control flow
|CTRL-R|	CTRL-R		2  redo changes which were undone with 'u'
		CTRL-S		   not used, or used for terminal control flow
|CTRL-T|	CTRL-T		   jump to N older Tag in tag list
|CTRL-U|	CTRL-U		   scroll N lines Upwards (default: half a
				   screen)
|CTRL-V|	CTRL-V		   start blockwise Visual mode
|CTRL-W|	CTRL-W {char}	   window commands, see |CTRL-W|
|CTRL-X|	CTRL-X		2  subtract N from number at/after cursor
|CTRL-Y|	CTRL-Y		   scroll N lines downwards
|CTRL-Z|	CTRL-Z		   suspend program (or start new shell)
		CTRL-[ <Esc>	   not used
|CTRL-\_CTRL-N|	CTRL-\ CTRL-N	   go to Normal mode (no-op)
|CTRL-\_CTRL-G|	CTRL-\ CTRL-G	   go to Normal mode (no-op)
		CTRL-\ a - z	   reserved for extensions
		CTRL-\ others	   not used
|CTRL-]|	CTRL-]		   :ta to ident under cursor
|CTRL-^|	CTRL-^		   edit Nth alternate file (equivalent to
				   ":e #N")
|CTRL-<Tab>|	CTRL-<Tab>	   same as `g<Tab>` : go to last accessed tab
				   page
		CTRL-_		   not used

|<Space>|	<Space>		1  same as "l"
|!|		!{motion}{filter}
				2  filter Nmove text through the {filter}
				   command
|!!|		!!{filter}	2  filter N lines through the {filter} command
|quote|		"{register}	   use {register} for next delete, yank or put
				   ({.%#:} only work with put)
|#|		#		1  search backward for the Nth occurrence of
				   the ident under the cursor
|$|		$		1  cursor to the end of Nth next line
|%|		%		1  find the next (curly/square) bracket on
				   this line and go to its match, or go to
				   matching comment bracket, or go to matching
				   preprocessor directive.
|N%|		{count}%	1  go to N percentage in the file
|&|		&		2  repeat last :s
|'|		'{a-zA-Z0-9}	1  cursor to the first CHAR on the line with
				   mark {a-zA-Z0-9}
|''|		''		1  cursor to the first CHAR of the line where
				   the cursor was before the latest jump.
|'(|		'(		1  cursor to the first CHAR on the line of the
				   start of the current sentence
|')|		')		1  cursor to the first CHAR on the line of the
				   end of the current sentence
|'<|		'<		1  cursor to the first CHAR of the line where
				   highlighted area starts/started in the
				   current buffer.
|'>|		'>		1  cursor to the first CHAR of the line where
				   highlighted area ends/ended in the current
				   buffer.
|'[|		'[		1  cursor to the first CHAR on the line of the
				   start of last operated text or start of put
				   text
|']|		']		1  cursor to the first CHAR on the line of the
				   end of last operated text or end of put
				   text
|'{|		'{		1  cursor to the first CHAR on the line of the
				   start of the current paragraph
|'}|		'}		1  cursor to the first CHAR on the line of the
				   end of the current paragraph
|(|		(		1  cursor N sentences backward
|)|		)		1  cursor N sentences forward
|star|		*		1  search forward for the Nth occurrence of
				   the ident under the cursor
|+|		+		1  same as <CR>
|<S-Plus>|	<S-+>		1  same as CTRL-F
|,|		,		1  repeat latest f, t, F or T in opposite
				   direction N times
|-|		-		1  cursor to the first CHAR N lines higher
|<S-Minus>|	<S-->		1  same as CTRL-B
|.|		.		2  repeat last change with count replaced with
				   N
|/|		/{pattern}<CR>	1  search forward for the Nth occurrence of
				   {pattern}
|/<CR>|		/<CR>		1  search forward for {pattern} of last search
|0|		0		1  cursor to the first char of the line
|count|		1		   prepend to command to give a count
|count|		2			"
|count|		3			"
|count|		4			"
|count|		5			"
|count|		6			"
|count|		7			"
|count|		8			"
|count|		9			"
|:|		:		1  start entering an Ex command
|N:|		{count}:	   start entering an Ex command with range
				   from current line to N-1 lines down
|;|		;		1  repeat latest f, t, F or T N times
|<|		<{motion}	2  shift Nmove lines one 'shiftwidth'
				   leftwards
|<<|		<<		2  shift N lines one 'shiftwidth' leftwards
|=|		={motion}	2  filter Nmove lines through "indent"
|==|		==		2  filter N lines through "indent"
|>|		>{motion}	2  shift Nmove lines one 'shiftwidth'
				   rightwards
|>>|		>>		2  shift N lines one 'shiftwidth' rightwards
|?|		?{pattern}<CR>	1  search backward for the Nth previous
				   occurrence of {pattern}
|?<CR>|		?<CR>		1  search backward for {pattern} of last search
|@|		@{a-z}		2  execute the contents of register {a-z}
				   N times
|@:|		@:		   repeat the previous ":" command N times
|@@|		@@		2  repeat the previous @{a-z} N times
|A|		A		2  append text after the end of the line N times
|B|		B		1  cursor N WORDS backward
|C|		["x]C		2  change from the cursor position to the end
				   of the line, and N-1 more lines [into
				   register x]; synonym for "c$"
|D|		["x]D		2  delete the characters under the cursor
				   until the end of the line and N-1 more
				   lines [into register x]; synonym for "d$"
|E|		E		1  cursor forward to the end of WORD N
|F|		F{char}		1  cursor to the Nth occurrence of {char} to
				   the left
|G|		G		1  cursor to line N, default last line
|H|		H		1  cursor to line N from top of screen
|I|		I		2  insert text before the first CHAR on the
				   line N times
|J|		J		2  Join N lines; default is 2
|K|		K		   lookup Keyword under the cursor with
				   'keywordprg'
|L|		L		1  cursor to line N from bottom of screen
|M|		M		1  cursor to middle line of screen
|N|		N		1  repeat the latest '/' or '?' N times in
				   opposite direction
|O|		O		2  begin a new line above the cursor and
				   insert text, repeat N times
|P|		["x]P		2  put the text [from register x] before the
				   cursor N times
|R|		R		2  enter replace mode: overtype existing
				   characters, repeat the entered text N-1
				   times
|S|		["x]S		2  delete N lines [into register x] and start
				   insert; synonym for "cc".
|T|		T{char}		1  cursor till after Nth occurrence of {char}
				   to the left
|U|		U		2  undo all latest changes on one line
|V|		V		   start linewise Visual mode
|W|		W		1  cursor N WORDS forward
|X|		["x]X		2  delete N characters before the cursor [into
				   register x]
|Y|		["x]Y		   yank N lines [into register x]; synonym for
				   "yy"
				   Note: Mapped to "y$" by default. |default-mappings|
|ZZ|		ZZ		   write if buffer changed and close window
|ZQ|		ZQ		   close window without writing
|[|		[{char}		   square bracket command (see |[| below)
		\		   not used
|]|		]{char}		   square bracket command (see |]| below)
|^|		^		1  cursor to the first CHAR of the line
|_|		_		1  cursor to the first CHAR N - 1 lines lower
|`|		`{a-zA-Z0-9}	1  cursor to the mark {a-zA-Z0-9}
|`(|		`(		1  cursor to the start of the current sentence
|`)|		`)		1  cursor to the end of the current sentence
|`<|		`<		1  cursor to the start of the highlighted area
|`>|		`>		1  cursor to the end of the highlighted area
|`[|		`[		1  cursor to the start of last operated text
				   or start of putted text
|`]|		`]		1  cursor to the end of last operated text or
				   end of putted text
|``|		"``"		1  cursor to the position before latest jump
|`{|		`{		1  cursor to the start of the current paragraph
|`}|		`}		1  cursor to the end of the current paragraph
|a|		a		2  append text after the cursor N times
|b|		b		1  cursor N words backward
|c|		["x]c{motion}	2  delete Nmove text [into register x] and
				   start insert
|cc|		["x]cc		2  delete N lines [into register x] and start
				   insert
|d|		["x]d{motion}	2  delete Nmove text [into register x]
|dd|		["x]dd		2  delete N lines [into register x]
|do|		do		2  same as ":diffget"
|dp|		dp		2  same as ":diffput"
|e|		e		1  cursor forward to the end of word N
|f|		f{char}		1  cursor to Nth occurrence of {char} to the
				   right
|g|		g{char}		   extended commands, see |g| below
|h|		h		1  cursor N chars to the left
|i|		i		2  insert text before the cursor N times
|j|		j		1  cursor N lines downward
|k|		k		1  cursor N lines upward
|l|		l		1  cursor N chars to the right
|m|		m{A-Za-z}	   set mark {A-Za-z} at cursor position
|n|		n		1  repeat the latest '/' or '?' N times
|o|		o		2  begin a new line below the cursor and
				   insert text, repeat N times
|p|		["x]p		2  put the text [from register x] after the
				   cursor N times
|q|		q{0-9a-zA-Z"}	   record typed characters into named register
				   {0-9a-zA-Z"} (uppercase to append)
|q|		q		   (while recording) stops recording
|Q|		Q		2  replay last recorded register
|q:|		q:		   edit : command-line in command-line window
|q/|		q/		   edit / command-line in command-line window
|q?|		q?		   edit ? command-line in command-line window
|r|		r{char}		2  replace N chars with {char}
|s|		["x]s		2  (substitute) delete N characters [into
				   register x] and start insert
|t|		t{char}		1  cursor till before Nth occurrence of {char}
				   to the right
|u|		u		2  undo changes
|v|		v		   start charwise Visual mode
|w|		w		1  cursor N words forward
|x|		["x]x		2  delete N characters under and after the
				   cursor [into register x]
|y|		["x]y{motion}	   yank Nmove text [into register x]
|yy|		["x]yy		   yank N lines [into register x]
|z|		z{char}		   commands starting with 'z', see |z| below
|{|		{		1  cursor N paragraphs backward
|bar|		|		1  cursor to column N
|}|		}		1  cursor N paragraphs forward
|~|		~		2  'tildeop' off: switch case of N characters
				   under cursor and move the cursor N
				   characters to the right
|~|		~{motion}	   'tildeop' on: switch case of Nmove text
|<C-End>|	<C-End>		1  same as "G"
|<C-Home>|	<C-Home>	1  same as "gg"
|<C-Left>|	<C-Left>	1  same as "b"
|<C-LeftMouse>|	<C-LeftMouse>	   ":ta" to the keyword at the mouse click
|<C-Right>|	<C-Right>	1  same as "w"
|<C-RightMouse>| <C-RightMouse>	   same as "CTRL-T"
|<C-Tab>|	<C-Tab>		   same as "g<Tab>"
|<Del>|		["x]<Del>	2  same as "x"
|N<Del>|	{count}<Del>	   remove the last digit from {count}
|<Down>|	<Down>		1  same as "j"
|<End>|		<End>		1  same as "$"
|<F1>|		<F1>		   same as <Help>
|<Help>|	<Help>		   open a help window
|<Home>|	<Home>		1  same as "0"
|<Insert>|	<Insert>	2  same as "i"
|<Left>|	<Left>		1  same as "h"
|<LeftMouse>|	<LeftMouse>	1  move cursor to the mouse click position
|<MiddleMouse>|	<MiddleMouse>	2  same as "gP" at the mouse click position
|<PageDown>|	<PageDown>	   same as CTRL-F
|<PageUp>|	<PageUp>	   same as CTRL-B
|<Right>|	<Right>		1  same as "l"
|<RightMouse>|	<RightMouse>	   start Visual mode, move cursor to the mouse
				   click position
|<S-Down>|	<S-Down>	1  same as CTRL-F
|<S-Left>|	<S-Left>	1  same as "b"
|<S-LeftMouse>|	<S-LeftMouse>	   same as "*" at the mouse click position
|<S-Right>|	<S-Right>	1  same as "w"
|<S-RightMouse>| <S-RightMouse>	   same as "#" at the mouse click position
|<S-Up>|	<S-Up>		1  same as CTRL-B
|<Undo>|	<Undo>		2  same as "u"
|<Up>|		<Up>		1  same as "k"
*<ScrollWheelDown>*	<ScrollWheelDown>	move window three lines down
*<S-ScrollWheelDown>*	<S-ScrollWheelDown>	move window one page down
*<ScrollWheelUp>*	<ScrollWheelUp>		move window three lines up
*<S-ScrollWheelUp>*	<S-ScrollWheelUp>	move window one page up
*<ScrollWheelLeft>*	<ScrollWheelLeft>	move window six columns left
*<S-ScrollWheelLeft>*	<S-ScrollWheelLeft>	move window one page left
*<ScrollWheelRight>*	<ScrollWheelRight>	move window six columns right
*<S-ScrollWheelRight>*	<S-ScrollWheelRight>	move window one page right

==============================================================================
2.1 Text objects						*objects*

These can be used after an operator or in Visual mode to select an object.

Tag		Command		   Op-pending and Visual-mode action	~
------------------------------------------------------------------------------ ~
|v_aquote|	a"		   double quoted string
|v_a'|		a'		   single quoted string
|v_a(|		a(		   same as ab
|v_a)|		a)		   same as ab
|v_a<|		a<		   "a <>" from '<' to the matching '>'
|v_a>|		a>		   same as a<
|v_aB|		aB		   "a Block" from `[{` to `]}` (with brackets)
|v_aW|		aW		   "a WORD" (with white space)
|v_a[|		a[		   "a []" from '[' to the matching ']'
|v_a]|		a]		   same as a[
|v_a`|		a`		   string in backticks
|v_ab|		ab		   "a block" from "[(" to "])" (with braces)
|v_ap|		ap		   "a paragraph" (with white space)
|v_as|		as		   "a sentence" (with white space)
|v_at|		at		   "a tag block" (with white space)
|v_aw|		aw		   "a word" (with white space)
|v_a{|		a{		   same as aB
|v_a}|		a}		   same as aB
|v_iquote|	i"		   double quoted string without the quotes
|v_i'|		i'		   single quoted string without the quotes
|v_i(|		i(		   same as ib
|v_i)|		i)		   same as ib
|v_i<|		i<		   "inner <>" from '<' to the matching '>'
|v_i>|		i>		   same as i<
|v_iB|		iB		   "inner Block" from `[{` and `]}`
|v_iW|		iW		   "inner WORD"
|v_i[|		i[		   "inner []" from '[' to the matching ']'
|v_i]|		i]		   same as i[
|v_i`|		i`		   string in backticks without the backticks
|v_ib|		ib		   "inner block" from "[(" to "])"
|v_ip|		ip		   "inner paragraph"
|v_is|		is		   "inner sentence"
|v_it|		it		   "inner tag block"
|v_iw|		iw		   "inner word"
|v_i{|		i{		   same as iB
|v_i}|		i}		   same as iB

==============================================================================
2.2 Window commands						*CTRL-W*

Tag		Command		   Normal-mode action	~
------------------------------------------------------------------------------ ~
|CTRL-W_CTRL-B|	CTRL-W CTRL-B	   same as "CTRL-W b"
|CTRL-W_CTRL-C|	CTRL-W CTRL-C	   no-op
|CTRL-W_CTRL-D|	CTRL-W CTRL-D	   same as "CTRL-W d"
|CTRL-W_CTRL-F|	CTRL-W CTRL-F	   same as "CTRL-W f"
		CTRL-W CTRL-G	   same as "CTRL-W g .."
|CTRL-W_CTRL-H|	CTRL-W CTRL-H	   same as "CTRL-W h"
|CTRL-W_CTRL-I|	CTRL-W CTRL-I	   same as "CTRL-W i"
|CTRL-W_CTRL-J|	CTRL-W CTRL-J	   same as "CTRL-W j"
|CTRL-W_CTRL-K|	CTRL-W CTRL-K	   same as "CTRL-W k"
|CTRL-W_CTRL-L|	CTRL-W CTRL-L	   same as "CTRL-W l"
|CTRL-W_CTRL-N|	CTRL-W CTRL-N	   same as "CTRL-W n"
|CTRL-W_CTRL-O|	CTRL-W CTRL-O	   same as "CTRL-W o"
|CTRL-W_CTRL-P|	CTRL-W CTRL-P	   same as "CTRL-W p"
|CTRL-W_CTRL-Q|	CTRL-W CTRL-Q	   same as "CTRL-W q"
|CTRL-W_CTRL-R|	CTRL-W CTRL-R	   same as "CTRL-W r"
|CTRL-W_CTRL-S|	CTRL-W CTRL-S	   same as "CTRL-W s"
|CTRL-W_CTRL-T|	CTRL-W CTRL-T	   same as "CTRL-W t"
|CTRL-W_CTRL-V|	CTRL-W CTRL-V	   same as "CTRL-W v"
|CTRL-W_CTRL-W|	CTRL-W CTRL-W	   same as "CTRL-W w"
|CTRL-W_CTRL-X|	CTRL-W CTRL-X	   same as "CTRL-W x"
|CTRL-W_CTRL-Z|	CTRL-W CTRL-Z	   same as "CTRL-W z"
|CTRL-W_CTRL-]|	CTRL-W CTRL-]	   same as "CTRL-W ]"
|CTRL-W_CTRL-^|	CTRL-W CTRL-^	   same as "CTRL-W ^"
|CTRL-W_CTRL-_|	CTRL-W CTRL-_	   same as "CTRL-W _"
|CTRL-W_+|	CTRL-W +	   increase current window height N lines
|CTRL-W_-|	CTRL-W -	   decrease current window height N lines
|CTRL-W_<|	CTRL-W <	   decrease current window width N columns
|CTRL-W_=|	CTRL-W =	   make all windows the same height & width
|CTRL-W_>|	CTRL-W >	   increase current window width N columns
|CTRL-W_H|	CTRL-W H	   move current window to the far left
|CTRL-W_J|	CTRL-W J	   move current window to the very bottom
|CTRL-W_K|	CTRL-W K	   move current window to the very top
|CTRL-W_L|	CTRL-W L	   move current window to the far right
|CTRL-W_P|	CTRL-W P	   go to preview window
|CTRL-W_R|	CTRL-W R	   rotate windows upwards N times
|CTRL-W_S|	CTRL-W S	   same as "CTRL-W s"
|CTRL-W_T|	CTRL-W T	   move current window to a new tabpage
|CTRL-W_W|	CTRL-W W	   go to N previous window (wrap around)
|CTRL-W_]|	CTRL-W ]	   split window and jump to tag under cursor
|CTRL-W_^|	CTRL-W ^	   split current window and edit alternate
				   file N
|CTRL-W__|	CTRL-W _	   set current window height to N (default:
				   very high)
|CTRL-W_b|	CTRL-W b	   go to bottom window
|CTRL-W_c|	CTRL-W c	   close current window (like |:close|)
|CTRL-W_d|	CTRL-W d	   split window and jump to definition under
				   the cursor
|CTRL-W_f|	CTRL-W f	   split window and edit file name under the
				   cursor
|CTRL-W_F|	CTRL-W F	   split window and edit file name under the
				   cursor and jump to the line number
				   following the file name.
|CTRL-W_g_CTRL-]| CTRL-W g CTRL-]  split window and do |:tjump| to tag under
				   cursor
|CTRL-W_g]|	CTRL-W g ]	   split window and do |:tselect| for tag
				   under cursor
|CTRL-W_g}|	CTRL-W g }	   do a |:ptjump| to the tag under the cursor
|CTRL-W_gf|	CTRL-W g f	   edit file name under the cursor in a new
				   tabpage
|CTRL-W_gF|	CTRL-W g F	   edit file name under the cursor in a new
				   tabpage and jump to the line number
				   following the file name.
|CTRL-W_gt|	CTRL-W g t	   same as `gt`: go to next tabpage
|CTRL-W_gT|	CTRL-W g T	   same as `gT`: go to previous tabpage
|CTRL-W_g<Tab>|	CTRL-W g <Tab>	   same as |g<Tab>|: go to last accessed tab
				   page
|CTRL-W_h|	CTRL-W h	   go to Nth left window (stop at first window)
|CTRL-W_i|	CTRL-W i	   split window and jump to declaration of
				   identifier under the cursor
|CTRL-W_j|	CTRL-W j	   go N windows down (stop at last window)
|CTRL-W_k|	CTRL-W k	   go N windows up (stop at first window)
|CTRL-W_l|	CTRL-W l	   go to Nth right window (stop at last window)
|CTRL-W_n|	CTRL-W n	   open new window, N lines high
|CTRL-W_o|	CTRL-W o	   close all but current window (like |:only|)
|CTRL-W_p|	CTRL-W p	   go to previous (last accessed) window
|CTRL-W_q|	CTRL-W q	   quit current window (like |:quit|)
|CTRL-W_r|	CTRL-W r	   rotate windows downwards N times
|CTRL-W_s|	CTRL-W s	   split current window in two parts, new
				   window N lines high
|CTRL-W_t|	CTRL-W t	   go to top window
|CTRL-W_v|	CTRL-W v	   split current window vertically, new window
				   N columns wide
|CTRL-W_w|	CTRL-W w	   go to N next window (wrap around)
|CTRL-W_x|	CTRL-W x	   exchange current window with window N
				   (default: next window)
|CTRL-W_z|	CTRL-W z	   close preview window
|CTRL-W_bar|	CTRL-W |	   set window width to N columns
|CTRL-W_}|	CTRL-W }	   show tag under cursor in preview window
|CTRL-W_<Down>|	CTRL-W <Down>	   same as "CTRL-W j"
|CTRL-W_<Up>|	CTRL-W <Up>	   same as "CTRL-W k"
|CTRL-W_<Left>|	CTRL-W <Left>	   same as "CTRL-W h"
|CTRL-W_<Right>| CTRL-W <Right>	   same as "CTRL-W l"

==============================================================================
2.3 Square bracket commands					*[* *]*

Tag		Char	      Note Normal-mode action	~
------------------------------------------------------------------------------ ~
|[_CTRL-D|	[ CTRL-D	   jump to first #define found in current and
				   included files matching the word under the
				   cursor, start searching at beginning of
				   current file
|[_CTRL-I|	[ CTRL-I	   jump to first line in current and included
				   files that contains the word under the
				   cursor, start searching at beginning of
				   current file
|[#|		[#		1  cursor to N previous unmatched #if, #else
				   or #ifdef
|['|		['		1  cursor to previous lowercase mark, on first
				   non-blank
|[(|		[(		1  cursor N times back to unmatched '('
|[star|		[*		1  same as "[/"
|[`|		[`		1  cursor to previous lowercase mark
|[/|		[/		1  cursor to N previous start of a C comment
|[D|		[D		   list all defines found in current and
				   included files matching the word under the
				   cursor, start searching at beginning of
				   current file
|[I|		[I		   list all lines found in current and
				   included files that contain the word under
				   the cursor, start searching at beginning of
				   current file
|[P|		[P		2  same as "[p"
|[[|		[[		1  cursor N sections backward
|[]|		[]		1  cursor N SECTIONS backward
|[c|		[c		1  cursor N times backwards to start of change
|[d|		[d		   show first #define found in current and
				   included files matching the word under the
				   cursor, start searching at beginning of
				   current file
|[f|		[f		   same as "gf"
|[i|		[i		   show first line found in current and
				   included files that contains the word under
				   the cursor, start searching at beginning of
				   current file
|[m|		[m		1  cursor N times back to start of member
				   function
|[p|		[p		2  like "P", but adjust indent to current line
|[s|		[s		1  move to the previous misspelled word
|[z|		[z		1  move to start of open fold
|[{|		[{		1  cursor N times back to unmatched '{'
|[<MiddleMouse>| [<MiddleMouse>	2  same as "[p"

|]_CTRL-D|	] CTRL-D	   jump to first #define found in current and
				   included files matching the word under the
				   cursor, start searching at cursor position
|]_CTRL-I|	] CTRL-I	   jump to first line in current and included
				   files that contains the word under the
				   cursor, start searching at cursor position
|]#|		]#		1  cursor to N next unmatched #endif or #else
|]'|		]'		1  cursor to next lowercase mark, on first
				   non-blank
|])|		])		1  cursor N times forward to unmatched ')'
|]star|		]*		1  same as "]/"
|]`|		]`		1  cursor to next lowercase mark
|]/|		]/		1  cursor to N next end of a C comment
|]D|		]D		   list all #defines found in current and
				   included files matching the word under the
				   cursor, start searching at cursor position
|]I|		]I		   list all lines found in current and
				   included files that contain the word under
				   the cursor, start searching at cursor
				   position
|]P|		]P		2  same as "[p"
|][|		][		1  cursor N SECTIONS forward
|]]|		]]		1  cursor N sections forward
|]c|		]c		1  cursor N times forward to start of change
|]d|		]d		   show first #define found in current and
				   included files matching the word under the
				   cursor, start searching at cursor position
|]f|		]f		   same as "gf"
|]i|		]i		   show first line found in current and
				   included files that contains the word under
				   the cursor, start searching at cursor
				   position
|]m|		]m		1  cursor N times forward to end of member
				   function
|]p|		]p		2  like "p", but adjust indent to current line
|]s|		]s		1  move to next misspelled word
|]z|		]z		1  move to end of open fold
|]}|		]}		1  cursor N times forward to unmatched '}'
|]<MiddleMouse>| ]<MiddleMouse>	2  same as "]p"

==============================================================================
2.4 Commands starting with 'g'						*g*

Tag		Char	      Note Normal-mode action	~
------------------------------------------------------------------------------ ~
|g_CTRL-G|	g CTRL-G	   show information about current cursor
				   position
|g_CTRL-H|	g CTRL-H	   start Select block mode
|g_CTRL-]|	g CTRL-]	   |:tjump| to the tag under the cursor
|g#|		g#		1  like "#", but without using "\<" and "\>"
|g$|		g$		1  when 'wrap' off go to rightmost character of
				   the current line that is on the screen;
				   when 'wrap' on go to the rightmost character
				   of the current screen line
|g&|		g&		2  repeat last ":s" on all lines
|g'|		g'{mark}	1  like |'| but without changing the jumplist
|g`|		g`{mark}	1  like |`| but without changing the jumplist
|gstar|		g*		1  like "*", but without using "\<" and "\>"
|g+|		g+		   go to newer text state N times
|g,|		g,		1  go to N newer position in change list
|g-|		g-		   go to older text state N times
|g0|		g0		1  when 'wrap' off go to leftmost character of
				   the current line that is on the screen;
				   when 'wrap' on go to the leftmost character
				   of the current screen line
|g8|		g8		   print hex value of bytes used in UTF-8
				   character under the cursor
|g;|		g;		1  go to N older position in change list
|g<|		g<		   display previous command output
|g?|		g?		2  Rot13 encoding operator
|g?g?|		g??		2  Rot13 encode current line
|g?g?|		g?g?		2  Rot13 encode current line
|gD|		gD		1  go to definition of word under the cursor
				   in current file
|gE|		gE		1  go backwards to the end of the previous
				   WORD
|gH|		gH		   start Select line mode
|gI|		gI		2  like "I", but always start in column 1
|gJ|		gJ		2  join lines without inserting space
|gN|		gN	      1,2  find the previous match with the last used
				   search pattern and Visually select it
|gP|		["x]gP		2  put the text [from register x] before the
				   cursor N times, leave the cursor after it
|gQ|		gQ		   switch to "Ex" mode with Vim editing
|gR|		gR		2  enter Virtual Replace mode
|gT|		gT		   go to the previous tabpage
|gU|		gU{motion}	2  make Nmove text uppercase
|gV|		gV		   don't reselect the previous Visual area
				   when executing a mapping or menu in Select
				   mode
|g]|		g]		   :tselect on the tag under the cursor
|g^|		g^		1  when 'wrap' off go to leftmost non-white
				   character of the current line that is on
				   the screen; when 'wrap' on go to the
				   leftmost non-white character of the current
				   screen line
|g_|		g_		1  cursor to the last CHAR N - 1 lines lower
|ga|		ga		   print ascii value of character under the
				   cursor
|gd|		gd		1  go to definition of word under the cursor
				   in current function
|ge|		ge		1  go backwards to the end of the previous
				   word
|gf|		gf		   start editing the file whose name is under
				   the cursor
|gF|		gF		   start editing the file whose name is under
				   the cursor and jump to the line number
				   following the filename.
|gg|		gg		1  cursor to line N, default first line
|gh|		gh		   start Select mode
|gi|		gi		2  like "i", but first move to the |'^| mark
|gj|		gj		1  like "j", but when 'wrap' on go N screen
				   lines down
|gk|		gk		1  like "k", but when 'wrap' on go N screen
				   lines up
|gm|		gm		1  go to character at middle of the screenline
|gM|		gM		1  go to character at middle of the text line
|gn|		gn	      1,2  find the next match with the last used
				   search pattern and Visually select it
|go|		go		1  cursor to byte N in the buffer
|gp|		["x]gp		2  put the text [from register x] after the
				   cursor N times, leave the cursor after it
|gq|		gq{motion}	2  format Nmove text
|gr|		gr{char}	2  virtual replace N chars with {char}
|gs|		gs		   go to sleep for N seconds (default 1)
|gt|		gt		   go to the next tabpage
|gu|		gu{motion}	2  make Nmove text lowercase
|gv|		gv		   reselect the previous Visual area
|gw|		gw{motion}	2  format Nmove text and keep cursor
|gx|		gx		   execute application for filepath at cursor
|g@|		g@{motion}	   call 'operatorfunc'
|g~|		g~{motion}	2  swap case for Nmove text
|g<Down>|	g<Down>		1  same as "gj"
|g<End>|	g<End>		1  same as "g$" but go to the rightmost
				   non-blank character instead
|g<Home>|	g<Home>		1  same as "g0"
|g<LeftMouse>|	g<LeftMouse>	   same as <C-LeftMouse>
		g<MiddleMouse>	   same as <C-MiddleMouse>
|g<RightMouse>|	g<RightMouse>	   same as <C-RightMouse>
|g<Tab>|	g<Tab>		   go to last accessed tabpage
|g<Up>|		g<Up>		1  same as "gk"

==============================================================================
2.5 Commands starting with 'z'						*z*

Tag		Char	      Note Normal-mode action	~
------------------------------------------------------------------------------ ~
|z<CR>|		z<CR>		   redraw, cursor line to top of window,
				   cursor on first non-blank
|zN<CR>|	z{height}<CR>	   redraw, make window {height} lines high
|z+|		z+		   cursor on line N (default line below
				   window), otherwise like "z<CR>"
|z-|		z-		   redraw, cursor line at bottom of window,
				   cursor on first non-blank
|z.|		z.		   redraw, cursor line to center of window,
				   cursor on first non-blank
|z=|		z=		   give spelling suggestions
|zA|		zA		   open a closed fold or close an open fold
				   recursively
|zC|		zC		   close folds recursively
|zD|		zD		   delete folds recursively
|zE|		zE		   eliminate all folds
|zF|		zF		   create a fold for N lines
|zG|		zG		   temporarily mark word as correctly spelled
|zH|		zH		   when 'wrap' off scroll half a screenwidth
				   to the right
|zL|		zL		   when 'wrap' off scroll half a screenwidth
				   to the left
|zM|		zM		   set 'foldlevel' to zero
|zN|		zN		   set 'foldenable'
|zO|		zO		   open folds recursively
|zR|		zR		   set 'foldlevel' to the deepest fold
|zW|		zW		   temporarily mark word as incorrectly spelled
|zX|		zX		   re-apply 'foldlevel'
|z^|		z^		   cursor on line N (default line above
				   window), otherwise like "z-"
|za|		za		   open a closed fold, close an open fold
|zb|		zb		   redraw, cursor line at bottom of window
|zc|		zc		   close a fold
|zd|		zd		   delete a fold
|ze|		ze		   when 'wrap' off scroll horizontally to
				   position the cursor at the end (right side)
				   of the screen
|zf|		zf{motion}	   create a fold for Nmove text
|zg|		zg		   permanently mark word as correctly spelled
|zh|		zh		   when 'wrap' off scroll screen N characters
				   to the right
|zi|		zi		   toggle 'foldenable'
|zj|		zj		1  move to the start of the next fold
|zk|		zk		1  move to the end of the previous fold
|zl|		zl		   when 'wrap' off scroll screen N characters
				   to the left
|zm|		zm		   subtract one from 'foldlevel'
|zn|		zn		   reset 'foldenable'
|zo|		zo		   open fold
|zp|		zp		   paste in block-mode without trailing spaces
|zP|		zP		   paste in block-mode without trailing spaces
|zr|		zr		   add one to 'foldlevel'
|zs|		zs		   when 'wrap' off scroll horizontally to
				   position the cursor at the start (left
				   side) of the screen
|zt|		zt		   redraw, cursor line at top of window
|zuw|		zuw		   undo |zw|
|zug|		zug		   undo |zg|
|zuW|		zuW		   undo |zW|
|zuG|		zuG		   undo |zG|
|zv|		zv		   open enough folds to view the cursor line
|zw|		zw		   permanently mark word as incorrectly spelled
|zx|		zx		   re-apply 'foldlevel' and do "zv"
|zy|		zy		   yank without trailing spaces
|zz|		zz		   redraw, cursor line at center of window
|z<Left>|	z<Left>		   same as "zh"
|z<Right>|	z<Right>	   same as "zl"

==============================================================================
2.6 Operator-pending mode			*operator-pending-index*

These can be used after an operator, but before a {motion} has been entered.

Tag		Char		Operator-pending-mode action	~
------------------------------------------------------------------------------ ~
|o_v|		v		force operator to work charwise
|o_V|		V		force operator to work linewise
|o_CTRL-V|	CTRL-V		force operator to work blockwise

==============================================================================
3. Visual mode						*visual-index*

Most commands in Visual mode are the same as in Normal mode.  The ones listed
here are those that are different.

Tag		Command	      Note Visual-mode action	~
------------------------------------------------------------------------------ ~
|v_CTRL-\_CTRL-N| CTRL-\ CTRL-N	   stop Visual mode
|v_CTRL-\_CTRL-G| CTRL-\ CTRL-G	   go to Normal mode
|v_CTRL-A|	CTRL-A		2  add N to number in highlighted text
|v_CTRL-C|	CTRL-C		   stop Visual mode
|v_CTRL-G|	CTRL-G		   toggle between Visual mode and Select mode
|v_<BS>|	<BS>		2  Select mode: delete highlighted area
|v_CTRL-H|	CTRL-H		2  same as <BS>
|v_CTRL-O|	CTRL-O		   switch from Select to Visual mode for one
				   command
|v_CTRL-V|	CTRL-V		   make Visual mode blockwise or stop Visual
				   mode
|v_CTRL-X|	CTRL-X		2  subtract N from number in highlighted text
|v_<Esc>|	<Esc>		   stop Visual mode
|v_CTRL-]|	CTRL-]		   jump to highlighted tag
|v_!|		!{filter}	2  filter the highlighted lines through the
				   external command {filter}
|v_:|		:		   start a command-line with the highlighted
				   lines as a range
|v_<|		<		2  shift the highlighted lines one
				   'shiftwidth' left
|v_=|		=		2  filter the highlighted lines through the
				   external program given with the 'equalprg'
				   option
|v_>|		>		2  shift the highlighted lines one
				   'shiftwidth' right
|v_b_A|		A		2  block mode: append same text in all lines,
				   after the highlighted area
|v_C|		C		2  delete the highlighted lines and start
				   insert
|v_D|		D		2  delete the highlighted lines
|v_b_I|		I		2  block mode: insert same text in all lines,
				   before the highlighted area
|v_J|		J		2  join the highlighted lines
|v_K|		K		   run 'keywordprg' on the highlighted area
|v_O|		O		   move horizontally to other corner of area
|v_P|		P		   replace highlighted area with register
				   contents; registers are unchanged
|v_R|		R		2  delete the highlighted lines and start
				   insert
|v_S|		S		2  delete the highlighted lines and start
				   insert
|v_U|		U		2  make highlighted area uppercase
|v_V|		V		   make Visual mode linewise or stop Visual
				   mode
|v_X|		X		2  delete the highlighted lines
|v_Y|		Y		   yank the highlighted lines
|v_aquote|	a"		   extend highlighted area with a double
				   quoted string
|v_a'|		a'		   extend highlighted area with a single
				   quoted string
|v_a(|		a(		   same as ab
|v_a)|		a)		   same as ab
|v_a<|		a<		   extend highlighted area with a <> block
|v_a>|		a>		   same as a<
|v_aB|		aB		   extend highlighted area with a {} block
|v_aW|		aW		   extend highlighted area with "a WORD"
|v_a[|		a[		   extend highlighted area with a [] block
|v_a]|		a]		   same as a[
|v_a`|		a`		   extend highlighted area with a backtick
				   quoted string
|v_ab|		ab		   extend highlighted area with a () block
|v_ap|		ap		   extend highlighted area with a paragraph
|v_as|		as		   extend highlighted area with a sentence
|v_at|		at		   extend highlighted area with a tag block
|v_aw|		aw		   extend highlighted area with "a word"
|v_a{|		a{		   same as aB
|v_a}|		a}		   same as aB
|v_c|		c		2  delete highlighted area and start insert
|v_d|		d		2  delete highlighted area
|v_g_CTRL-A|	g CTRL-A	2  add N to number in highlighted text
|v_g_CTRL-X|	g CTRL-X	2  subtract N from number in highlighted text
|v_gJ|		gJ		2  join the highlighted lines without
				   inserting spaces
|v_gq|		gq		2  format the highlighted lines
|v_gv|		gv		   exchange current and previous highlighted
				   area
|v_iquote|	i"		   extend highlighted area with a double
				   quoted string (without quotes)
|v_i'|		i'		   extend highlighted area with a single
				   quoted string (without quotes)
|v_i(|		i(		   same as ib
|v_i)|		i)		   same as ib
|v_i<|		i<		   extend highlighted area with inner <> block
|v_i>|		i>		   same as i<
|v_iB|		iB		   extend highlighted area with inner {} block
|v_iW|		iW		   extend highlighted area with "inner WORD"
|v_i[|		i[		   extend highlighted area with inner [] block
|v_i]|		i]		   same as i[
|v_i`|		i`		   extend highlighted area with a backtick
				   quoted string (without the backticks)
|v_ib|		ib		   extend highlighted area with inner () block
|v_ip|		ip		   extend highlighted area with inner paragraph
|v_is|		is		   extend highlighted area with inner sentence
|v_it|		it		   extend highlighted area with inner tag block
|v_iw|		iw		   extend highlighted area with "inner word"
|v_i{|		i{		   same as iB
|v_i}|		i}		   same as iB
|v_o|		o		   move cursor to other corner of area
|v_p|		p		   replace highlighted area with register
				   contents; deleted text in unnamed register
|v_r|		r		2  replace highlighted area with a character
|v_s|		s		2  delete highlighted area and start insert
|v_u|		u		2  make highlighted area lowercase
|v_v|		v		   make Visual mode charwise or stop
				   Visual mode
|v_x|		x		2  delete the highlighted area
|v_y|		y		   yank the highlighted area
|v_~|		~		2  swap case for the highlighted area

==============================================================================
4. Command-line editing					*ex-edit-index*

Get to the command-line with the ':', '!', '/' or '?' commands.
Normal characters are inserted at the current cursor position.
"Completion" below refers to context-sensitive completion.  It will complete
file names, tags, commands etc. as appropriate.

Tag		Command		Command-line editing-mode action	~
------------------------------------------------------------------------------ ~
		CTRL-@		not used
|c_CTRL-A|	CTRL-A		do completion on the pattern in front of the
				cursor and insert all matches
|c_CTRL-B|	CTRL-B		cursor to begin of command-line
|c_CTRL-C|	CTRL-C		same as <Esc>
|c_CTRL-D|	CTRL-D		list completions that match the pattern in
				front of the cursor
|c_CTRL-E|	CTRL-E		cursor to end of command-line
'cedit'		CTRL-F		default value for 'cedit': opens the
				command-line window; otherwise not used
|c_CTRL-G|	CTRL-G		next match when 'incsearch' is active
|c_<BS>|	<BS>		delete the character in front of the cursor
|c_digraph|	{char1} <BS> {char2}
				enter digraph when 'digraph' is on
|c_CTRL-H|	CTRL-H		same as <BS>
|c_<Tab>|	<Tab>		if 'wildchar' is <Tab>: Do completion on
				the pattern in front of the cursor
|c_<S-Tab>|	<S-Tab>		same as CTRL-P
|c_wildchar|	'wildchar'	Do completion on the pattern in front of the
				cursor (default: <Tab>)
|c_CTRL-I|	CTRL-I		same as <Tab>
|c_<NL>|	<NL>		same as <CR>
|c_CTRL-J|	CTRL-J		same as <CR>
|c_CTRL-K|	CTRL-K {char1} {char2}
				enter digraph
|c_CTRL-L|	CTRL-L		do completion on the pattern in front of the
				cursor and insert the longest common part
|c_<CR>|	<CR>		execute entered command
|c_CTRL-M|	CTRL-M		same as <CR>
|c_CTRL-N|	CTRL-N		after using 'wildchar' with multiple matches:
				go to next match, otherwise: recall older
				command-line from history.
		CTRL-O		not used
|c_CTRL-P|	CTRL-P		after using 'wildchar' with multiple matches:
				go to previous match, otherwise: recall older
				command-line from history.
|c_CTRL-Q|	CTRL-Q		same as CTRL-V, unless it's used for terminal
				control flow
|c_CTRL-R|	CTRL-R {regname}
				insert the contents of a register or object
				under the cursor as if typed
|c_CTRL-R_CTRL-R| CTRL-R CTRL-R {regname}
|c_CTRL-R_CTRL-O| CTRL-R CTRL-O {regname}
				insert the contents of a register or object
				under the cursor literally
		CTRL-S		not used, or used for terminal control flow
|c_CTRL-T|	CTRL-T		previous match when 'incsearch' is active
|c_CTRL-U|	CTRL-U		remove all characters between the cursor
				and beginning of command-line
|c_CTRL-V|	CTRL-V		insert next non-digit literally, insert three
				digit decimal number as a single byte.
|c_CTRL-W|	CTRL-W		delete the word in front of the cursor
		CTRL-X		not used (reserved for completion)
		CTRL-Y		copy (yank) modeless selection
		CTRL-Z		not used (reserved for suspend)
|c_<Esc>|	<Esc>		abandon command-line without executing it
|c_CTRL-[|	CTRL-[		same as <Esc>
|c_CTRL-\_CTRL-N| CTRL-\ CTRL-N	go to Normal mode, abandon command-line
|c_CTRL-\_CTRL-G| CTRL-\ CTRL-G	go to Normal mode, abandon command-line
		CTRL-\ a - d	reserved for extensions
|c_CTRL-\_e|	CTRL-\ e {expr} replace the command line with the result of
				{expr}
		CTRL-\ f - z	reserved for extensions
		CTRL-\ others	not used
|c_CTRL-]|	CTRL-]		trigger abbreviation
|c_CTRL-^|	CTRL-^		toggle use of |:lmap| mappings
|c_<Del>|	<Del>		delete the character under the cursor

|c_<Left>|	<Left>		cursor left
|c_<S-Left>|	<S-Left>	cursor one word left
|c_<C-Left>|	<C-Left>	cursor one word left
|c_<Right>|	<Right>		cursor right
|c_<S-Right>|	<S-Right>	cursor one word right
|c_<C-Right>|	<C-Right>	cursor one word right
|c_<Up>|	<Up>		recall previous command-line from history that
				matches pattern in front of the cursor
|c_<S-Up>|	<S-Up>		recall previous command-line from history
|c_<Down>|	<Down>		recall next command-line from history that
				matches pattern in front of the cursor
|c_<S-Down>|	<S-Down>	recall next command-line from history
|c_<Home>|	<Home>		cursor to start of command-line
|c_<End>|	<End>		cursor to end of command-line
|c_<PageDown>|	<PageDown>	same as <S-Down>
|c_<PageUp>|	<PageUp>	same as <S-Up>
|c_<Insert>|	<Insert>	toggle insert/overstrike mode
|c_<LeftMouse>|	<LeftMouse>	cursor at mouse click

commands in wildmenu mode (see 'wildmenu')

		<Up>		move up to parent
		<Down>		move down to submenu
		<Left>		select the previous match
		<Right>		select the next match
		<CR>		move into submenu when doing menu completion
		CTRL-E		stop completion and go back to original text
		CTRL-Y		accept selected match and stop completion
		other		stop completion and insert the typed character

commands in wildmenu mode with 'wildoptions' set to "pum"

		<PageUp>	select a match several entries back
		<PageDown>	select a match several entries forward

==============================================================================
5. Terminal mode				*terminal-mode-index*

In a |terminal| buffer all keys except CTRL-\ are forwarded to the terminal
job.  If CTRL-\ is pressed, the next key is forwarded unless it is CTRL-N
or CTRL-O.
Use |CTRL-\_CTRL-N| to go to Normal mode.
Use |t_CTRL-\_CTRL-O| to execute one normal mode command and then return
to terminal mode.


You found it, Arthur!				*holy-grail*

==============================================================================
6. EX commands				*Ex-command* *ex-cmd-index* *:index*

This is a brief but complete listing of all the ":" commands, without
mentioning any arguments.  The optional part of the command name is inside [].
The commands are sorted on the non-optional part of their name.

Tag		Command		Action ~
------------------------------------------------------------------------------ ~
|:|		:		nothing
|:range|	:{range}	go to last line in {range}
|:!|		:!		filter lines or execute an external command
|:!!|		:!!		repeat last ":!" command
|:#|		:#		same as ":number"
|:&|		:&		repeat last ":substitute"
|:star|		:*		use the last Visual area, like ":'<,'>"
|:<|		:<		shift lines one 'shiftwidth' left
|:=|		:=		print the last line number
|:>|		:>		shift lines one 'shiftwidth' right
|:@|		:@		execute contents of a register
|:@@|		:@@		repeat the previous ":@"
|:2match|	:2mat[ch]	define a second match to highlight
|:3match|	:3mat[ch]	define a third match to highlight
|:Next|		:N[ext]		go to previous file in the argument list
|:append|	:a[ppend]	append text
|:abbreviate|	:ab[breviate]	enter abbreviation
|:abclear|	:abc[lear]	remove all abbreviations
|:aboveleft|	:abo[veleft]	make split window appear left or above
|:all|		:al[l]		open a window for each file in the argument
				list
|:amenu|	:am[enu]	enter new menu item for all modes
|:anoremenu|	:an[oremenu]	enter a new menu for all modes that will not
				be remapped
|:args|		:ar[gs]		print the argument list
|:argadd|	:arga[dd]	add items to the argument list
|:argdedupe|	:argded[upe]	remove duplicates from the argument list
|:argdelete|	:argd[elete]	delete items from the argument list
|:argedit|	:arge[dit]	add item to the argument list and edit it
|:argdo|	:argdo		do a command on all items in the argument list
|:argglobal|	:argg[lobal]	define the global argument list
|:arglocal|	:argl[ocal]	define a local argument list
|:argument|	:argu[ment]	go to specific file in the argument list
|:ascii|	:as[cii]	print ascii value of character under the cursor
|:autocmd|	:au[tocmd]	enter or show autocommands
|:augroup|	:aug[roup]	select the autocommand group to use
|:aunmenu|	:aun[menu]	remove menu for all modes
|:buffer|	:b[uffer]	go to specific buffer in the buffer list
|:bNext|	:bN[ext]	go to previous buffer in the buffer list
|:ball|		:ba[ll]		open a window for each buffer in the buffer list
|:badd|		:bad[d]		add buffer to the buffer list
|:balt|		:balt		like ":badd" but also set the alternate file
|:bdelete|	:bd[elete]	remove a buffer from the buffer list
|:belowright|	:bel[owright]	make split window appear right or below
|:bfirst|	:bf[irst]	go to first buffer in the buffer list
|:blast|	:bl[ast]	go to last buffer in the buffer list
|:bmodified|	:bm[odified]	go to next buffer in the buffer list that has
				been modified
|:bnext|	:bn[ext]	go to next buffer in the buffer list
|:botright|	:bo[tright]	make split window appear at bottom or far right
|:bprevious|	:bp[revious]	go to previous buffer in the buffer list
|:brewind|	:br[ewind]	go to first buffer in the buffer list
|:break|	:brea[k]	break out of while loop
|:breakadd|	:breaka[dd]	add a debugger breakpoint
|:breakdel|	:breakd[el]	delete a debugger breakpoint
|:breaklist|	:breakl[ist]	list debugger breakpoints
|:browse|	:bro[wse]	use file selection dialog
|:bufdo|	:bufd[o]	execute command in each listed buffer
|:buffers|	:buffers	list all files in the buffer list
|:bunload|	:bun[load]	unload a specific buffer
|:bwipeout|	:bw[ipeout]	really delete a buffer
|:change|	:c[hange]	replace a line or series of lines
|:cNext|	:cN[ext]	go to previous error
|:cNfile|	:cNf[ile]	go to last error in previous file
|:cabbrev|	:ca[bbrev]	like ":abbreviate" but for Command-line mode
|:cabclear|	:cabc[lear]	clear all abbreviations for Command-line mode
|:cabove|	:cabo[ve]	go to error above current line
|:caddbuffer|	:cad[dbuffer]	add errors from buffer
|:caddexpr|	:cadde[xpr]	add errors from expr
|:caddfile|	:caddf[ile]	add error message to current quickfix list
|:cafter|	:caf[ter]	go to error after current cursor
|:call|		:cal[l]		call a function
|:catch|	:cat[ch]	part of a :try command
|:cbefore|	:cbe[fore]	go to error before current cursor
|:cbelow|	:cbel[ow]	go to error below current line
|:cbottom|	:cbo[ttom]	scroll to the bottom of the quickfix window
|:cbuffer|	:cb[uffer]	parse error messages and jump to first error
|:cc|		:cc		go to specific error
|:cclose|	:ccl[ose]	close quickfix window
|:cd|		:cd		change directory
|:cdo|		:cdo		execute command in each valid error list entry
|:cfdo|		:cfd[o]		execute command in each file in error list
|:center|	:ce[nter]	format lines at the center
|:cexpr|	:cex[pr]	read errors from expr and jump to first
|:cfile|	:cf[ile]	read file with error messages and jump to first
|:cfirst|	:cfir[st]	go to the specified error, default first one
|:cgetbuffer|	:cgetb[uffer]	get errors from buffer
|:cgetexpr|	:cgete[xpr]	get errors from expr
|:cgetfile|	:cg[etfile]	read file with error messages
|:changes|	:changes	print the change list
|:chdir|	:chd[ir]	change directory
|:checkhealth|	:che[ckhealth]	run healthchecks
|:checkpath|	:checkp[ath]	list included files
|:checktime|	:checkt[ime]	check timestamp of loaded buffers
|:chistory|	:chi[story]	list the error lists
|:clast|	:cla[st]	go to the specified error, default last one
|:clearjumps|	:cle[arjumps]	clear the jump list
|:clist|	:cl[ist]	list all errors
|:close|	:clo[se]	close current window
|:cmap|		:cm[ap]		like ":map" but for Command-line mode
|:cmapclear|	:cmapc[lear]	clear all mappings for Command-line mode
|:cmenu|	:cme[nu]	add menu for Command-line mode
|:cnext|	:cn[ext]	go to next error
|:cnewer|	:cnew[er]	go to newer error list
|:cnfile|	:cnf[ile]	go to first error in next file
|:cnoremap|	:cno[remap]	like ":noremap" but for Command-line mode
|:cnoreabbrev|	:cnorea[bbrev]	like ":noreabbrev" but for Command-line mode
|:cnoremenu|	:cnoreme[nu]	like ":noremenu" but for Command-line mode
|:copy|		:co[py]		copy lines
|:colder|	:col[der]	go to older error list
|:colorscheme|	:colo[rscheme]	load a specific color scheme
|:command|	:com[mand]	create user-defined command
|:comclear|	:comc[lear]	clear all user-defined commands
|:compiler|	:comp[iler]	do settings for a specific compiler
|:continue|	:con[tinue]	go back to :while
|:confirm|	:conf[irm]	prompt user when confirmation required
|:const|	:cons[t]	create a variable as a constant
|:copen|	:cope[n]	open quickfix window
|:cprevious|	:cp[revious]	go to previous error
|:cpfile|	:cpf[ile]	go to last error in previous file
|:cquit|	:cq[uit]	quit Vim with an error code
|:crewind|	:cr[ewind]	go to the specified error, default first one
|:cunmap|	:cu[nmap]	like ":unmap" but for Command-line mode
|:cunabbrev|	:cuna[bbrev]	like ":unabbrev" but for Command-line mode
|:cunmenu|	:cunme[nu]	remove menu for Command-line mode
|:cwindow|	:cw[indow]	open or close quickfix window
|:delete|	:d[elete]	delete lines
|:debug|	:deb[ug]	run a command in debugging mode
|:debuggreedy|	:debugg[reedy]	read debug mode commands from normal input
|:defer|	:defe[r]	call function when current function is done
|:delcommand|	:delc[ommand]	delete user-defined command
|:delfunction|	:delf[unction]	delete a user function
|:delmarks|	:delm[arks]	delete marks
|:detach|	:detach		detach the current UI
|:diffupdate|	:dif[fupdate]	update 'diff' buffers
|:diffget|	:diffg[et]	remove differences in current buffer
|:diffoff|	:diffo[ff]	switch off diff mode
|:diffpatch|	:diffp[atch]	apply a patch and show differences
|:diffput|	:diffpu[t]	remove differences in other buffer
|:diffsplit|	:diffs[plit]	show differences with another file
|:diffthis|	:difft[his]	make current window a diff window
|:digraphs|	:dig[raphs]	show or enter digraphs
|:display|	:di[splay]	display registers
|:djump|	:dj[ump]	jump to #define
|:dl|		:dl		short for |:delete| with the 'l' flag
|:dlist|	:dli[st]	list #defines
|:doautocmd|	:do[autocmd]	apply autocommands to current buffer
|:doautoall|	:doautoa[ll]	apply autocommands for all loaded buffers
|:dp|		:d[elete]p	short for |:delete| with the 'p' flag
|:drop|		:dr[op]		jump to window editing file or edit file in
				current window
|:dsearch|	:ds[earch]	list one #define
|:dsplit|	:dsp[lit]	split window and jump to #define
|:edit|		:e[dit]		edit a file
|:earlier|	:ea[rlier]	go to older change, undo
|:echo|		:ec[ho]		echoes the result of expressions
|:echoerr|	:echoe[rr]	like :echo, show like an error and use history
|:echohl|	:echoh[l]	set highlighting for echo commands
|:echomsg|	:echom[sg]	same as :echo, put message in history
|:echon|	:echon		same as :echo, but without <EOL>
|:else|		:el[se]		part of an :if command
|:elseif|	:elsei[f]	part of an :if command
|:emenu|	:em[enu]	execute a menu by name
|:endif|	:en[dif]	end previous :if
|:endfor|	:endfo[r]	end previous :for
|:endfunction|	:endf[unction]	end of a user function started with :function
|:endtry|	:endt[ry]	end previous :try
|:endwhile|	:endw[hile]	end previous :while
|:enew|		:ene[w]		edit a new, unnamed buffer
|:eval|		:ev[al]		evaluate an expression and discard the result
|:ex|		:ex		same as ":edit"
|:execute|	:exe[cute]	execute result of expressions
|:exit|		:exi[t]		same as ":xit"
|:exusage|	:exu[sage]	overview of Ex commands
|:fclose|	:fc[lose]	close floating window
|:file|		:f[ile]		show or set the current file name
|:files|	:files		list all files in the buffer list
|:filetype|	:filet[ype]	switch file type detection on/off
|:filter|	:filt[er]	filter output of following command
|:find|		:fin[d]		find file in 'path' and edit it
|:finally|	:fina[lly]	part of a :try command
|:finish|	:fini[sh]	quit sourcing a Vim script
|:first|	:fir[st]	go to the first file in the argument list
|:fold|		:fo[ld]		create a fold
|:foldclose|	:foldc[lose]	close folds
|:folddoopen|	:foldd[oopen]	execute command on lines not in a closed fold
|:folddoclosed|	:folddoc[losed]	execute command on lines in a closed fold
|:foldopen|	:foldo[pen]	open folds
|:for|		:for		for loop
|:function|	:fu[nction]	define a user function
|:global|	:g[lobal]	execute commands for matching lines
|:goto|		:go[to]		go to byte in the buffer
|:grep|		:gr[ep]		run 'grepprg' and jump to first match
|:grepadd|	:grepa[dd]	like :grep, but append to current list
|:gui|		:gu[i]		start the GUI
|:gvim|		:gv[im]		start the GUI
|:help|		:h[elp]		open a help window
|:helpclose|	:helpc[lose]	close one help window
|:helpgrep|	:helpg[rep]	like ":grep" but searches help files
|:helptags|	:helpt[ags]	generate help tags for a directory
|:highlight|	:hi[ghlight]	specify highlighting methods
|:hide|		:hid[e]		hide current buffer for a command
|:history|	:his[tory]	print a history list
|:horizontal|	:hor[izontal]	following window command work horizontally
|:insert|	:i[nsert]	insert text
|:iabbrev|	:ia[bbrev]	like ":abbrev" but for Insert mode
|:iabclear|	:iabc[lear]	like ":abclear" but for Insert mode
|:if|		:if		execute commands when condition met
|:ijump|	:ij[ump]	jump to definition of identifier
|:ilist|	:il[ist]	list lines where identifier matches
|:imap|		:im[ap]		like ":map" but for Insert mode
|:imapclear|	:imapc[lear]	like ":mapclear" but for Insert mode
|:imenu|	:ime[nu]	add menu for Insert mode
|:inoremap|	:ino[remap]	like ":noremap" but for Insert mode
|:inoreabbrev|	:inorea[bbrev]	like ":noreabbrev" but for Insert mode
|:inoremenu|	:inoreme[nu]	like ":noremenu" but for Insert mode
|:intro|	:int[ro]	print the introductory message
|:iput|		:ip[ut]		like |:put|, but adjust the indent to the
				current line
|:isearch|	:is[earch]	list one line where identifier matches
|:isplit|	:isp[lit]	split window and jump to definition of
				identifier
|:iunmap|	:iu[nmap]	like ":unmap" but for Insert mode
|:iunabbrev|	:iuna[bbrev]	like ":unabbrev" but for Insert mode
|:iunmenu|	:iunme[nu]	remove menu for Insert mode
|:join|		:j[oin]		join lines
|:jumps|	:ju[mps]	print the jump list
|:k|		:k		set a mark
|:keepalt|	:keepa[lt]	following command keeps the alternate file
|:keepmarks|	:kee[pmarks]	following command keeps marks where they are
|:keepjumps|	:keepj[umps]	following command keeps jumplist and marks
|:keeppatterns|	:keepp[atterns]	following command keeps search pattern history
|:lNext|	:lN[ext]	go to previous entry in location list
|:lNfile|	:lNf[ile]	go to last entry in previous file
|:list|		:l[ist]		print lines
|:labove|	:lab[ove]	go to location above current line
|:laddexpr|	:lad[dexpr]	add locations from expr
|:laddbuffer|	:laddb[uffer]	add locations from buffer
|:laddfile|	:laddf[ile]	add locations to current location list
|:lafter|	:laf[ter]	go to location after current cursor
|:last|		:la[st]		go to the last file in the argument list
|:language|	:lan[guage]	set the language (locale)
|:later|	:lat[er]	go to newer change, redo
|:lbefore|	:lbe[fore]	go to location before current cursor
|:lbelow|	:lbel[ow]	go to location below current line
|:lbottom|	:lbo[ttom]	scroll to the bottom of the location window
|:lbuffer|	:lb[uffer]	parse locations and jump to first location
|:lcd|		:lc[d]		change directory locally
|:lchdir|	:lch[dir]	change directory locally
|:lclose|	:lcl[ose]	close location window
|:ldo|		:ld[o]		execute command in valid location list entries
|:lfdo|		:lfd[o]		execute command in each file in location list
|:left|		:le[ft]		left align lines
|:leftabove|	:lefta[bove]	make split window appear left or above
|:let|		:let		assign a value to a variable or option
|:lexpr|	:lex[pr]	read locations from expr and jump to first
|:lfile|	:lf[ile]	read file with locations and jump to first
|:lfirst|	:lfir[st]	go to the specified location, default first one
|:lgetbuffer|	:lgetb[uffer]	get locations from buffer
|:lgetexpr|	:lgete[xpr]	get locations from expr
|:lgetfile|	:lg[etfile]	read file with locations
|:lgrep|	:lgr[ep]	run 'grepprg' and jump to first match
|:lgrepadd|	:lgrepa[dd]	like :grep, but append to current list
|:lhelpgrep|	:lh[elpgrep]	like ":helpgrep" but uses location list
|:lhistory|	:lhi[story]	list the location lists
|:ll|		:ll		go to specific location
|:llast|	:lla[st]	go to the specified location, default last one
|:llist|	:lli[st]	list all locations
|:lmake|	:lmak[e]	execute external command 'makeprg' and parse
				error messages
|:lmap|		:lm[ap]		like ":map!" but includes Lang-Arg mode
|:lmapclear|	:lmapc[lear]	like ":mapclear!" but includes Lang-Arg mode
|:lnext|	:lne[xt]	go to next location
|:lnewer|	:lnew[er]	go to newer location list
|:lnfile|	:lnf[ile]	go to first location in next file
|:lnoremap|	:ln[oremap]	like ":noremap!" but includes Lang-Arg mode
|:loadkeymap|	:loadk[eymap]	load the following keymaps until EOF
|:loadview|	:lo[adview]	load view for current window from a file
|:lockmarks|	:loc[kmarks]	following command keeps marks where they are
|:lockvar|	:lockv[ar]	lock variables
|:lolder|	:lol[der]	go to older location list
|:lopen|	:lop[en]	open location window
|:lprevious|	:lp[revious]	go to previous location
|:lpfile|	:lpf[ile]	go to last location in previous file
|:lrewind|	:lr[ewind]	go to the specified location, default first one
|:ls|		:ls		list all buffers
|:lsp|		:lsp		language server protocol
|:ltag|		:lt[ag]		jump to tag and add matching tags to the
				location list
|:lunmap|	:lu[nmap]	like ":unmap!" but includes Lang-Arg mode
|:lua|		:lua		execute |Lua| command
|:luado|	:luad[o]	execute Lua command for each line
|:luafile|	:luaf[ile]	execute |Lua| script file
|:lvimgrep|	:lv[imgrep]	search for pattern in files
|:lvimgrepadd|	:lvimgrepa[dd]	like :vimgrep, but append to current list
|:lwindow|	:lw[indow]	open or close location window
|:move|		:m[ove]		move lines
|:mark|		:ma[rk]		set a mark
|:make|		:mak[e]		execute external command 'makeprg' and parse
				error messages
|:map|		:map		show or enter a mapping
|:mapclear|	:mapc[lear]	clear all mappings for Normal and Visual mode
|:marks|	:marks		list all marks
|:match|	:mat[ch]	define a match to highlight
|:menu|		:me[nu]		enter a new menu item
|:menutranslate|  :menut[ranslate] add a menu translation item
|:messages|	:mes[sages]	view previously displayed messages
|:mkexrc|	:mk[exrc]	write current mappings and settings to a file
|:mksession|	:mks[ession]	write session info to a file
|:mkspell|	:mksp[ell]	produce .spl spell file
|:mkvimrc|	:mkv[imrc]	write current mappings and settings to a file
|:mkview|	:mkvie[w]	write view of current window to a file
|:mode|		:mod[e]		show or change the screen mode
|:next|		:n[ext]		go to next file in the argument list
|:new|		:new		create a new empty window
|:nmap|		:nm[ap]		like ":map" but for Normal mode
|:nmapclear|	:nmapc[lear]	clear all mappings for Normal mode
|:nmenu|	:nme[nu]	add menu for Normal mode
|:nnoremap|	:nn[oremap]	like ":noremap" but for Normal mode
|:nnoremenu|	:nnoreme[nu]	like ":noremenu" but for Normal mode
|:noautocmd|	:noa[utocmd]	following commands don't trigger autocommands
|:noremap|	:no[remap]	enter a mapping that will not be remapped
|:nohlsearch|	:noh[lsearch]	suspend 'hlsearch' highlighting
|:noreabbrev|	:norea[bbrev]	enter an abbreviation that will not be
				remapped
|:noremenu|	:noreme[nu]	enter a menu that will not be remapped
|:normal|	:norm[al]	execute Normal mode commands
|:noswapfile|	:nos[wapfile]	following commands don't create a swap file
|:number|	:nu[mber]	print lines with line number
|:nunmap|	:nun[map]	like ":unmap" but for Normal mode
|:nunmenu|	:nunme[nu]	remove menu for Normal mode
|:oldfiles|	:ol[dfiles]	list files that have marks in the |shada| file
|:omap|		:om[ap]		like ":map" but for Operator-pending mode
|:omapclear|	:omapc[lear]	remove all mappings for Operator-pending mode
|:omenu|	:ome[nu]	add menu for Operator-pending mode
|:only|		:on[ly]		close all windows except the current one
|:onoremap|	:ono[remap]	like ":noremap" but for Operator-pending mode
|:onoremenu|	:onoreme[nu]	like ":noremenu" but for Operator-pending mode
|:options|	:opt[ions]	open the options-window
|:ounmap|	:ou[nmap]	like ":unmap" but for Operator-pending mode
|:ounmenu|	:ounme[nu]	remove menu for Operator-pending mode
|:packadd|	:pa[ckadd]	add a plugin from 'packpath'
|:packloadall|	:packl[oadall]	load all packages under 'packpath'
|:pbuffer|	:pb[uffer]	edit buffer in the preview window
|:pclose|	:pc[lose]	close preview window
|:pedit|	:ped[it]	edit file in the preview window
|:perl|		:pe[rl]		execute perl command
|:perldo|	:perld[o]	execute perl command for each line
|:perlfile|	:perlf[ile]	execute perl script file
|:print|	:p[rint]	print lines
|:profdel|	:profd[el]	stop profiling a function or script
|:profile|	:prof[ile]	profiling functions and scripts
|:pop|		:po[p]		jump to older entry in tag stack
|:popup|	:popu[p]	popup a menu by name
|:ppop|		:pp[op]		":pop" in preview window
|:preserve|	:pre[serve]	write all text to swap file
|:previous|	:prev[ious]	go to previous file in argument list
|:psearch|	:ps[earch]	like ":ijump" but shows match in preview window
|:ptag|		:pt[ag]		show tag in preview window
|:ptNext|	:ptN[ext]	|:tNext| in preview window
|:ptfirst|	:ptf[irst]	|:trewind| in preview window
|:ptjump|	:ptj[ump]	|:tjump| and show tag in preview window
|:ptlast|	:ptl[ast]	|:tlast| in preview window
|:ptnext|	:ptn[ext]	|:tnext| in preview window
|:ptprevious|	:ptp[revious]	|:tprevious| in preview window
|:ptrewind|	:ptr[ewind]	|:trewind| in preview window
|:ptselect|	:pts[elect]	|:tselect| and show tag in preview window
|:put|		:pu[t]		insert contents of register in the text
|:pwd|		:pw[d]		print current directory
|:py3|		:py3		execute Python 3 command
|:python3|	:python3	same as :py3
|:py3do|	:py3d[o]	execute Python 3 command for each line
|:py3file|	:py3f[ile]	execute Python 3 script file
|:python|	:py[thon]	execute Python command
|:pydo|		:pyd[o]		execute Python command for each line
|:pyfile|	:pyf[ile]	execute Python script file
|:pyx|		:pyx		execute |python_x| command
|:pythonx|	:pythonx	same as :pyx
|:pyxdo|	:pyxd[o]	execute |python_x| command for each line
|:pyxfile|	:pyxf[ile]	execute |python_x| script file
|:quit|		:q[uit]		quit current window (when one window quit Vim)
|:quitall|	:quita[ll]	quit Vim
|:qall|		:qa[ll]		quit Vim
|:read|		:r[ead]		read file into the text
|:recover|	:rec[over]	recover a file from a swap file
|:redo|		:red[o]		redo one undone change
|:redir|	:redi[r]	redirect messages to a file or register
|:redraw|	:redr[aw]	force a redraw of the display
|:redrawstatus|	:redraws[tatus]	force a redraw of the status line(s) and
				window bar(s)
|:redrawtabline|  :redrawt[abline]  force a redraw of the tabline
|:registers|	:reg[isters]	display the contents of registers
|:resize|	:res[ize]	change current window height
|:restart|	:restart	restart the Nvim server
|:retab|	:ret[ab]	change tab size
|:return|	:retu[rn]	return from a user function
|:rewind|	:rew[ind]	go to the first file in the argument list
|:right|	:ri[ght]	right align text
|:rightbelow|	:rightb[elow]	make split window appear right or below
|:rshada|	:rsh[ada]	read from |shada| file
|:ruby|		:rub[y]		execute Ruby command
|:rubydo|	:rubyd[o]	execute Ruby command for each line
|:rubyfile|	:rubyf[ile]	execute Ruby script file
|:rundo|	:rund[o]	read undo information from a file
|:runtime|	:ru[ntime]	source vim scripts in 'runtimepath'
|:substitute|	:s[ubstitute]	find and replace text
|:sNext|	:sN[ext]	split window and go to previous file in
				argument list
|:sandbox|	:san[dbox]	execute a command in the sandbox
|:sargument|	:sa[rgument]	split window and go to specific file in
				argument list
|:sall|		:sal[l]		open a window for each file in argument list
|:saveas|	:sav[eas]	save file under another name.
|:sbuffer|	:sb[uffer]	split window and go to specific file in the
				buffer list
|:sbNext|	:sbN[ext]	split window and go to previous file in the
				buffer list
|:sball|	:sba[ll]	open a window for each file in the buffer list
|:sbfirst|	:sbf[irst]	split window and go to first file in the
				buffer list
|:sblast|	:sbl[ast]	split window and go to last file in buffer
				list
|:sbmodified|	:sbm[odified]	split window and go to modified file in the
				buffer list
|:sbnext|	:sbn[ext]	split window and go to next file in the buffer
				list
|:sbprevious|	:sbp[revious]	split window and go to previous file in the
				buffer list
|:sbrewind|	:sbr[ewind]	split window and go to first file in the
				buffer list
|:scriptnames|	:scr[iptnames]	list names of all sourced Vim scripts
|:scriptencoding| :scripte[ncoding]  encoding used in sourced Vim script
|:set|		:se[t]		show or set options
|:setfiletype|	:setf[iletype]	set 'filetype', unless it was set already
|:setglobal|	:setg[lobal]	show global values of options
|:setlocal|	:setl[ocal]	show or set options locally
|:sfind|	:sf[ind]	split current window and edit file in 'path'
|:sfirst|	:sfir[st]	split window and go to first file in the
				argument list
|:sign|		:sig[n]		manipulate signs
|:silent|	:sil[ent]	run a command silently
|:sleep|	:sl[eep]	do nothing for a few seconds
|:sleep!|	:sl[eep]!	do nothing for a few seconds, without the
				cursor visible
|:slast|	:sla[st]	split window and go to last file in the
				argument list
|:smagic|	:sm[agic]	:substitute with 'magic'
|:smap|		:smap		like ":map" but for Select mode
|:smapclear|	:smapc[lear]	remove all mappings for Select mode
|:smenu|	:sme[nu]	add menu for Select mode
|:snext|	:sn[ext]	split window and go to next file in the
				argument list
|:snomagic|	:sno[magic]	:substitute with 'nomagic'
|:snoremap|	:snor[emap]	like ":noremap" but for Select mode
|:snoremenu|	:snoreme[nu]	like ":noremenu" but for Select mode
|:sort|		:sor[t]		sort lines
|:source|	:so[urce]	read Vim or Ex commands from a file
|:spelldump|	:spelld[ump]	split window and fill with all correct words
|:spellgood|	:spe[llgood]	add good word for spelling
|:spellinfo|	:spelli[nfo]	show info about loaded spell files
|:spellrare|	:spellra[re]	add rare word for spelling
|:spellrepall|	:spellr[epall]	replace all bad words like last |z=|
|:spellundo|	:spellu[ndo]	remove good or bad word
|:spellwrong|	:spellw[rong]	add spelling mistake
|:split|	:sp[lit]	split current window
|:sprevious|	:spr[evious]	split window and go to previous file in the
				argument list
|:srewind|	:sre[wind]	split window and go to first file in the
				argument list
|:stop|		:st[op]		suspend the editor or escape to a shell
|:stag|		:sta[g]		split window and jump to a tag
|:startinsert|	:star[tinsert]	start Insert mode
|:startgreplace|  :startg[replace] start Virtual Replace mode
|:startreplace|	:startr[eplace]	start Replace mode
|:stopinsert|	:stopi[nsert]	stop Insert mode
|:stjump|	:stj[ump]	do ":tjump" and split window
|:stselect|	:sts[elect]	do ":tselect" and split window
|:sunhide|	:sun[hide]	same as ":unhide"
|:sunmap|	:sunm[ap]	like ":unmap" but for Select mode
|:sunmenu|	:sunme[nu]	remove menu for Select mode
|:suspend|	:sus[pend]	same as ":stop"
|:sview|	:sv[iew]	split window and edit file read-only
|:swapname|	:sw[apname]	show the name of the current swap file
|:syntax|	:sy[ntax]	syntax highlighting
|:syntime|	:synti[me]	measure syntax highlighting speed
|:syncbind|	:sync[bind]	sync scroll binding
|:t|		:t		same as ":copy"
|:tNext|	:tN[ext]	jump to previous matching tag
|:tabNext|	:tabN[ext]	go to previous tabpage
|:tabclose|	:tabc[lose]	close current tabpage
|:tabdo|	:tabd[o]	execute command in each tabpage
|:tabedit|	:tabe[dit]	edit a file in a new tabpage
|:tabfind|	:tabf[ind]	find file in 'path', edit it in a new tabpage
|:tabfirst|	:tabfir[st]	go to first tabpage
|:tablast|	:tabl[ast]	go to last tabpage
|:tabmove|	:tabm[ove]	move tabpage to other position
|:tabnew|	:tabnew		edit a file in a new tabpage
|:tabnext|	:tabn[ext]	go to next tabpage
|:tabonly|	:tabo[nly]	close all tabpages except the current one
|:tabprevious|	:tabp[revious]	go to previous tabpage
|:tabrewind|	:tabr[ewind]	go to first tabpage
|:tabs|		:tabs		list the tabpages and what they contain
|:tab|		:tab		create new tab when opening new window
|:tag|		:ta[g]		jump to tag
|:tags|		:tags		show the contents of the tag stack
|:tcd|		:tc[d]		change directory for tabpage
|:tchdir|	:tch[dir]	change directory for tabpage
|:terminal|	:te[rminal]	open a terminal buffer
|:tfirst|	:tf[irst]	jump to first matching tag
|:throw|	:th[row]	throw an exception
|:tjump|	:tj[ump]	like ":tselect", but jump directly when there
				is only one match
|:tlast|	:tl[ast]	jump to last matching tag
|:tlmenu|	:tlm[enu]	add menu for |Terminal-mode|
|:tlnoremenu|	:tln[oremenu]	like ":noremenu" but for |Terminal-mode|
|:tlunmenu|	:tlu[nmenu]	remove menu for |Terminal-mode|
|:tmapclear|	:tmapc[lear]	remove all mappings for |Terminal-mode|
|:tmap|		:tma[p]		like ":map" but for |Terminal-mode|
|:tmenu|	:tm[enu]	define menu tooltip
|:tnext|	:tn[ext]	jump to next matching tag
|:tnoremap|	:tno[remap]	like ":noremap" but for |Terminal-mode|
|:topleft|	:to[pleft]	make split window appear at top or far left
|:tprevious|	:tp[revious]	jump to previous matching tag
|:trewind|	:tr[ewind]	jump to first matching tag
|:trust|	:trust		add or remove file from trust database
|:try|		:try		execute commands, abort on error or exception
|:tselect|	:ts[elect]	list matching tags and select one
|:tunmap|	:tunma[p]	like ":unmap" but for |Terminal-mode|
|:tunmenu|	:tu[nmenu]	remove menu tooltip
|:undo|		:u[ndo]		undo last change(s)
|:undojoin|	:undoj[oin]	join next change with previous undo block
|:undolist|	:undol[ist]	list leafs of the undo tree
|:unabbreviate|	:una[bbreviate]	remove abbreviation
|:unhide|	:unh[ide]	open a window for each loaded file in the
				buffer list
|:uniq|		:uni[q]		uniq lines
|:unlet|	:unl[et]	delete variable
|:unlockvar|	:unlo[ckvar]	unlock variables
|:unmap|	:unm[ap]	remove mapping
|:unmenu|	:unme[nu]	remove menu
|:unsilent|	:uns[ilent]	run a command not silently
|:update|	:up[date]	write buffer if modified
|:vglobal|	:v[global]	execute commands for not matching lines
|:version|	:ve[rsion]	print version number and other info
|:verbose|	:verb[ose]	execute command with 'verbose' set
|:vertical|	:vert[ical]	make following command split vertically
|:vimgrep|	:vim[grep]	search for pattern in files
|:vimgrepadd|	:vimgrepa[dd]	like :vimgrep, but append to current list
|:visual|	:vi[sual]	same as ":edit", but turns off "Ex" mode
|:viusage|	:viu[sage]	overview of Normal mode commands
|:view|		:vie[w]		edit a file read-only
|:vmap|		:vm[ap]		like ":map" but for Visual+Select mode
|:vmapclear|	:vmapc[lear]	remove all mappings for Visual+Select mode
|:vmenu|	:vme[nu]	add menu for Visual+Select mode
|:vnew|		:vne[w]		create a new empty window, vertically split
|:vnoremap|	:vn[oremap]	like ":noremap" but for Visual+Select mode
|:vnoremenu|	:vnoreme[nu]	like ":noremenu" but for Visual+Select mode
|:vsplit|	:vs[plit]	split current window vertically
|:vunmap|	:vu[nmap]	like ":unmap" but for Visual+Select mode
|:vunmenu|	:vunme[nu]	remove menu for Visual+Select mode
|:windo|	:wind[o]	execute command in each window
|:write|	:w[rite]	write to a file
|:wNext|	:wN[ext]	write to a file and go to previous file in
				argument list
|:wall|		:wa[ll]		write all (changed) buffers
|:while|	:wh[ile]	execute loop for as long as condition met
|:winsize|	:wi[nsize]	get or set window size (obsolete)
|:wincmd|	:winc[md]	execute a Window (CTRL-W) command
|:winpos|	:winp[os]	get or set window position
|:wnext|	:wn[ext]	write to a file and go to next file in
				argument list
|:wprevious|	:wp[revious]	write to a file and go to previous file in
				argument list
|:wq|		:wq		write to a file and quit window or Vim
|:wqall|	:wqa[ll]	write all changed buffers and quit Vim
|:wshada|	:wsh[ada]	write to ShaDa file
|:wundo|	:wu[ndo]	write undo information to a file
|:xit|		:x[it]		write if buffer changed and close window
|:xall|		:xa[ll]		same as ":wqall"
|:xmapclear|	:xmapc[lear]	remove all mappings for Visual mode
|:xmap|		:xm[ap]		like ":map" but for Visual mode
|:xmenu|	:xme[nu]	add menu for Visual mode
|:xnoremap|	:xn[oremap]	like ":noremap" but for Visual mode
|:xnoremenu|	:xnoreme[nu]	like ":noremenu" but for Visual mode
|:xunmap|	:xu[nmap]	like ":unmap" but for Visual mode
|:xunmenu|	:xunme[nu]	remove menu for Visual mode
|:yank|		:y[ank]		yank lines into a register
|:z|		:z		print some lines
|:~|		:~		repeat last ":substitute"


 vim:tw=78:ts=8:noet:ft=help:norl:
```

## Shell and command shortcuts

Your `.zshrc` enables Oh My Zsh git aliases, fzf integration, zoxide, and custom command aliases. Ctrl+r opens fzf history, Ctrl+t opens file selection, Alt+c selects a directory through fzf. Shell key tables depend on active emacs/vi mode; command aliases are typed commands rather than desktop shortcuts. Secret/local environment files are excluded.

### ~/.oh-my-zsh/lib/key-bindings.zsh

```zsh
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use emacs key bindings
bindkey -e

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
  bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M emacs "${terminfo[knp]}" down-line-or-history
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
  bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M emacs "^[[A" up-line-or-beginning-search
bindkey -M viins "^[[A" up-line-or-beginning-search
bindkey -M vicmd "^[[A" up-line-or-beginning-search
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M emacs "^[[B" down-line-or-beginning-search
bindkey -M viins "^[[B" down-line-or-beginning-search
bindkey -M vicmd "^[[B" down-line-or-beginning-search
if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}"  end-of-line
  bindkey -M viins "${terminfo[kend]}"  end-of-line
  bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char

  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word


bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' '^q ls\n'                            # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey ' ' magic-space                               # [Space] - don't do history expansion


# Edit the current command line in $VISUAL (or $EDITOR / `vi` if not set)
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

# consider emacs keybindings:

#bindkey -e  ## emacs key bindings
#
#bindkey '^[[A' up-line-or-search
#bindkey '^[[B' down-line-or-search
#bindkey '^[^[[C' emacs-forward-word
#bindkey '^[^[[D' emacs-backward-word
#
#bindkey -s '^X^Z' '%-^M'
#bindkey '^[e' expand-cmd-path
#bindkey '^[^I' reverse-menu-complete
#bindkey '^X^N' accept-and-infer-next-history
#bindkey '^W' kill-region
#bindkey '^I' complete-word
## Fix weird sequence that rxvt produces
#bindkey -s '^[[Z' '\t'
#
```

### ~/.oh-my-zsh/plugins/git/git.plugin.zsh

```zsh
# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

#
# Functions Current
# (sorted alphabetically by function name)
# (order should follow README)
#

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return 0
    fi
  done

  echo develop
  return 1
}

# Get the default branch name from common branch names or fallback to remote HEAD
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  
  local remote ref
  
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done
  
  # Fallback: try to get the default branch from remote HEAD symbolic refs
  for remote in origin upstream; do
    ref=$(command git rev-parse --abbrev-ref $remote/HEAD 2>/dev/null)
    if [[ $ref == $remote/* ]]; then
      echo ${ref#"$remote/"}; return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}

function gbcopy() {
  command git rev-parse --git-dir &>/dev/null || return

  local branch
  branch="$(git_current_branch)" || return
  [[ -n "$branch" ]] || return 1

  print -rn -- "$branch" | clipcopy
}

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

#
# Functions Work in Progress (WIP)
# (sorted alphabetically by function name)
# (order should follow README)
#

# Similar to `gunwip` but recursive "Unwips" all recent `--wip--` commits not just the last one
function gunwipall() {
  local _commit=$(git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H)

  # Check if a commit without "--wip--" was found and it's not the same as HEAD
  if [[ "$_commit" != "$(git rev-parse HEAD)" ]]; then
    git reset $_commit || return 1
  fi
}

# Warn if the current branch is a WIP
function work_in_progress() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

#
# Aliases
# (sorted alphabetically by command)
# (order should follow README)
# (in some cases force the alias order to match README, like for example gke and gk)
#

alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

function ggpnp() {
  if [[ $# == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout

alias ggpur='ggu'
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gamscp='git am --show-current-patch'
alias gams='git am --skip'
alias gap='git apply'
alias gapt='git apply --3way'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gbl='git blame -w'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

function gbda() {
  git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch --delete 2>/dev/null
}

# Copied and modified from James Roeder (jmaroeder) under MIT License
# https://github.com/jmaroeder/plugin-git/blob/216723ef4f9e8dde399661c39c80bdf73f4076c4/functions/gbda.fish
function gbds() {
  local default_branch
  default_branch=$(git_main_branch) \
    || default_branch=$(git_develop_branch)

  git for-each-ref refs/heads/ "--format=%(refname:short)" | \
    while read branch; do
      local merge_base=$(git merge-base $default_branch $branch)
      if [[ $(git cherry $default_branch $(git commit-tree $(git rev-parse $branch\^{tree}) -p $merge_base -m _)) = -* ]]; then
        git branch -D $branch
      fi
    done
}

alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remotes'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gclean='git clean --interactive -d'
alias gcl='git clone --recurse-submodules'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'

function gccd() {
  setopt localoptions extendedglob

  # get repo URI from args based on valid formats: https://git-scm.com/docs/git-clone#URLS
  local repo="${${@[(r)(ssh://*|git://*|ftp(s)#://*|http(s)#://*|*@*)(.git/#)#]}:-$_}"

  # clone repository and exit if it fails
  command git clone --recurse-submodules "$@" || return

  # if last arg passed was a directory, that's where the repo was cloned
  # otherwise parse the repo URI and use the last part as the directory
  [[ -d "$_" ]] && cd "$_" || cd "${${repo:t}%.git/#}"
}
compdef _git gccd=git-clone

alias gcam='git commit --all --message'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcs='git commit --gpg-sign'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias gcmsg='git commit --message'
alias gcsm='git commit --signoff --message'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcans!='git commit --verbose --all --signoff --no-edit --amend'
alias gcann!='git commit --verbose --all --date=now --no-edit --amend'
alias gc!='git commit --verbose --amend'
alias gcn='git commit --verbose --no-edit'
alias gcn!='git commit --verbose --no-edit --amend'
alias gcf='git config --list'
alias gcfu='git commit --fixup'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

function gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

alias gdup='git diff @{upstream}'

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff

alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gf='git fetch'
# --jobs=<n> was added in git 2.8
is-at-least 2.8 "$git_version" \
  && alias gfa='git fetch --all --tags --prune --jobs=10' \
  || alias gfa='git fetch --all --tags --prune'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ghh='git help'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glolm='git log $(git_main_branch) --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glom='git log --oneline --decorate --color $(git_main_branch)..'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
compdef _git _git_log_prettily=git-log

alias glp='_git_log_prettily'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gfg='git ls-files | grep'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms="git merge --squash"
alias gmff="git merge --ff-only"
alias gmom='git merge origin/$(git_main_branch)'
alias gmum='git merge upstream/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'

alias gl='git pull'
alias gpr='git pull --rebase'
alias gprv='git pull --rebase -v'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'

function ggu() {
  local b
  [[ $# != 1 ]] && b="$(git_current_branch)"
  git pull --rebase origin "${b:-$1}"
}
compdef _git ggu=git-pull

alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream $(git_main_branch)'
alias ggpull='git pull origin "$(git_current_branch)"'

function ggl() {
  if [[ $# != 0 ]] && [[ $# != 1 ]]; then
    git pull origin "${*}"
  else
    local b
    [[ $# == 0 ]] && b="$(git_current_branch)"
    git pull origin "${b:-$1}"
  fi
}
compdef _git ggl=git-pull

alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gp='git push'
alias gpd='git push --dry-run'

function ggf() {
  local b
  [[ $# != 1 ]] && b="$(git_current_branch)"
  git push --force origin "${b:-$1}"
}
compdef _git ggf=git-push

alias gpf!='git push --force'
is-at-least 2.30 "$git_version" \
  && alias gpf='git push --force-with-lease --force-if-includes' \
  || alias gpf='git push --force-with-lease'

function ggfl() {
  local b
  [[ $# != 1 ]] && b="$(git_current_branch)"
  git push --force-with-lease origin "${b:-$1}"
}
compdef _git ggfl=git-push

alias gpsup='git push --set-upstream origin $(git_current_branch)'
is-at-least 2.30 "$git_version" \
  && alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes' \
  || alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease'
alias gpv='git push --verbose'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias ggpush='git push origin "$(git_current_branch)"'

function ggp() {
  if [[ $# != 0 ]] && [[ $# != 1 ]]; then
    git push origin "${*}"
  else
    local b
    [[ $# == 0 ]] && b="$(git_current_branch)"
    git push origin "${b:-$1}"
  fi
}
compdef _git ggp=git-push

alias gpu='git push upstream'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grbd='git rebase $(git_develop_branch)'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbum='git rebase upstream/$(git_main_branch)'
alias grbmi='git rebase $(git_main_branch) --interactive'
alias grbmia='git rebase $(git_main_branch) --interactive --autosquash'
alias grf='git reflog'
alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grup='git remote update'
alias grh='git reset'
alias gru='git reset --'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gwipe='git reset --hard && git clean --force -df'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'
alias grm='git rm'
alias grmc='git rm --cached'
alias gcount='git shortlog --summary --numbered'
alias gsh='git show'
alias gshs='git show --stat'
alias gsps='git show --pretty=short --show-signature'
alias gstall='git stash --all'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
# use the default stash push on git 2.13 and newer
is-at-least 2.13 "$git_version" \
  && alias gsta='git stash push' \
  || alias gsta='git stash save'
alias gsts='git stash show --patch'
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'
alias gsnut='git status --untracked-files=no'
alias gsi='git submodule init'
alias gsu='git submodule update'
alias gsuri='git submodule update --recursive --init'
alias gsd='git svn dcommit'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'
alias gsr='git svn rebase'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'
alias gta='git tag --annotate'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias gwch='git log --patch --abbrev-commit --pretty=medium --raw'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'
alias gstu='gsta --include-untracked'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'
alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'

unset git_version

# Logic for adding warnings on deprecated aliases or functions
local old_name new_name
for old_name new_name (
  current_branch  git_current_branch
); do
  aliases[$old_name]="
    print -Pu2 \"%F{yellow}[oh-my-zsh] '%F{red}${old_name}%F{yellow}' is deprecated, using '%F{green}${new_name}%F{yellow}' instead.%f\"
    $new_name"
done
unset old_name new_name
```

### Personal aliases and fzf settings

```zsh
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
plugins=(git)
alias cd="z"
alias ls="eza --icons --git --group-directories-first"
alias ll="eza -lh --icons --git --group-directories-first"
alias la="eza -a --icons --git --group-directories-first"
alias lt="eza --tree --level=2 --icons"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source <(fzf --zsh)
alias cat="bat -p"
alias lg="lazygit"
alias ld="lazydocker"
alias vi="nvim"
alias v="nvim"
alias rg="rg --smart-case --hidden --glob '!.git/*'"
```

### ~/.config/zsh/functions/fzf.zsh

```zsh
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '\t↳ ' --highlight-line ${FZF_CTRL_R_OPTS-} $fzf_query +m --read0") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))"
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '\t↳ ' --highlight-line ${FZF_CTRL_R_OPTS-} $fzf_query +m") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))"
alias ffec='_fuzzy_edit_search_file_content' \
```

## Desktop mouse/menu actions and other configured shortcuts

Waybar click, release and scroll actions are shortcuts too. Entries below include their module and source context. Layout backups are historical and excluded.

### ~/.config/waybar/config.jsonc

```text
41:       "pulseaudio",
42:       "pulseaudio#microphone",
43:       "custom/updates",
44:       "custom/keybindhint"
45:     ]
46:   },
47:   "group/pill#right2": {
```

### ~/.config/waybar/includes/includes.json

```text
44:         "/home/sog/.local/share/waybar/modules/custom-updates.jsonc",
45:         "/home/sog/.local/share/waybar/modules/hyprland-workspaces#roman.jsonc",
46:         "/home/sog/.local/share/waybar/modules/hyprland-window.jsonc",
47:         "/home/sog/.local/share/waybar/modules/custom-keybindhint.jsonc",
48:         "/home/sog/.local/share/waybar/modules/idle_inhibitor.jsonc",
49:         "/home/sog/.local/share/waybar/modules/custom-powermenu.jsonc",
50:         "/home/sog/.local/share/waybar/modules/group-eyecare.jsonc",
```

## Legacy Hyprland `.conf` bindings

Preserved exactly for comparison and migration. The active runtime table is based on the current Lua session; do not install both full sets together.

### ~/dotfiles/.config/hypr/keybindings.conf

```ini
## █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
## █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█

# see https://wiki.hyprland.org/configuring/keywords/ for more
# example binds, see https://wiki.hyprland.org/configuring/binds/ for more

#? ------- KEYBINDS_HYPRLAND_V_0_53 COMPATIBLE ----------------
#   This Config is compatible with keybinding changes in Hyprland v0.53+
#   To ensure your system is working we will not disable this block
#   User template files will be provided in $XDG_DATA_HOME/hyde/templates/hypr/keybindings.conf for manual update.

#? ------- Grouping of binds for easier management ----------------
#  $d=[Group Name|Subgroup Name1|Subgroup Name2|...]
# '$d' is a variable that is used to group binds together (or use another variable)
# This is only for organization purposes and is not a defined hyprland variable
# What we did here is to modify the Description of the binds to include the group name
# The $d will be parsed as a separate key to be use for a GUI or something pretty
# [Main|Subgroup1|Subgroup2|...]
# Main - The main groupname
# Subgroup1.. - The subgroup names can be use to avoid repeating the same description

#? ------- Variables ----------------
# Default if commented out
# $mainMod = Super # super / meta / windows key
# Assign apps
# $TERMINAL = kitty
# $EDITOR = code
# $EXPLORER = dolphin
# $BROWSER = firefox

$wm=Window Management
$d=[$wm]
bindd = $mainMod, Q, $d close focused window, exec, hyde-shell dontkillsteam
bindd = Alt, F4, $d close focused window, exec, hyde-shell dontkillsteam
bindd = $mainMod, Delete, $d kill hyprland session, exec, hyde-shell logout
bindd = $mainMod, W, $d Toggle floating, togglefloating
bindd = $mainMod, G, $d toggle group, togglegroup
bindd = Shift, F11, $d toggle fullscreen, fullscreen
bindd = $mainMod, L, $d lock screen, exec, hyde-shell lock-session
bindd = $mainMod Shift, F, $d toggle pin on focused window, exec, hyde-shell windowpin
bindd = Control Alt, Delete, $d logout menu, exec, hyde-shell logoutlaunch
bindd = Alt_R, Control_R, $d toggle waybar and reload config, exec, hyde-shell waybar --hide
# bindd = ALT_R, Control_R,toggle waybar, exec, killall waybar || waybar # toggle waybar without reloading, this is faster

$d=[$wm|Group Navigation]
bindd = $mainMod Control, H, $d change active group backwards   , changegroupactive, b
bindd = $mainMod Control, L, $d change active group forwards  , changegroupactive, f

$d=[$wm|Change focus]
bindd = $mainMod, Left, $d focus left, movefocus, l
bindd = $mainMod, Right, $d focus right , movefocus, r
bindd = $mainMod, Up, $d focus up , movefocus, u
bindd = $mainMod, Down , $d focus down, movefocus, d
bindd = ALT, Tab,$d Cycle focus, cyclenext

$d=[$wm|Resize Active Window]
# Resize windows
bindde = $mainMod Shift, Right, $d resize window right , resizeactive, 30 0
bindde = $mainMod Shift, Left, $d resize window left, resizeactive, -30 0
bindde = $mainMod Shift, Up, $d resize window up, resizeactive, 0 -30
bindde = $mainMod Shift, Down, $d resize  window down, resizeactive, 0 30

# Move active window around current workspace with mainMod + Shift + Control [←→↑↓]
$d=[$wm|Move active window across workspace]
$moveactivewindow=grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive
bindde = $mainMod Shift Control, left, Move active window to the left, exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l
bindde = $mainMod Shift Control, right, Move active window to the right, exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r
bindde = $mainMod Shift Control, up, Move active window up, exec, $moveactivewindow  0 -30 || hyprctl dispatch movewindow u
bindde = $mainMod Shift Control, down, Move active window down, exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d

# Move/Resize focused window
$d=[$wm|Move & Resize with mouse]
binddm = $mainMod, mouse:272, $d hold to move window, movewindow
binddm = $mainMod, mouse:273, $d hold to resize window, resizewindow
binddm = $mainMod, Z, $d hold to move window , movewindow
binddm = $mainMod, X, $d hold to resize window, resizewindow

# Toggle focused window split
$d=[$wm]
bindd = $mainMod, J, $d toggle split, layoutmsg, togglesplit

$l=Launcher
$d=[$l|Apps]
bindd = $mainMod, T, $d terminal emulator , exec, $TERMINAL
bindd = $mainMod Alt, T, $d dropdown terminal , exec, hyde-shell pypr toggle console
bindd = $mainMod, E, $d file explorer , exec, $EXPLORER
bindd = $mainMod, C, $d text editor , exec, $EDITOR
bindd = $mainMod, B, $d web browser , exec, $BROWSER
bindd = Control Shift, Escape, $d system monitor , exec, hyde-shell system.monitor

$d=[$l|Rofi menus]
$rofi-launch=hyde-shell rofilaunch
bindd = $mainMod, A, $d application finder , exec, pkill -x rofi || $rofi-launch d
bindd = $mainMod, TAB, $d window switcher , exec, pkill -x rofi || $rofi-launch w
bindd = $mainMod Shift, E, $d file finder , exec, pkill -x rofi || $rofi-launch f
bindd = $mainMod, slash, $d keybindings hint, exec, pkill -x rofi || hyde-shell keybinds_hint c # launch keybinds hint
bindd = $mainMod, comma, $d emoji  picker , exec, pkill -x rofi || hyde-shell emoji-picker # launch emoji picker
bindd = $mainMod, period, $d glyph picker , exec, pkill -x rofi || hyde-shell glyph-picker # launch glyph picker
bindd = $mainMod, V, $d clipboard ,  exec, pkill -x rofi || hyde-shell cliphist -c # launch clipboard,
bindd = $mainMod Shift, V, $d clipboard manager , exec, pkill -x rofi || hyde-shell cliphist # launch clipboard Manager
bindd = $mainMod Shift, A, $d select rofi launcher , exec, pkill -x rofi || hyde-shell rofiselect # launch select menu


$hc=Hardware Controls
$d=[$hc|Audio]
binddl  = , F10, $d toggle mute output , exec, hyde-shell volumecontrol -o m # toggle audio mute
binddl  = , XF86AudioMute,$d  toggle mute output, exec, hyde-shell volumecontrol -o m # toggle audio mute
binddel = , F11, $d decrease volume , exec, hyde-shell volumecontrol -o d # decrease volume
binddel = , F12, $d increase volume , exec, hyde-shell volumecontrol -o i # increase volume
binddl  = , XF86AudioMicMute,$d un/mute microphone  , exec, hyde-shell volumecontrol -i m # toggle microphone mute
binddel = , XF86AudioLowerVolume, $d decrease volume , exec, hyde-shell volumecontrol -o d # decrease volume
binddel = , XF86AudioRaiseVolume, $d increase volume , exec, hyde-shell volumecontrol -o i # increase volume

$d=[$hc|Media]
binddl  = , XF86AudioPlay,$d play media, exec, playerctl play-pause # toggle between media play and pause
binddl  = , XF86AudioPause,$d pause media, exec, playerctl play-pause # toggle between media play and pause
binddl  = , XF86AudioNext,$d next media  , exec, playerctl next # media next
binddl  = , XF86AudioPrev,$d  previous media , exec, playerctl previous # media previous

$d=[$hc|Brightness]
binddel = , XF86MonBrightnessUp, $d increase brightness , exec, hyde-shell brightnesscontrol i # increase brightness
binddel = , XF86MonBrightnessDown, $d decrease brightness , exec, hyde-shell brightnesscontrol d # decrease brightness


$ut=Utilities
$d=[$ut]
binddl = $mainMod, K, $d toggle keyboard layout , exec, hyde-shell keyboardswitch # switch keyboard layout
bindd = $mainMod Alt, G, $d game mode , exec, hyde-shell gamemode # disable hypr effects for gamemode
bindd = $mainMod Shift, G, $d open game launcher , exec, hyde-shell gamelauncher # run game launcher for steam and lutris

$d=[$ut|Screen Capture]
bindd = $mainMod Shift, P, $d color picker, exec, hyprpicker -an # Pick color (Hex) >> clipboard#
bindd = $mainMod, P, $d snip screen , exec, hyde-shell screenshot s # partial screenshot capture
bindd = $mainMod Control, P, $d freeze and snip screen, exec, hyde-shell screenshot sf # partial screenshot capture (frozen screen)
binddl = $mainMod Alt, P, $d print monitor , exec, hyde-shell screenshot m # monitor screenshot capture
binddl = , Print, $d print all monitors , exec, hyde-shell screenshot p # all monitors screenshot capture

# TODO Make a main rofi menu for these selectors
$rice=Theming and Wallpaper
$d=[$rice]
bindd = $mainMod Alt, Right, $d next global wallpaper , exec, hyde-shell wallpaper -Gn # next global wallpaper
bindd = $mainMod Alt, Left, $d previous global wallpaper , exec, hyde-shell wallpaper -Gp # previous global wallpaper
bindd = $mainMod Shift, W, $d select a global wallpaper , exec, pkill -x rofi || hyde-shell wallpaper -SG # launch wallpaper select menu
bindd = $mainMod Alt, Up, $d next waybar layout , exec, hyde-shell wbarconfgen n # next waybar mode
bindd = $mainMod Alt, Down, $d previous waybar layout , exec, hyde-shell wbarconfgen p # previous waybar mode
bindd = $mainMod Shift, R, $d wallbash mode selector , exec, pkill -x rofi || hyde-shell wallbashtoggle -m # launch wallbash mode select menu
bindd = $mainMod Shift, T, $d select a theme, exec, pkill -x rofi || hyde-shell themeselect # launch theme select menu
bindd = $mainMod+Shift, Y, $d select animations, exec, pkill -x rofi || hyde-shell animations --select # launch animations select menu
bindd = $mainMod+Shift, U, $d select hyprlock layout, exec, pkill -x rofi || hyde-shell hyprlock --select # launch hyprlock layout select menu



$ws=Workspaces
$d=[$ws|Navigation]
bindd = $mainMod, 1, $d navigate to workspace 1 , workspace, 1
bindd = $mainMod, 2, $d navigate to workspace 2 , workspace, 2
bindd = $mainMod, 3, $d navigate to workspace 3 , workspace, 3
bindd = $mainMod, 4, $d navigate to workspace 4 , workspace, 4
bindd = $mainMod, 5, $d navigate to workspace 5 , workspace, 5
bindd = $mainMod, 6, $d navigate to workspace 6 , workspace, 6
bindd = $mainMod, 7, $d navigate to workspace 7 , workspace, 7
bindd = $mainMod, 8, $d navigate to workspace 8 , workspace, 8
bindd = $mainMod, 9, $d navigate to workspace 9 , workspace, 9
bindd = $mainMod, 0, $d navigate to workspace 10 , workspace, 10

$d=[$ws|Navigation|Relative workspace]
bindd = $mainMod Control, Right, $d change active workspace forwards  , workspace, r+1
bindd = $mainMod Control, Left, $d change active workspace backwards , workspace, r-1

$d=[$ws|Navigation]
bindd = $mainMod Control, Down, $d navigate to the nearest empty workspace , workspace, empty

# Move focused window to a workspace
$d=[$ws|Move window to workspace]
bindd = $mainMod Shift, 1, $d move to workspace 1 , movetoworkspace, 1
bindd = $mainMod Shift, 2, $d move to workspace 2 , movetoworkspace, 2
bindd = $mainMod Shift, 3, $d move to workspace 3 , movetoworkspace, 3
bindd = $mainMod Shift, 4, $d move to workspace 4 , movetoworkspace, 4
bindd = $mainMod Shift, 5, $d move to workspace 5 , movetoworkspace, 5
bindd = $mainMod Shift, 6, $d move to workspace 6 , movetoworkspace, 6
bindd = $mainMod Shift, 7, $d move to workspace 7 , movetoworkspace, 7
bindd = $mainMod Shift, 8, $d move to workspace 8 , movetoworkspace, 8
bindd = $mainMod Shift, 9, $d move to workspace 9 , movetoworkspace, 9
bindd = $mainMod Shift, 0, $d move to workspace 10 , movetoworkspace, 10

# Move focused window to a relative workspace
$d=[$ws]
bindd = $mainMod Control+Alt, Right, $d move window to next relative workspace , movetoworkspace, r+1
bindd = $mainMod Control+Alt, Left, $d move window to previous relative workspace , movetoworkspace, r-1


# Scroll through existing workspaces
$d=[$ws|Navigation]
bindd = $mainMod, mouse_down, $d next workspace, workspace, e+1
bindd = $mainMod, mouse_up, $d previous workspace, workspace, e-1


# Move/Switch to special workspace (scratchpad)
$d=[$ws|Navigation|Special workspace]
bindd = $mainMod Shift, S, $d move to scratchpad  , movetoworkspace, special
bindd = $mainMod Alt, S, $d move to scratchpad (silent) , movetoworkspacesilent, special
bindd = $mainMod, S, $d toggle scratchpad ,  togglespecialworkspace

# Move focused window to a workspace silently
$d=[$ws|Navigation|Move window silently]
bindd = $mainMod Alt, 1, $d move to workspace 1  (silent), movetoworkspacesilent, 1
bindd = $mainMod Alt, 2, $d move to workspace 2  (silent), movetoworkspacesilent, 2
bindd = $mainMod Alt, 3, $d move to workspace 3  (silent), movetoworkspacesilent, 3
bindd = $mainMod Alt, 4, $d move to workspace 4  (silent), movetoworkspacesilent, 4
bindd = $mainMod Alt, 5, $d move to workspace 5  (silent), movetoworkspacesilent, 5
bindd = $mainMod Alt, 6, $d move to workspace 6  (silent), movetoworkspacesilent, 6
bindd = $mainMod Alt, 7, $d move to workspace 7  (silent), movetoworkspacesilent, 7
bindd = $mainMod Alt, 8, $d move to workspace 8  (silent), movetoworkspacesilent, 8
bindd = $mainMod Alt, 9, $d move to workspace 9  (silent), movetoworkspacesilent, 9
bindd = $mainMod Alt, 0, $d move to workspace 10 (silent), movetoworkspacesilent, 10



$d=#! unset the group name
```

## HyDE menu-local shortcuts and supporting settings

Inside the clipboard menu: Alt+c copy, Alt+d delete, Alt+n favorites, Alt+w wipe, Alt+o options, Alt+v image view, Alt+s OCR scan. These are active inside the menu rather than global OS combinations. The complete handler below preserves context-dependent behavior.

### ~/.local/lib/hyde/cliphist.sh

```sh
#!/usr/bin/env bash
pkill -u "$USER" rofi && exit 0
[[ $HYDE_SHELL_INIT -ne 1 ]] && eval "$(hyde-shell init)"
cache_dir="${HYDE_CACHE_HOME:-$HOME/.cache/hyde}"
favorites_file="$cache_dir/landing/cliphist_favorites"
[ -f "$HOME/.cliphist_favorites" ] && favorites_file="$HOME/.cliphist_favorites"
cliphist_style="${ROFI_CLIPHIST_STYLE:-clipboard}"

# shellcheck disable=SC1091
[[ -f "${LIB_DIR}/hyde/shutils/l10n.sh" ]] && source "${LIB_DIR}/hyde/shutils/l10n.sh"


process_deletion() {
    while IFS= read -r line; do
        echo "$line"
        if [[ $line == ":w:i:p:e:"* ]]; then
            "$0" --wipe
            break
        elif [[ $line == ":b:a:r:"* ]]; then
            "$0" --delete
            break
        elif [ -n "$line" ]; then
            cliphist delete <<< "$line"
            notify-send "${_T["Deleted"]:-Deleted}" "$line"
        fi
    done
    exit 0
}
process_selections() {
    mapfile -t lines
    total_lines=${#lines[@]}
    handle_special_commands "${lines[@]}"
    local output=""
    for ((i = 0; i < total_lines; i++)); do
        local line="${lines[$i]}"
        local decoded_line
        decoded_line="$(echo -e "$line\t" | cliphist decode)"
        if [ $i -lt $((total_lines - 1)) ]; then
            printf -v output '%s%s\n' "$output" "$decoded_line"
        else
            printf -v output '%s%s' "$output" "$decoded_line"
        fi
    done
    echo -n "$output"
}
handle_special_commands() {
    local lines=("$@")
    case "${lines[0]}" in
        ":d:e:l:e:t:e:"*) exec "$0" --delete exit 0 ;;
        ":w:i:p:e:"*) exec "$0" --wipe exit 0 ;;
        ":b:a:r:"* | *":c:o:p:y:"*) exec "$0" --copy exit 0 ;;
        ":f:a:v:"*) exec "$0" --favorites exit 0 ;;
        ":i:m:g:") exec "$0" --image-history ;;
        ":o:p:t:"*) exec "$0" exit 0 ;;
        ":o:c:r:"*) exec "$0" --scan-image ;;
    esac
}
check_content() {
    local line
    read -r line
    if [[ $line == *"[[ binary data"* ]]; then
        cliphist decode <<< "$line" | wl-copy
        local img_idx
        img_idx=$(awk -F '\t' '{print $1}' <<< "$line")
        local temp_preview="$XDG_RUNTIME_DIR/hyde/pastebin-preview_$img_idx"
        wl-paste > "$temp_preview"
        notify-send -a "${_T["Pastebin:"]:-Pastebin:}" "${_T["Preview:"]:-Preview:} $img_idx" -i "$temp_preview" -t 2000
        return 1
    fi
}
run_rofi() {
    local placeholder="$1"
    shift
    rofi -dmenu \
        -theme-str "entry { placeholder: \"$placeholder\";}" \
        -theme-str "$font_override" \
        -theme-str "$r_override" \
        -theme-str "$rofi_position" \
        -theme "$cliphist_style" \
        -kb-custom-1 "Alt+c" \
        -kb-custom-2 "Alt+d" \
        -kb-custom-3 "Alt+n" \
        -kb-custom-4 "Alt+w" \
        -kb-custom-5 "Alt+o" \
        -kb-custom-6 "Alt+v" \
        -kb-custom-7 "Alt+s" \
        "$@"
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        case "$exit_code" in
            10) printf ":c:o:p:y:" ;;
            11) printf ":d:e:l:e:t:e:" ;;
            12) printf ":f:a:v:" ;;
            13) printf ":w:i:p:e:" ;;
            14) printf ":o:p:t:" ;;
            15) printf ":i:m:g:" ;;
            16) printf ":o:c:r:" ;;
        esac
    fi
}
setup_rofi_config() {
    local font_scale="$ROFI_CLIPHIST_SCALE"
    [[ $font_scale =~ ^[0-9]+$ ]] || font_scale=${ROFI_SCALE:-10}
    local font_name=${ROFI_CLIPHIST_FONT:-$ROFI_FONT}
    font_name=${font_name:-$(get_hyprConf "MENU_FONT")}
    font_name=${font_name:-$(get_hyprConf "FONT")}
    font_override="* {font: \"${font_name:-"JetBrainsMono Nerd Font"} $font_scale\";}"
    local hypr_border=${hypr_border:-"$(hyprctl -j getoption decoration:rounding | jq '.int')"}
    local wind_border=$((hypr_border * 3 / 2))
    local elem_border=$((hypr_border == 0 ? 5 : hypr_border))
    rofi_position=$(get_rofi_pos)
    local hypr_width=${hypr_width:-"$(hyprctl -j getoption general:border_size | jq '.int')"}
    r_override="window{border:${hypr_width}px;border-radius:${wind_border}px;}wallbox{border-radius:${elem_border}px;} element{border-radius:${elem_border}px;}"
}
ensure_favorites_dir() {
    local dir
    dir=$(dirname "$favorites_file")
    [ -d "$dir" ] || mkdir -p "$dir"
}
prepare_favorites_for_display() {
    if [ ! -f "$favorites_file" ] || [ ! -s "$favorites_file" ]; then
        return 1
    fi
    mapfile -t favorites < "$favorites_file"
    decoded_lines=()
    for favorite in "${favorites[@]}"; do
        local decoded_favorite
        decoded_favorite=$(echo "$favorite" | base64 --decode)
        local single_line_favorite
        single_line_favorite=$(echo "$decoded_favorite" | tr '\n' ' ')
        decoded_lines+=("$single_line_favorite")
    done
    return 0
}
cliphist_cmd() {
    if [[ $CLIPHIST_IMAGE_HISTORY != true ]]; then
        echo -e ":f:a:v:\t📌 ${_T["Favorites"]:-Favorites}"
        echo -e ":o:p:t:\t⚙️ ${_T["Options"]:-Options}"
        cliphist list
    else
        HYDE_CLIPHIST_IMAGE_ONLY=true cliphist.image.py
    fi
}
show_history() {
    local selected_item
    rofi_args=(" 📜 ${_T["History..."]:-History...}" -multi-select -i -display-columns 2 -selected-row 2)
    if [[ $CLIPHIST_IMAGE_HISTORY == true ]]; then
        rofi_args=(" 🏞️ ${_T["Image History | Alt+S to Scan"]:-Image History | Alt+S to Scan}" -display-columns 2
            -show-icons -eh 3
            -theme-str 'listview { lines: 4; columns: 2; }'
            -theme-str 'element { enabled: true; orientation: vertical; spacing: 0%; padding: 0%; cursor: pointer; background-color: transparent; text-color: @main-fg; horizontal-align: 0.5; }'
            -theme-str 'element-text { enabled: false;}'
            -theme-str 'element-icon {size: 8%; spacing: 0%; padding: 0%; cursor: inherit; background-color: transparent; }'
            -theme-str 'element selected.normal { background-color: @select-bg; text-color: @select-fg; }')
    fi

    selected_item=$(cliphist_cmd | run_rofi "${rofi_args[@]}")
    echo "${?}"
    echo "$selected_item"
    [ -n "$selected_item" ] || exit 0
    handle_special_commands "${selected_item##*$'\n'}"
    if echo -e "$selected_item" | check_content; then
        process_selections <<< "$selected_item" | wl-copy
        paste_string "$@"
        echo -e "$selected_item\t" | cliphist delete
    else
        paste_string "$@"
        exit 0
    fi
}

delete_items() {
    local selected_item
    selected_item="$(cliphist list | run_rofi " 🗑️ ${_T["Delete"]:-Delete}" -multi-select -i -display-columns 2)"
    handle_special_commands "${selected_item##*$'\n'}"
    process_deletion <<< "$selected_item"
}
view_favorites() {
    prepare_favorites_for_display || {
        notify-send "${_T["No favorites."]:-No favorites.}"
        return
    }
    local selected_item
    selected_item=$(printf "%s\n" "${decoded_lines[@]}" | run_rofi "📌 ${_T["View Favorites"]:-View Favorites}") || exit 0
    if [ -n "$selected_item" ]; then
        handle_special_commands "${selected_item##*$'\n'}"
        local index
        index=$(printf "%s\n" "${decoded_lines[@]}" | grep -nxF "$selected_item" | cut -d: -f1)
        if [ -n "$index" ]; then
            local selected_encoded_favorite="${favorites[$((index - 1))]}"
            echo "$selected_encoded_favorite" | base64 --decode | wl-copy
            paste_string "$@"
            notify-send "${_T["Copied to clipboard."]:-Copied to clipboard.}"
        else
            notify-send "${_T["Error: Selected favorite not found."]:-Error: Selected favorite not found.}"
        fi
    fi
}
add_to_favorites() {
    ensure_favorites_dir
    local item
    item=$(cliphist list | run_rofi "➕ ${_T["Add to Favorites..."]:-Add to Favorites...}") || exit 0
    if [ -n "$item" ]; then
        local full_item
        full_item=$(echo "$item" | cliphist decode)
        local encoded_item
        encoded_item=$(echo "$full_item" | base64 -w 0)
        if [ -f "$favorites_file" ] && grep -Fxq "$encoded_item" "$favorites_file"; then
            notify-send "${_T["Item is already in favorites."]:-Item is already in favorites.}"
        else
            echo "$encoded_item" >> "$favorites_file"
            notify-send "${_T["Added to favorites."]:-Added to favorites.}"
        fi
    fi
}
delete_from_favorites() {
    prepare_favorites_for_display || {
        notify-send "${_T["No favorites to remove."]:-No favorites to remove.}"
        return
    }
    local selected_favorite
    selected_favorite=$(printf "%s\n" "${decoded_lines[@]}" | run_rofi "➖ ${_T["Remove from Favorites..."]:-Remove from Favorites...}") || exit 0
    if [ -n "$selected_favorite" ]; then
        local index
        index=$(printf "%s\n" "${decoded_lines[@]}" | grep -nxF "$selected_favorite" | cut -d: -f1)
        if [ -n "$index" ]; then
            local selected_encoded_favorite="${favorites[$((index - 1))]}"
            if [ "$(wc -l < "$favorites_file")" -eq 1 ]; then
                : > "$favorites_file"
            else
                grep -vF -x "$selected_encoded_favorite" "$favorites_file" > "$favorites_file.tmp" && mv "$favorites_file.tmp" "$favorites_file"
            fi
            notify-send "${_T["Item removed from favorites."]:-Item removed from favorites.}"
        else
            notify-send "${_T["Error: Selected favorite not found."]:-Error: Selected favorite not found.}"
        fi
    fi
}
clear_favorites() {
    if [ -f "$favorites_file" ] && [ -s "$favorites_file" ]; then
        local confirm
        local yes_str="${_T["Yes"]:-Yes}"
        confirm=$(echo -e "${yes_str}\n${_T["No"]:-No}" | run_rofi "☢️ ${_T["Clear All Favorites?"]:-Clear All Favorites?}") || exit 0
        if [ "$confirm" = "$yes_str" ]; then
            : > "$favorites_file"
            notify-send "${_T["All favorites have been deleted."]:-All favorites have been deleted.}"
        fi
    else
        notify-send "${_T["No favorites to delete."]:-No favorites to delete.}"
    fi
}
manage_favorites() {
    local opt_add="${_T["Add to Favorites"]:-Add to Favorites}"
    local opt_del="${_T["Delete from Favorites"]:-Delete from Favorites}"
    local opt_clr="${_T["Clear All Favorites"]:-Clear All Favorites}"

    local manage_action
    manage_action=$(echo -e "${opt_add}\n${opt_del}\n${opt_clr}" | run_rofi "📓 ${_T["Manage Favorites"]:-Manage Favorites}") || exit 0
    case "$manage_action" in
        "$opt_add")
            add_to_favorites
            ;;
        "$opt_del")
            delete_from_favorites
            ;;
        "$opt_clr")
            clear_favorites
            ;;
        *)
            [ -n "$manage_action" ] || return 0
            echo "Invalid action"
            exit 1
            ;;
    esac
}
clear_history() {
    local selected_item
    local yes_str="${_T["Yes"]:-Yes}"
    selected_item=$(echo -e "${yes_str}\n${_T["No"]:-No}" | run_rofi "☢️ ${_T["Clear Clipboard History?"]:-Clear Clipboard History?}")
    handle_special_commands "${selected_item##*$'\n'}"
    if [ "$selected_item" = "$yes_str" ]; then
        cliphist wipe
        notify-send "${_T["Clipboard history cleared."]:-Clipboard history cleared.}"
    fi
}
main_menu_options() {
    cat <<- EOF
		${_T["History"]:-History}:::<sub>(Alt+C)</sub>
		${_T["Image History"]:-Image History}:::<sub>(Alt+V)</sub>
		${_T["Delete Item"]:-Delete Item}:::<sub>(Alt+D)</sub>
		${_T["Clear History"]:-Clear History}:::<sub>(Alt+W)</sub>
		${_T["View Favorites"]:-View Favorites}:::<sub>(Alt+N)</sub>
		${_T["Manage Favorites"]:-Manage Favorites}:::<sub>(Alt+O)</sub>
	EOF
}

ocr_scan() {

    # shellcheck disable=SC1091
    source "${LIB_DIR}/hyde/shutils/ocr.sh"
    source ${XDG_STATE_HOME}/hyde/config
    local runtime_dir="${XDG_RUNTIME_DIR:-/run/user/${EUID}}/hyde"
    local image_path="${runtime_dir}/cliphist_ocr.png"
    local index
    index="$(HYDE_CLIPHIST_IMAGE_ONLY=1 "${LIB_DIR}/hyde/cliphist.image.py" | head -n1)"
    [[ -n $index ]] || {
        send_notifs "${_T["OCR Error"]:-OCR Error}" "${_T["No images in clipboard history..."]:-No images in clipboard history...}" -r 9
        exit 1
    }

    mkdir -p "$runtime_dir"
    cliphist decode "$index" > "${image_path}"
    if [ ! -s "${image_path}" ]; then
        notify-send "${_T["OCR Error"]:-OCR Error}" "${_T["No image data in clipboard -r 9"]:-No image data in clipboard -r 9}"
        exit 1
    fi
    print_log -g "Scanning ${image_path}"
    send_notifs "${_T["OCR"]:-OCR}" "${_T["Scanning latest image from clipboard..."]:-Scanning latest image from clipboard...}" -i "${image_path}" -r 9
    ocr_extract "$image_path"

}

main() {
    setup_rofi_config

    # shellcheck disable=SC1091
    source "${LIB_DIR}/hyde/shutils/argparse.sh"

    argparse_init "$@"
    argparse_program "hyde-shell cliphist"
    argparse_header "HyDE Clipboard Manager"

    argparse "--copy,-c" "ACTION=copy" "Show clipboard history and copy selected item"
    argparse "--delete,-d" "ACTION=delete" "Delete selected item from clipboard history"
    argparse "--favorites,-f" "ACTION=favorites" "View favorite clipboard items"
    argparse "--manage-fav,-mf" "ACTION=manage_fav" "Manage favorite clipboard items"
    argparse "--wipe,-w" "ACTION=wipe" "Clear clipboard history"
    argparse "--image-history,-i" "ACTION=image_history" "Show image history"
    argparse "--scan-image,-sc" "ACTION=ocr_image" "Use tesseract the latest image from clipboard"
    argparse_finalize

    unset CLIPHIST_IMAGE_HISTORY # prevent image history side effects

    if [ -z "$ACTION" ]; then
        # Localized options for menu matching
        local opt_hist="${_T["History"]:-History}"
        local opt_imgh="${_T["Image History"]:-Image History}"
        local opt_del="${_T["Delete Item"]:-Delete Item}"
        local opt_clr="${_T["Clear History"]:-Clear History}"
        local opt_vfav="${_T["View Favorites"]:-View Favorites}"
        local opt_mfav="${_T["Manage Favorites"]:-Manage Favorites}"

        # No arguments provided, show menu
        local main_action
        main_action=$(
            main_menu_options | run_rofi "🔎 ${_T["Options (Alt O)"]:-Options (Alt O)}" \
                -display-column-separator ":::" \
                -display-columns 1,2 \
                -markup-rows
        )
        handle_special_commands "${main_action##*$'\n'}"

        main_action="${main_action%%:::*}"

        case "$main_action" in
            "$opt_hist") ACTION=copy ;;
            "$opt_imgh") ACTION=image_history ;;
            "$opt_del") ACTION=delete ;;
            "$opt_clr") ACTION=wipe ;;
            "$opt_vfav") ACTION=favorites ;;
            "$opt_mfav") ACTION=manage_fav ;;
            *) exit 0 ;;
        esac
    fi

    # Execute the action
    case "$ACTION" in
        copy) show_history "$@" ;;
        delete) delete_items ;;
        favorites) view_favorites "$@" ;;
        manage_fav) manage_favorites ;;
        wipe) clear_history ;;
        image_history) CLIPHIST_IMAGE_HISTORY=true show_history "$@" ;;
        ocr_image) ocr_scan ;;
    esac
}
main "$@"
```

### ~/.config/pypr/config.toml

```toml
# Since Pyprland is very configurable, this is just a basic example config
# to get you started. For more information, see the Pyprland documentation:
# https://hyprland-community.github.io/pyprland/


# Since You are using Hyde, you can use `hyde-shell` to run pypr commands
# See  'hyde-shell pypr help' for more information on how to use it!

[pyprland]
    # pypr has a lot of plugins, but this is just a basic example config
    # https://hyprland-community.github.io/pyprland/Plugins.html
    plugins = [ "scratchpads" ]

# using variables for demonstration purposes (not needed)
[pyprland.variables]
    # term_with_class = "hyde-shell app -T" # You cannot set the class for this
    # term_with_class = "alacritty --class"
    # term_with_class = "foot --app-id"
    term_with_class = "kitty --class"


[scratchpads.console]
    # This is a drop-down terminal configuration
    animation = "fromTop"
    class     = "console-dropdown"
    command   = "[term_with_class] console-dropdown"
    max_size  = "90% 100%"
    size      = "75% 60%"
```

### ~/.local/share/hypr/lua/variables.lua

```lua
local systemd_env = {
    "WAYLAND_DISPLAY",
    "XDG_CURRENT_DESKTOP",
    "XDG_SESSION_TYPE",
    "XDG_SESSION_DESKTOP",
    "XDG_CONFIG_HOME",
    "XDG_DATA_HOME",
    "XDG_CACHE_HOME",
    "XDG_STATE_HOME",
    "QT_QPA_PLATFORMTHEME"
}
local systemd_env_str = table.concat(systemd_env, " ")

local unt = "hyde-" .. (os.getenv("XDG_SESSION_DESKTOP") or "") -- Holder for the unit name
local svc = "service" -- Holder for the service command
local scp = "scope" -- Holder for the scope command

-- hyde env
hyde.env("XDG_CURRENT_DESKTOP", "Hyprland")
hyde.env("XDG_SESSION_TYPE", "wayland")
hyde.env("XDG_SESSION_DESKTOP", "Hyprland")
hyde.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hyde.env("QT_QPA_PLATFORM", "wayland;xcb")
hyde.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hyde.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hyde.env("MOZ_ENABLE_WAYLAND", "1")
hyde.env("GDK_SCALE", "1")
hyde.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hyde.env("XDG_CONFIG_HOME", os.getenv("XDG_CONFIG_HOME") or ((os.getenv("HOME") or "") .. "/.config"))
hyde.env("XDG_CACHE_HOME", os.getenv("XDG_CACHE_HOME") or ((os.getenv("HOME") or "") .. "/.cache"))
hyde.env("XDG_DATA_HOME", os.getenv("XDG_DATA_HOME") or ((os.getenv("HOME") or "") .. "/.local/share"))
hyde.env("XDG_STATE_HOME", os.getenv("XDG_STATE_HOME") or ((os.getenv("HOME") or "") .. "/.local/state"))
hyde.env("PATH", os.getenv("PATH") or "")

local hc = hyde.config

-- Startup commands

hc.start.dbus_share_picker = "dbus-update-activation-environment --systemd " .. systemd_env_str
hc.start.systemd_share_picker = "systemctl --user import-environment " .. systemd_env_str
hc.start.xdg_portal_reset = "hyde-shell resetxdgportal.lua"
hc.start.auth_dialogue = "hyde-shell app -t " .. svc .. " -- polkitkdeauth.sh"
hc.start.idle_daemon = "hyde-shell app -u " .. unt .. "-idle.service -t " .. svc .. " -- hypridle"
hc.start.blue_light_filter_daemon =
    "hyde-shell app -u " .. unt .. "-blue-light-filter.service -t " .. svc .. " -- hyprsunset"
hc.start.text_clipboard =
    "hyde-shell app -u " ..
    unt .. "-text-clipboard.service -t " .. svc .. " wl-paste --type text --watch cliphist store"
hc.start.image_clipboard =
    "hyde-shell app -u " ..
    unt .. "-image-clipboard.service -t " .. svc .. " wl-paste --type image --watch cliphist store"
hc.start.clipboard_persist =
    "hyde-shell app -u " .. unt .. "-clipboard-persist.service -t " .. svc .. " wl-clip-persist --clipboard regular"
hc.start.wallpaper =
    "hyde-shell app -u " .. unt .. "-wallpaper.service -t " .. svc .. " -- wallpaper.sh --start --global"
hc.start.bar = "hyde-shell app -u " .. unt .. "-bar.scope -t " .. scp .. " -- waybar.py --watch" -- waybar.py injects it itself as -u $unt.service :- therefore we use scope here to avoid conflicts
hc.start.notifications = "hyde-shell app -u " .. unt .. "-notifications.service -t " .. svc .. " -- dunst"
hc.start.battery_notify = "hyde-shell app -u " .. unt .. "-battery-notify.service -t " .. svc .. " -- batterynotify.lua"
hc.start.applet_network_manager =
    "hyde-shell app -u " .. unt .. "-network-manager-applet.service -t " .. svc .. " -- nm-applet --indicator"
hc.start.applet_removable_media =
    "hyde-shell app -u " ..
    unt .. "-removable-media-applet.service -t " .. svc .. " -- udiskie --no-automount --smart-tray"
hc.start.applet_bluetooth =
    "hyde-shell app -u " .. unt .. "-bluetooth-applet.service -t " .. svc .. " -- blueman-applet"
hc.start.hyde_config = "hyde-shell app -u " .. unt .. "-config-watcher.service -t " .. svc .. " -- config.lua"

-- Themes (assign to hyde.config.ui)
hc.ui.hyde_theme = "HyDE"
hc.ui.gtk_theme = "Wallbash-Gtk"
hc.ui.icon_theme = "Tela-circle-dracula"
hc.ui.color_scheme = "prefer-dark"
hc.ui.button_layout = "" -- colon separated list of buttons

-- Cursor
hc.ui.cursor_theme = "Bibata-Modern-Ice"
hc.ui.cursor_size = 24

-- Fonts
hc.ui.font = "Cantarell"
hc.ui.font_size = 10
hc.ui.document_font = "Cantarell"
hc.ui.document_font_size = 10
hc.ui.monospace_font = "CaskaydiaCove Nerd Font Mono"
hc.ui.monospace_font_size = 9
hc.ui.notification_font = "Mononoki Nerd Font Mono"
hc.ui.bar_font = "JetBrainsMono Nerd Font"
hc.ui.menu_font = "JetBrainsMono Nerd Font"
hc.ui.font_antialiasing = "rgba"
hc.ui.font_hinting = ""

-- Extra Themes
hc.ui.code_theme = ""
hc.ui.sddm_theme = ""

-- Apps and launchers
hc.app.quickapps = nil
hc.app.browser = "hyde-shell open --fall firefox web-browser"
hc.app.editor = "hyde-shell open --fall code-oss code-editor"
hc.app.explorer = "hyde-shell open --fall dolphin file-manager"
hc.app.terminal = "hyde-shell app -T"
hc.app.lockscreen = "hyde-shell lock-session"

-- Mod keys
hc.modifiers.main = "SUPER"
hc.modifiers.shift = "SHIFT"
hc.modifiers.alt = "ALT"
hc.modifiers.ctrl = "CTRL"
```

### ~/.local/share/hypr/lua/workflows/snappy.lua

```lua
local workflow = {
  name = "Snappy",
  icon = "󰓅",
  description = "A snappy desktop with no animations and effects, but preserving readability",
}

if not hl then
  return workflow
end

hl.config({
  decoration = {
    rounding = 0,
  },
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 1,
  },
  animations = {
    enabled = false,
  },
})
```

## fzf installed Zsh key integration

Ctrl+r history, Ctrl+t files, Alt+c directories. The installed integration below contains bindings for the emacs, vi-insert, and vi-command key tables, including picker-specific acceptance behavior.

### /usr/share/fzf/key-bindings.zsh

```zsh
#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.zsh
#
# - $FZF_CTRL_T_COMMAND
# - $FZF_CTRL_T_OPTS
# - $FZF_CTRL_R_COMMAND
# - $FZF_CTRL_R_OPTS
# - $FZF_ALT_C_COMMAND
# - $FZF_ALT_C_OPTS


# Key bindings
# ------------

# The code at the top and the bottom of this file is the same as in completion.zsh.
# Refer to that file for explanation.
if 'zmodload' 'zsh/parameter' 2>'/dev/null' && (( ${+options} )); then
  __fzf_key_bindings_options="options=(${(j: :)${(kv)options[@]}})"
else
  () {
    __fzf_key_bindings_options="setopt"
    'local' '__fzf_opt'
    for __fzf_opt in "${(@)${(@f)$(set -o)}%% *}"; do
      if [[ -o "$__fzf_opt" ]]; then
        __fzf_key_bindings_options+=" -o $__fzf_opt"
      else
        __fzf_key_bindings_options+=" +o $__fzf_opt"
      fi
    done
  }
fi

'builtin' 'emulate' 'zsh' && 'builtin' 'setopt' 'no_aliases'

{
if [[ -o interactive ]]; then

#----BEGIN INCLUDE common.sh
# NOTE: Do not directly edit this section, which is copied from "common.sh".
# To modify it, one can edit "common.sh" and run "./update.sh" to apply
# the changes. See code comments in "common.sh" for the implementation details.

__fzf_defaults() {
  builtin printf '%s\n' "--height ${FZF_TMUX_HEIGHT:-40%} --min-height 20+ --bind=ctrl-z:ignore $1"
  command cat "${FZF_DEFAULT_OPTS_FILE-}" 2> /dev/null
  builtin printf '%s\n' "${FZF_DEFAULT_OPTS-} $2"
}

__fzf_exec_awk() {
  if [[ -z ${__fzf_awk-} ]]; then
    __fzf_awk=awk
    if [[ $OSTYPE == solaris* && -x /usr/xpg4/bin/awk ]]; then
      __fzf_awk=/usr/xpg4/bin/awk
    elif command -v mawk > /dev/null 2>&1; then
      local n x y z d
      IFS=' .' read -r n x y z d <<< $(command mawk -W version 2> /dev/null)
      [[ $n == mawk ]] &&
        (((x * 1000 + y) * 1000 + z >= 1003004)) 2> /dev/null &&
        ((d >= 20230302)) 2> /dev/null &&
        __fzf_awk=mawk
    fi
  fi
  LC_ALL=C exec "$__fzf_awk" "$@"
}
#----END INCLUDE

# CTRL-T - Paste the selected file path(s) into the command line
__fzf_select() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  FZF_DEFAULT_COMMAND=${FZF_CTRL_T_COMMAND:-} \
  FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=file,dir,follow,hidden --scheme=path" "${FZF_CTRL_T_OPTS-} -m") \
  FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd) "$@" < /dev/tty | while read -r item; do
    echo -n -E "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

__fzfcmd() {
  [ -n "${TMUX_PANE-}" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "${FZF_TMUX_OPTS-}" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fzf_select)"
  local ret=$?
  zle reset-prompt
  return $ret
}
if [[ "${FZF_CTRL_T_COMMAND-x}" != "" ]]; then
  zle     -N            fzf-file-widget
  bindkey -M emacs '^T' fzf-file-widget
  bindkey -M vicmd '^T' fzf-file-widget
  bindkey -M viins '^T' fzf-file-widget
fi

# ALT-C - cd into the selected directory
fzf-cd-widget() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(
    FZF_DEFAULT_COMMAND=${FZF_ALT_C_COMMAND:-} \
    FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ALT_C_OPTS-} +m") \
    FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd) < /dev/tty)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  # Use subshell expansion to get the absolute PWD of the target dir.
  # This allows the recorded shell history to be reused even from a different
  # working directory.
  # If failed, fallback to the unexpanded path to surface the error to the user.
  # NOTE: Don't use the `:a` modifier as it resolves symlinks like `pwd -P`.
  dir=$(builtin cd -q >/dev/null -- "${dir}" && echo "${PWD}" || echo "${dir}")
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="builtin cd -- ${(q)dir}"
  zle accept-line
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}
if [[ "${FZF_ALT_C_COMMAND-x}" != "" ]]; then
  zle     -N             fzf-cd-widget
  bindkey -M emacs '\ec' fzf-cd-widget
  bindkey -M vicmd '\ec' fzf-cd-widget
  bindkey -M viins '\ec' fzf-cd-widget
fi

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected extracted_with_perl=0
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases no_glob no_sh_glob no_ksharrays extendedglob 2> /dev/null
  # Ensure the module is loaded if not already, and the required features, such
  # as the associative 'history' array, which maps event numbers to full history
  # lines, are set. Also, make sure Perl is installed for multi-line output.
  if zmodload -F zsh/parameter p:{commands,history} 2>/dev/null && (( ${+commands[perl]} )); then
    extracted_with_perl=1
    selected="$(printf '%s\t%s\000' "${(kv)history[@]}" |
      perl -0 -ne 'if (!$seen{(/^\s*[0-9]+\**\t(.*)/s, $1)}++) { s/\n/\n\t/g; print; }' |
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,alt-r:toggle-raw --wrap-sign '\t↳ ' --highlight-line --multi ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} --read0") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))"
  else
    selected="$(fc -rl 1 | __fzf_exec_awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,alt-r:toggle-raw --wrap-sign '\t↳ ' --highlight-line --multi ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER}") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))"
  fi
  local ret=$?
  local -a cmds
  # Avoid leaking auto assigned values when using backreferences '(#b)'
  local -a mbegin mend match
  if [ -n "$selected" ]; then
    # Heuristic to check if the selected value is from history or a custom query
    if ((( extracted_with_perl )) && [[ $selected == <->$'\t'* ]]) ||
    ((( ! extracted_with_perl )) && [[ $selected == [[:blank:]]#<->(  |\* )* ]]); then
      # Split at newlines
      for line in ${(ps:\n:)selected}; do
        if (( extracted_with_perl )); then
          if [[ $line == (#b)(<->)(#B)$'\t'* ]]; then
            (( ${+history[${match[1]}]} )) && cmds+=("${history[${match[1]}]}")
          fi
        elif [[ $line == [[:blank:]]#(#b)(<->)(#B)(  |\* )* ]]; then
          # Avoid $history array: lags behind 'fc' on foreign commands (*)
          # https://zsh.org/mla/users/2024/msg00692.html
          # Push BUFFER onto stack; fetch and save history entry from BUFFER; restore
          zle .push-line
          zle vi-fetch-history -n ${match[1]}
          (( ${#BUFFER} )) && cmds+=("${BUFFER}")
          BUFFER=""
          zle .get-line
        fi
      done
      if (( ${#cmds[@]} )); then
        # Join by newline after stripping trailing newlines from each command
        BUFFER="${(pj:\n:)${(@)cmds%%$'\n'#}}"
        CURSOR=${#BUFFER}
      fi
    else # selected is a custom query, not from history
      LBUFFER="$selected"
    fi
  fi
  zle reset-prompt
  return $ret
}
if [[ ${FZF_CTRL_R_COMMAND-x} != "" ]]; then
  if [[ -n ${FZF_CTRL_R_COMMAND-} ]]; then
    echo "warning: FZF_CTRL_R_COMMAND is set to a custom command, but custom commands are not yet supported for CTRL-R" >&2
  fi
  zle     -N            fzf-history-widget
  bindkey -M emacs '^R' fzf-history-widget
  bindkey -M vicmd '^R' fzf-history-widget
  bindkey -M viins '^R' fzf-history-widget
fi
fi

} always {
  eval $__fzf_key_bindings_options
  'unset' '__fzf_key_bindings_options'
}
```

## Lazygit installed default shortcuts

Opened by shell alias `lg`, tmux prefix+g, and Neovim Git bindings. The following is the installed English keybinding reference. There was no personal `~/.config/lazygit/config.yml` at extraction.

_This file is auto-generated. To update, make the changes in the pkg/i18n directory and then run `go generate ./...` from the project root._

# Lazygit Keybindings

## Global keybindings

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+r> `` | Switch to a recent repo |  |
| `` <pgup>, K, <ctrl+u> (fn+up/shift+k) `` | Scroll up main window |  |
| `` <pgdown>, J, <ctrl+d> (fn+down/shift+j) `` | Scroll down main window |  |
| `` @ `` | View command log options | View options for the command log e.g. show/hide the command log and focus the command log. |
| `` P `` | Push | Push the current branch to its upstream branch. If no upstream is configured, you will be prompted to configure an upstream branch. If other branches are stacked below the current one and have commits to push, you are offered to push those too. |
| `` p `` | Pull | Pull changes from the remote for the current branch. If no upstream is configured, you will be prompted to configure an upstream branch. If other branches are stacked below the current one and have changed on the remote, you are offered to update those too. |
| `` ) `` | Increase rename similarity threshold | Increase the similarity threshold for a deletion and addition pair to be treated as a rename.<br><br>The default can be changed in the config file with the key 'git.renameSimilarityThreshold'. |
| `` ( `` | Decrease rename similarity threshold | Decrease the similarity threshold for a deletion and addition pair to be treated as a rename.<br><br>The default can be changed in the config file with the key 'git.renameSimilarityThreshold'. |
| `` } `` | Increase diff context size | Increase the amount of the context shown around changes in the diff view.<br><br>The default can be changed in the config file with the key 'git.diffContextSize'. |
| `` { `` | Decrease diff context size | Decrease the amount of the context shown around changes in the diff view.<br><br>The default can be changed in the config file with the key 'git.diffContextSize'. |
| `` : `` | Execute shell command | Bring up a prompt where you can enter a shell command to execute. |
| `` <ctrl+p> `` | View custom patch options |  |
| `` m `` | View merge/rebase options | View options to abort/continue/skip the current merge/rebase. |
| `` R `` | Refresh | Refresh the git state (i.e. run `git status`, `git branch`, etc in background to update the contents of panels). This does not run `git fetch`. |
| `` + `` | Next screen mode (normal/half/fullscreen) |  |
| `` _ `` | Prev screen mode |  |
| `` \| `` | Cycle diff renderers | Choose the next renderer in the list of configured diff renderers. |
| `` \ `` | Cycle diff renderers (reverse) | Choose the previous renderer in the list of configured diff renderers. |
| `` <ctrl+g> `` | Jump to file in diff | Pick one of the files of the diff shown in the main view, and scroll the main view to it. The focus stays in this panel. |
| `` <esc> `` | Cancel |  |
| `` ? `` | Open keybindings menu |  |
| `` <ctrl+s> `` | View filter options | View options for filtering the commit log, so that only commits matching the filter are shown. |
| `` W, <ctrl+e> `` | View diffing options | View options relating to diffing two refs e.g. diffing against selected ref, entering ref to diff against, and reversing the diff direction. |
| `` q, <ctrl+c> `` | Quit |  |
| `` <ctrl+z> `` | Suspend the application |  |
| `` <ctrl+w> `` | Toggle whitespace | Toggle whether or not whitespace changes are shown in the diff view.<br><br>The default can be changed in the config file with the key 'git.ignoreWhitespaceInDiffView'. |
| `` <alt+shift+c> `` | Edit config file | Open file in external editor. |
| `` z `` | Undo | The reflog will be used to determine what git command to run to undo the last git command. This does not include changes to the working tree; only commits are taken into consideration. |
| `` Z `` | Redo | The reflog will be used to determine what git command to run to redo the last git command. This does not include changes to the working tree; only commits are taken into consideration. |

## List panel navigation

| Key | Action | Info |
|-----|--------|-------------|
| `` , `` | Previous page |  |
| `` . `` | Next page |  |
| `` <, <home> `` | Scroll to top |  |
| `` >, <end> `` | Scroll to bottom |  |
| `` v `` | Toggle range select |  |
| `` <shift+down> `` | Range select down |  |
| `` <shift+up> `` | Range select up |  |
| `` / `` | Search the current view by text |  |
| `` H `` | Scroll left |  |
| `` L `` | Scroll right |  |
| `` ] `` | Next tab |  |
| `` [ `` | Previous tab |  |

## Commit files

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy path to clipboard |  |
| `` y `` | Copy to clipboard |  |
| `` c `` | Checkout | Checkout file. This replaces the file in your working tree with the version from the selected commit. |
| `` d `` | Discard | Discard this commit's changes to this file. This runs an interactive rebase in the background, so you may get a merge conflict if a later commit also changes this file. |
| `` o `` | Open file | Open file in default application. |
| `` e `` | Edit | Open file in external editor. |
| `` <ctrl+t> `` | Open external diff tool (git difftool) |  |
| `` <space> `` | Toggle file included in patch | Toggle whether the file is included in the custom patch. See https://github.com/jesseduffield/lazygit#rebase-magic-custom-patches. |
| `` a `` | Toggle all files | Add/remove all commit's files to custom patch. See https://github.com/jesseduffield/lazygit#rebase-magic-custom-patches. |
| `` <enter> `` | Focus file diff / Toggle directory | If a file is selected, focus its diff so you can act on individual lines. If it is a directory, collapse or expand it. |
| `` ` `` | Toggle file tree view | Toggle file view between flat and tree layout. Flat layout shows all file paths in a single list, tree layout groups files by directory.<br><br>The default can be changed in the config file with the key 'gui.showFileTree'. |
| `` - `` | Collapse all files | Collapse all directories in the files tree |
| `` = `` | Expand all files | Expand all directories in the file tree |
| `` 0 `` | Focus main view |  |
| `` / `` | Filter the current view by text |  |

## Commit summary

| Key | Action | Info |
|-----|--------|-------------|
| `` <enter> `` | Confirm |  |
| `` <esc> `` | Close |  |

## Commits

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy abbreviated commit hash to clipboard |  |
| `` <ctrl+r> `` | Reset copied (cherry-picked) commits selection |  |
| `` b `` | View bisect options |  |
| `` s `` | Squash | Squash the selected commit into the commit below it. The selected commit's message will be appended to the commit below it. |
| `` f `` | Fixup | Meld the selected commit into the commit below it. Similar to squash, but the selected commit's message will be discarded. |
| `` c `` | Set fixup message | Set the message option for the fixup commit. The -C option means to use this commit's message instead of the target commit's message. |
| `` r `` | Reword | Reword the selected commit's message. |
| `` R `` | Reword with editor |  |
| `` d `` | Drop | Drop the selected commit. This will remove the commit from the branch via a rebase. If the commit makes changes that later commits depend on, you may need to resolve merge conflicts. |
| `` e `` | Edit (start interactive rebase) | Edit the selected commit. Use this to start an interactive rebase from the selected commit. When already mid-rebase, this will mark the selected commit for editing, which means that upon continuing the rebase, the rebase will pause at the selected commit to allow you to make changes. |
| `` i `` | Start interactive rebase | Start an interactive rebase for the commits on your branch. This will include all commits from the HEAD commit down to the first merge commit or main branch commit.<br>If you would instead like to start an interactive rebase from the selected commit, press `e`. |
| `` p `` | Pick | Mark the selected commit to be picked (when mid-rebase). This means that the commit will be retained upon continuing the rebase. |
| `` F `` | Create fixup commit | Create 'fixup!' commit for the selected commit. Later on, you can press `S` on this same commit to apply all above fixup commits. |
| `` S `` | Apply fixup commits | Squash all 'fixup!' commits, either above the selected commit, or all in current branch (autosquash). |
| `` <ctrl+j>, <alt+down> `` | Move commit down one |  |
| `` <ctrl+k>, <alt+up> `` | Move commit up one |  |
| `` V `` | Paste (cherry-pick) |  |
| `` B `` | Mark as base commit for rebase | Select a base commit for the next rebase. When you rebase onto a branch, only commits above the base commit will be brought across. This uses the `git rebase --onto` command. |
| `` A `` | Amend | Amend commit with staged changes. If the selected commit is the HEAD commit, this will perform `git commit --amend`. Otherwise the commit will be amended via a rebase. |
| `` a `` | Amend commit attribute | Set/Reset commit author or set co-author. |
| `` t `` | Revert | Create a revert commit for the selected commit, which applies the selected commit's changes in reverse. |
| `` T `` | Tag commit | Create a new tag pointing at the selected commit. You'll be prompted to enter a tag name and optional description. |
| `` <ctrl+l> `` | View log options | View options for commit log e.g. changing sort order, hiding the git graph, showing the whole git graph. |
| `` G `` | Open pull request in browser |  |
| `` <space> `` | Checkout | Checkout the selected commit as a detached HEAD. |
| `` y `` | Copy commit attribute to clipboard | Copy commit attribute to clipboard (e.g. hash, URL, diff, message, author). |
| `` o `` | Open commit in browser |  |
| `` n `` | Create new branch off of commit |  |
| `` N `` | Move commits to new branch | Create a new branch and move the unpushed commits of the current branch to it. Useful if you meant to start new work and forgot to create a new branch first.<br><br>Note that this disregards the selection, the new branch is always created either from the main branch or stacked on top of the current branch (you get to choose which). |
| `` w `` | New worktree |  |
| `` g `` | Reset | View reset options (soft/mixed/hard) for resetting onto selected item. |
| `` C `` | Copy (cherry-pick) | Mark commit as copied. Then, within the local commits view, you can press `V` to paste (cherry-pick) the copied commit(s) into your checked out branch. At any time you can press `<esc>` to cancel the selection. |
| `` <ctrl+t> `` | Open external diff tool (git difftool) |  |
| `` * `` | Select commits of current branch |  |
| `` 0 `` | Focus main view |  |
| `` <enter> `` | View files |  |
| `` / `` | Search the current view by text |  |

## Confirmation panel

| Key | Action | Info |
|-----|--------|-------------|
| `` <enter> `` | Confirm |  |
| `` <esc> `` | Close/Cancel |  |
| `` <ctrl+o> `` | Copy to clipboard |  |

## Files

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy path to clipboard |  |
| `` <space> `` | Stage | Toggle staged for selected file. |
| `` <ctrl+b> `` | Filter files by status |  |
| `` y `` | Copy to clipboard |  |
| `` c `` | Commit | Commit staged changes. |
| `` w `` | Commit changes without pre-commit hook |  |
| `` A `` | Amend last commit |  |
| `` C `` | Commit changes using git editor |  |
| `` <ctrl+f> `` | Find base commit for fixup | Find the commit that your current changes are building upon, for the sake of amending/fixing up the commit. This spares you from having to look through your branch's commits one-by-one to see which commit should be amended/fixed up. See docs: <https://github.com/jesseduffield/lazygit/tree/master/docs/Fixup_Commits.md> |
| `` e `` | Edit | Open file in external editor. |
| `` o `` | Open file | Open file in default application. |
| `` i `` | Ignore or exclude file |  |
| `` r `` | Refresh files |  |
| `` s `` | Stash | Stash all changes. For other variations of stashing, use the view stash options keybinding. |
| `` S `` | View stash options | View stash options (e.g. stash all, stash staged, stash unstaged). |
| `` a `` | Stage all | Toggle staged/unstaged for all files in working tree. |
| `` <enter> `` | Focus file diff / Collapse directory | If the selected item is a file, focus its diff so you can act on individual hunks or lines. If it is a directory, collapse or expand it. |
| `` d `` | Discard | View options for discarding changes to the selected file. |
| `` g `` | View upstream reset options |  |
| `` D `` | Reset | View reset options for working tree (e.g. nuking the working tree). |
| `` ` `` | Toggle file tree view | Toggle file view between flat and tree layout. Flat layout shows all file paths in a single list, tree layout groups files by directory.<br><br>The default can be changed in the config file with the key 'gui.showFileTree'. |
| `` <ctrl+t> `` | Open external diff tool (git difftool) |  |
| `` M `` | View merge conflict options | View options for resolving merge conflicts. |
| `` f `` | Fetch | Fetch changes from remote. |
| `` - `` | Collapse all files | Collapse all directories in the files tree |
| `` = `` | Expand all files | Expand all directories in the file tree |
| `` 0 `` | Focus main view |  |
| `` / `` | Filter the current view by text |  |

## Input prompt

| Key | Action | Info |
|-----|--------|-------------|
| `` <enter> `` | Confirm |  |
| `` <esc> `` | Close/Cancel |  |

## Local branches

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy branch name to clipboard |  |
| `` i `` | Show git-flow options |  |
| `` <space> `` | Checkout | Checkout selected item. |
| `` n `` | New branch |  |
| `` N `` | Move commits to new branch | Create a new branch and move the unpushed commits of the current branch to it. Useful if you meant to start new work and forgot to create a new branch first.<br><br>Note that this disregards the selection, the new branch is always created either from the main branch or stacked on top of the current branch (you get to choose which). |
| `` w `` | New worktree |  |
| `` o `` | Create pull request |  |
| `` O `` | View create pull request options |  |
| `` G `` | Open pull request in browser |  |
| `` <ctrl+y> `` | Copy pull request URL to clipboard |  |
| `` c `` | Checkout by name | Checkout by name. In the input box you can enter '-' to switch to the previous branch. |
| `` - `` | Checkout previous branch |  |
| `` F `` | Force checkout | Force checkout selected branch. This will discard all local changes in your working directory before checking out the selected branch. |
| `` d `` | Delete | View delete options for local/remote branch. |
| `` r `` | Rebase | Rebase the checked-out branch onto the selected branch. |
| `` M `` | Merge | View options for merging the selected item into the current branch (regular merge, squash merge) |
| `` f `` | Fast-forward | Fast-forward selected branch from its upstream. If the branch has diverged from its upstream because the upstream branch was rewritten, and it has no commits of its own, it is reset to its upstream instead. This needs reflogs to be enabled; a bare repository doesn't keep them by default (core.logAllRefUpdates). |
| `` T `` | New tag |  |
| `` s `` | Sort order |  |
| `` g `` | Reset |  |
| `` R `` | Rename branch |  |
| `` u `` | View upstream options | View options relating to the branch's upstream e.g. setting/unsetting the upstream and resetting to the upstream. |
| `` <ctrl+t> `` | Open external diff tool (git difftool) |  |
| `` 0 `` | Focus main view |  |
| `` <enter> `` | View commits |  |
| `` / `` | Filter the current view by text |  |

## Main panel (merging)

| Key | Action | Info |
|-----|--------|-------------|
| `` <space> `` | Pick hunk |  |
| `` b `` | Pick both hunks |  |
| `` <up>, k `` | Previous hunk |  |
| `` <down>, j `` | Next hunk |  |
| `` <left>, h `` | Previous conflict |  |
| `` <right>, l `` | Next conflict |  |
| `` z `` | Undo | Undo last merge conflict resolution. |
| `` e `` | Edit file | Open file in external editor. |
| `` o `` | Open file | Open file in default application. |
| `` M `` | View merge conflict options | View options for resolving merge conflicts. |
| `` <esc> `` | Return to files panel |  |

## Main panel (normal)

| Key | Action | Info |
|-----|--------|-------------|
| `` <mouse wheel down> (fn+up) `` | Scroll down |  |
| `` <mouse wheel up> (fn+down) `` | Scroll up |  |
| `` <tab> `` | Switch diff pane | Switch to the other focused diff pane. |
| `` a `` | Toggle hunk selection | Toggle line-by-line vs. hunk selection mode. |
| `` v `` | Toggle range select |  |
| `` e `` | Edit file | Open file in external editor. |
| `` <space> `` | Stage | Toggle selection staged / unstaged. |
| `` d `` | Discard | When unstaged change is selected, discard the change using `git reset`. When staged change is selected, unstage the change. |
| `` E `` | Edit hunk | Edit selected hunk in external editor. |
| `` <ctrl+o> `` | Copy selected diff lines to clipboard |  |
| `` <left>, h `` | Go to previous hunk |  |
| `` <right>, l `` | Go to next hunk |  |
| `` N `` | Go to previous file |  |
| `` n `` | Go to next file |  |
| `` <ctrl+g> `` | Jump to file |  |
| `` G `` | Open pull request at selected line | Open the branch's pull request in your browser, at the line the selection is on, so that you can comment on it there. Only pull requests on GitHub are found. |
| `` <esc> `` | Exit back to side panel |  |
| `` c `` | Commit | Commit staged changes. |
| `` w `` | Commit changes without pre-commit hook |  |
| `` C `` | Commit changes using git editor |  |
| `` <ctrl+f> `` | Find base commit for fixup | Find the commit that your current changes are building upon, for the sake of amending/fixing up the commit. This spares you from having to look through your branch's commits one-by-one to see which commit should be amended/fixed up. See docs: <https://github.com/jesseduffield/lazygit/tree/master/docs/Fixup_Commits.md> |
| `` / `` | Search the current view by text |  |

## Menu

| Key | Action | Info |
|-----|--------|-------------|
| `` <enter> `` | Execute |  |
| `` <esc> `` | Close/Cancel |  |
| `` / `` | Filter the current view by text |  |

## Reflog

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy abbreviated commit hash to clipboard |  |
| `` <space> `` | Checkout | Checkout the selected commit as a detached HEAD. |
| `` y `` | Copy commit attribute to clipboard | Copy commit attribute to clipboard (e.g. hash, URL, diff, message, author). |
| `` o `` | Open commit in browser |  |
| `` n `` | Create new branch off of commit |  |
| `` N `` | Move commits to new branch | Create a new branch and move the unpushed commits of the current branch to it. Useful if you meant to start new work and forgot to create a new branch first.<br><br>Note that this disregards the selection, the new branch is always created either from the main branch or stacked on top of the current branch (you get to choose which). |
| `` w `` | New worktree |  |
| `` g `` | Reset | View reset options (soft/mixed/hard) for resetting onto selected item. |
| `` C `` | Copy (cherry-pick) | Mark commit as copied. Then, within the local commits view, you can press `V` to paste (cherry-pick) the copied commit(s) into your checked out branch. At any time you can press `<esc>` to cancel the selection. |
| `` <ctrl+r> `` | Reset copied (cherry-picked) commits selection |  |
| `` <ctrl+t> `` | Open external diff tool (git difftool) |  |
| `` * `` | Select commits of current branch |  |
| `` 0 `` | Focus main view |  |
| `` <enter> `` | View commits |  |
| `` / `` | Filter the current view by text |  |

## Remote branches

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy branch name to clipboard |  |
| `` <space> `` | Checkout | Checkout a new local branch based on the selected remote branch, or the remote branch as a detached head. |
| `` n `` | New branch |  |
| `` w `` | New worktree |  |
| `` M `` | Merge | View options for merging the selected item into the current branch (regular merge, squash merge) |
| `` r `` | Rebase | Rebase the checked-out branch onto the selected branch. |
| `` d `` | Delete | Delete the remote branch from the remote. |
| `` u `` | Set as upstream | Set the selected remote branch as the upstream of the checked-out branch. |
| `` s `` | Sort order |  |
| `` g `` | Reset | View reset options (soft/mixed/hard) for resetting onto selected item. |
| `` <ctrl+t> `` | Open external diff tool (git difftool) |  |
| `` 0 `` | Focus main view |  |
| `` <enter> `` | View commits |  |
| `` / `` | Filter the current view by text |  |

## Remotes

| Key | Action | Info |
|-----|--------|-------------|
| `` <enter> `` | View branches |  |
| `` n `` | New remote |  |
| `` d `` | Remove | Remove the selected remote. Any local branches tracking a remote branch from the remote will be unaffected. |
| `` e `` | Edit | Edit the selected remote's name or URL. |
| `` f `` | Fetch | Fetch updates from the remote repository. This retrieves new commits and branches without merging them into your local branches. |
| `` F `` | Add fork remote | Quickly add a fork remote by replacing the owner in the origin URL and optionally check out a branch from new remote. |
| `` / `` | Filter the current view by text |  |

## Secondary

| Key | Action | Info |
|-----|--------|-------------|
| `` <tab> `` | Switch diff pane | Switch to the other focused diff pane. |
| `` a `` | Toggle hunk selection | Toggle line-by-line vs. hunk selection mode. |
| `` v `` | Toggle range select |  |
| `` e `` | Edit file | Open file in external editor. |
| `` <space> `` | Stage | Toggle selection staged / unstaged. |
| `` d `` | Discard | When unstaged change is selected, discard the change using `git reset`. When staged change is selected, unstage the change. |
| `` E `` | Edit hunk | Edit selected hunk in external editor. |
| `` <ctrl+o> `` | Copy selected diff lines to clipboard |  |
| `` <left>, h `` | Go to previous hunk |  |
| `` <right>, l `` | Go to next hunk |  |
| `` N `` | Go to previous file |  |
| `` n `` | Go to next file |  |
| `` <ctrl+g> `` | Jump to file |  |
| `` G `` | Open pull request at selected line | Open the branch's pull request in your browser, at the line the selection is on, so that you can comment on it there. Only pull requests on GitHub are found. |
| `` <esc> `` | Exit back to side panel |  |
| `` c `` | Commit | Commit staged changes. |
| `` w `` | Commit changes without pre-commit hook |  |
| `` C `` | Commit changes using git editor |  |
| `` <ctrl+f> `` | Find base commit for fixup | Find the commit that your current changes are building upon, for the sake of amending/fixing up the commit. This spares you from having to look through your branch's commits one-by-one to see which commit should be amended/fixed up. See docs: <https://github.com/jesseduffield/lazygit/tree/master/docs/Fixup_Commits.md> |
| `` / `` | Search the current view by text |  |

## Stash

| Key | Action | Info |
|-----|--------|-------------|
| `` <space> `` | Apply | Apply the stash entry to your working directory. |
| `` g `` | Pop | Apply the stash entry to your working directory and remove the stash entry. |
| `` d `` | Drop | Remove the stash entry from the stash list. |
| `` n `` | New branch | Create a new branch from the selected stash entry. This works by git checking out the commit that the stash entry was created from, creating a new branch from that commit, then applying the stash entry to the new branch as an additional commit. |
| `` w `` | New worktree |  |
| `` r `` | Rename stash |  |
| `` 0 `` | Focus main view |  |
| `` <enter> `` | View files |  |
| `` / `` | Filter the current view by text |  |

## Status

| Key | Action | Info |
|-----|--------|-------------|
| `` e `` | Edit config file | Open file in external editor. |
| `` u `` | Check for update |  |
| `` <enter> `` | Switch to a recent repo |  |
| `` a `` | Show/cycle all branch logs |  |
| `` A `` | Show/cycle all branch logs (reverse) |  |
| `` 0 `` | Focus main view |  |

## Sub-commits

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy abbreviated commit hash to clipboard |  |
| `` <space> `` | Checkout | Checkout the selected commit as a detached HEAD. |
| `` y `` | Copy commit attribute to clipboard | Copy commit attribute to clipboard (e.g. hash, URL, diff, message, author). |
| `` o `` | Open commit in browser |  |
| `` n `` | Create new branch off of commit |  |
| `` N `` | Move commits to new branch | Create a new branch and move the unpushed commits of the current branch to it. Useful if you meant to start new work and forgot to create a new branch first.<br><br>Note that this disregards the selection, the new branch is always created either from the main branch or stacked on top of the current branch (you get to choose which). |
| `` w `` | New worktree |  |
| `` g `` | Reset | View reset options (soft/mixed/hard) for resetting onto selected item. |
| `` C `` | Copy (cherry-pick) | Mark commit as copied. Then, within the local commits view, you can press `V` to paste (cherry-pick) the copied commit(s) into your checked out branch. At any time you can press `<esc>` to cancel the selection. |
| `` <ctrl+r> `` | Reset copied (cherry-picked) commits selection |  |
| `` <ctrl+t> `` | Open external diff tool (git difftool) |  |
| `` * `` | Select commits of current branch |  |
| `` 0 `` | Focus main view |  |
| `` <enter> `` | View files |  |
| `` / `` | Search the current view by text |  |

## Submodules

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy submodule name to clipboard |  |
| `` <enter> `` | Enter | Enter submodule. After entering the submodule, you can press `<esc>` to escape back to the parent repo. |
| `` d `` | Remove | Remove the selected submodule and its corresponding directory. |
| `` u `` | Update | Update selected submodule. |
| `` n `` | New submodule |  |
| `` e `` | Update submodule URL |  |
| `` i `` | Initialize | Initialize the selected submodule to prepare for fetching. You probably want to follow this up by invoking the 'update' action to fetch the submodule. |
| `` b `` | View bulk submodule options |  |
| `` / `` | Filter the current view by text |  |

## Tags

| Key | Action | Info |
|-----|--------|-------------|
| `` <ctrl+o> `` | Copy tag to clipboard |  |
| `` <space> `` | Checkout | Checkout the selected tag as a detached HEAD. |
| `` n `` | New tag | Create new tag from current commit. You'll be prompted to enter a tag name and optional description. |
| `` w `` | New worktree |  |
| `` d `` | Delete | View delete options for local/remote tag. |
| `` P `` | Push tag | Push the selected tag to a remote. You'll be prompted to select a remote. |
| `` g `` | Reset | View reset options (soft/mixed/hard) for resetting onto selected item. |
| `` <ctrl+t> `` | Open external diff tool (git difftool) |  |
| `` 0 `` | Focus main view |  |
| `` <enter> `` | View commits |  |
| `` / `` | Filter the current view by text |  |

## Worktrees

| Key | Action | Info |
|-----|--------|-------------|
| `` n `` | New worktree |  |
| `` <space> `` | Switch | Switch to the selected worktree. |
| `` o `` | Open in editor |  |
| `` d `` | Remove | Remove the selected worktree. This will both delete the worktree's directory, as well as metadata about the worktree in the .git directory. |
| `` / `` | Filter the current view by text |  |

## Other application coverage

No personal `~/.config/lazydocker/config.yml`, `~/.config/Code/User/keybindings.json`, or Rofi `config.rasi` was present. Lazydocker is available through `ld`; its internal default help is available with `?`. Rofi custom menu bindings are preserved above; common menu keys are typing to filter, arrows to move, Enter to accept, and Escape to cancel. Browser/IDE per-profile default shortcuts and extensions are not inferred from the compositor inventory. The Zsh secrets file was intentionally not exported.

## Verification and refreshing

Desktop table: `hyprctl -j binds`. tmux tables: `tmux list-keys`; inspect any table with `tmux list-keys -T prefix` or `-T copy-mode-vi`. Neovim: `:KeymapsExport /tmp/keymaps.md` after opening the filetype/plugin context of interest; `:help index` for built-ins. Kitty: compare the installed `kitty/options/definition.py` defaults with the include chain. Plugin lockfile above records editor versions. No current shortcuts were changed by this extraction.
