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
    src = ./.;
  };
in
{
  home.file."~/.mozilla/firefox/profiles.ini".text = ''
    [Profile0]
    Name=default
    IsRelative=1
    Path=default
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  # Ensure that the default Firefox profile directory exists
  home.file."~/.mozilla/firefox/default".directory = {
    owner = USERNAME; # Replace with your actual username
  };

  # Copy the chrome folder and user.js from the shyFox repository to the profile directory
  home.file."~/.mozilla/firefox/default/user.js".source = "${shyFox}/path/to/user.js"; # Adjust the path if necessary
  home.file."~/.mozilla/firefox/default/chrome".source = "${shyFox}/path/to/chrome"; # Adjust the path if necessary
  
  programs = {
    firefox = {
      enable = true;
      languagePacks = [ "en-US" ];

      /* PROFILES */
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "browser.search.defaultenginename" = "Searx";
            "browser.search.order.1" = "Searx";
          };
          search = {
            force = true;
            default = "Searx";
            order = [ "Searx" "Google" ];
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };
              "Searx" = {
                urls = [{ template = "https://searx.aicampground.com/?q={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@searx" ];
              };
              "Bing".metaData.hidden = true;
              "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
            };
          };
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
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
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

{ options, config, lib, pkgs, ... }:

with lib;
with lib.campground;
let
  cfg = config.campground.apps.firefox;
in
{
  options.campground.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox.";
    cac = mkBoolOpt false "Enable CAC Support";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [
    #   nssTools
    #   firefox
    # ];

    programs.firefox = {
      enable = true;
      ;
    };
    # # TODO: Add things to exploade cac certs and install them into firefox here
    # campground.services.cac.enable = mkIf cfg.cac true;
  };
}

