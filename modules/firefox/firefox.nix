{ config, pkgs, USERNAME, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  shyFox = pkgs.fetchFromGitHub {
  owner = "danihek";
  repo = "ShyFox";
  rev = "master";
  hash = "sha256-3OEAuNqqUimhWA04qA19InCSsDFWoVWX5A48pF2mNEY=";
};
in
{ 
  home.file."~/.mozilla/firefox/${USERNAME}/user.js".source = "${shyFox}/user.js";
  home.file."~/.mozilla/firefox/${USERNAME}/chrome".source = "${shyFox}/chrome";

  programs = {
    firefox = {
      enable = true;
      languagePacks = [ "en-US" ];

      /* PROFILE */
      profiles.${USERNAME} = {
          id = 0;
          name = "${USERNAME}";
          isDefault = true;
          settings = {
            "browser.search.defaultenginename" = "Google";
            "browser.search.order.1" = "Google";
          };
          search = {
            default = "Google";
            order = [ "Google" "DuckDuckGo" "Searx" ];
          };
      };

      /* ---- POLICIES ---- */
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"

        /* ---- EXTENSIONS ---- */
        ExtensionSettings = {
          "*".installation_mode = "force_installed"; # blocks all addons except the ones specified below
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            #installation_mode = "force_installed";
          };
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            #installation_mode = "force_installed";
          };
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            #installation_mode = "force_installed";
          };
          "adblockultimate@adblockultimate.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4320550/adblocker_ultimate-3.8.26.xpi";
            #installation_mode = "force_installed";
          };
          "3c078156-979c-498b-8990-85f7987dd929" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4246774/sidebery-5.2.0.xpi";
            #installation_mode = "force_installed";
          };
          "userchrome-toggle-extended@n2ezr.ru" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/userchrome_toggle_extended/latest.xpi";
            #installation_mode = "force_installed";
          };
        "pywalfox@frewacom.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/pywalfox/latest.xpi";
            #installation_mode = "force_installed";
          };
        "ademking@betterviewer" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/betterviewer/latest.xpi";
            #installation_mode = "force_installed";
          };
        "3cbdf1b7-a83b-4f57-9faf-c84ed37fd77c" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3879928/antitestportal-1.2.1.xpi";
            #installation_mode = "force_installed";
          };
        "userchrome-toggle-extended@n2ezr.ru" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/userchrome_toggle_extended/latest.xpi";
            #installation_mode = "force_installed";
          };
        };

        /* ---- PREFERENCES ---- */
        Preferences = { 
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        };
      };
    };
  };
}
