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

          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            userchrome_toggle_extended
            adblocker_ultimate
            antitestportal
            privacy-badger
            ublock-origin
            sponsorblock
            betterviewer
            darkreader
            sidebery
            pywalfox
          ];
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
