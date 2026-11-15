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
