// user.js — Firefox Dev Edition preferences
// Applied on every Firefox start. Safe to regenerate.

// Enable userChrome.css / userContent.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Compact density (smaller toolbar, more screen for content)
user_pref("browser.uidensity", 1);

// Enable SVG context properties (allows icon recoloring in userChrome)
user_pref("svg.context-properties.content.enabled", true);

// Enable :has() CSS selector support
user_pref("layout.css.has-selector.enabled", true);

// Hide the "Firefox View" tab button (not needed with TST)
user_pref("browser.tabs.firefox-view", false);

// Disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

// Smooth scrolling
user_pref("general.smoothScroll", true);
user_pref("general.smoothScroll.msdPhysics.enabled", true);

// Allow file:// pages to load sibling file:// stylesheets (needed for startpage → colors.css)
user_pref("privacy.file_unique_origin", false);

// ── Focus hardening ────────────────────────────────────────────────────────

// Kill Pocket
user_pref("extensions.pocket.enabled", false);

// No "save to Pocket" / "send tab to device" clutter in context menus
user_pref("browser.tabs.extraContextMenuItems", false);

// Disable push notifications entirely
user_pref("dom.push.enabled", false);
user_pref("dom.push.connection.enabled", false);

// Block notification permission prompts — sites can't even ask
user_pref("permissions.default.desktop-notification", 2);

// Disable autoplay (video/audio won't start without interaction)
user_pref("media.autoplay.default", 5);
user_pref("media.autoplay.blocking_policy", 2);

// No "Firefox suggest" / sponsored content in URL bar
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.sponsoredTopSites", false);

// No new tab sponsored tiles / Pocket recommendations
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);

// Disable Firefox studies / experiments
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);

// No crash reporter / telemetry
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);

// No "What's new" / update nag popups
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");

// Trim URL bar — hide scheme + trailing slash for cleaner look
user_pref("browser.urlbar.trimURLs", true);
user_pref("browser.urlbar.trimHttps", true);

// Prevent Alt key from focusing the menu bar (breaks Alt+* keybinds)
user_pref("ui.key.menuAccessKeyFocuses", false);
user_pref("ui.key.menuAccessKey", 0);
