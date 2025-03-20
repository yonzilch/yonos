_: {
  programs = {
    floorp = {
      enable = true;
      languagePacks = [ "en-US" ];
      policies = {
        DisableAccounts = true;
        DisableAppUpdate = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "newtab";
        DisplayMenuBar = "default-off";
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Cryptomining = true;
          Fingerprinting = true;
          Locked = true;
          Value = true;
        };
        ExtensionSettings = {
          "*" = {
            installation_mode = "blocked"; # Blocks all addons except the ones specified below
          };
          # Privacy Badger
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # User-Agent Switcher and Manager
          "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi";
            installation_mode = "force_installed";
          };
          # Violentmonkey
          "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        Preferences = {
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "browser.formfill.enable" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.system.showSponsored" = false;
          "browser.search.suggest.enabled" = false;
          "browser.search.suggest.enabled.private" = false;
          "browser.topsites.contile.enabled" = false;
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          "browser.urlbar.suggest.searches" = false;
          "extensions.pocket.enabled" = false;
          "extensions.screenshots.disabled" = true;
        };
        SearchBar = "unified";
      };
    };
  };
}
