# 10 · Firefox & Tridactyl

A vim-style, themed browser. Three pieces: **Firefox Dev Edition** preferences and
chrome CSS, **Tridactyl** for keyboard-driven browsing, and a custom **start page**.

## Why Firefox Dev Edition

The installer targets the `*.dev-edition-default` profile specifically. Dev Edition
keeps a separate profile from regular Firefox, so this customization doesn't
interfere with a vanilla browser if you have one. `install.sh` finds the profile
and links three files into it.

## The three Firefox files

```
.config/firefox/
├── user.js                 # preferences applied on every start
├── chrome/
│   ├── userChrome.css      # restyle the browser UI (toolbar, tabs, urlbar)
│   └── userContent.css     # restyle built-in pages (about:, new tab)
├── tst.css                 # Tree Style Tab sidebar styling (pasted into TST prefs)
└── startpage/              # custom new-tab page
    ├── index.html
    └── colors.css
```

### user.js — preferences

Applied on every launch. The important enablers:

```js
// Turn ON userChrome.css / userContent.css (off by default in modern Firefox)
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.uidensity", 1);              // compact toolbar
user_pref("svg.context-properties.content.enabled", true);  // recolorable icons
user_pref("layout.css.has-selector.enabled", true);         // :has() in chrome CSS
user_pref("browser.tabs.firefox-view", false);  // hide Firefox View (using TST)
user_pref("browser.aboutConfig.showWarning", false);
```

⚠️ Without `toolkit.legacyUserProfileCustomizations.stylesheets = true`, the
`userChrome.css` styling does nothing. That pref is the master switch.

### userChrome.css / userContent.css

`userChrome.css` restyles the browser frame itself (toolbar, tab bar, URL bar);
`userContent.css` restyles Firefox's internal pages. Colors here are **wallbash-
templated** via `.config/hyde/wallbash/always/firefox.dcol` — so the browser chrome
tracks your wallpaper like everything else (see
[02-theming-pipeline.md](02-theming-pipeline.md)).

### Tree Style Tab (tst.css)

Vertical tabs in a sidebar via the Tree Style Tab extension. `tst.css` is **not**
auto-applied — you paste it into TST's "user stylesheet" preference once after
installing the extension. The installer reminds you of this in its post-install
notes.

## Tridactyl — vim for the browser

Tridactyl is a Firefox extension giving Vim-style keyboard control. Config:
`.config/tridactyl/tridactylrc` (symlinked). A full bind reference lives alongside
it in **`tridactyl/BINDS.md`** — that file is the canonical cheat-sheet; this guide
just covers the philosophy and setup.

### Key settings

```vim
set smoothscroll true
set allowautofocus false      # pages can't steal focus into inputs — you stay in normal mode
set newtab file:///home/sog/dotfiles/.config/firefox/startpage/index.html
set hintchars asdfghjklqwertyuiopzxcvbnm   # home-row first for link hints
```

`allowautofocus false` is the quality-of-life setting: pages can't yank you into a
search box on load, so `j`/`k` scrolling always works immediately.

### The bind vocabulary (summary — full list in BINDS.md)

| Key | Action |
|---|---|
| `j` / `k` | Scroll down / up |
| `d` / `u` | Half page down / up |
| `gg` / `G` | Top / bottom |
| `H` / `L` | Back / forward (history) |
| `r` / `R` | Reload / hard reload |
| `J` / `K` | Next / previous tab |
| `x` | Close tab |
| `f` / `F` | Follow link hint (current / new tab) |

⚠️ Note `J`/`K` are **tabs** in Tridactyl but **move-line** in tmux/nvim. Different
app, no conflict — but worth remembering when your fingers switch contexts.

### Setup on a fresh machine

1. Install the Tridactyl extension from addons.mozilla.org.
2. Install the native messenger: `:installnative` inside Tridactyl (enables
   sourcing `tridactylrc` and some advanced commands).
3. `:source` (or restart) to load the rc.

## The start page

`startpage/index.html` + `colors.css` is a custom local new-tab page (set via both
`user.js` and Tridactyl's `newtab`). It's a static file in the repo, so it's
versioned and themeable via its `colors.css`.

🔗 Tridactyl: https://github.com/tridactyl/tridactyl
🔗 Firefox userChrome customization: https://www.userchrome.org/
