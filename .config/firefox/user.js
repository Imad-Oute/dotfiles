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
