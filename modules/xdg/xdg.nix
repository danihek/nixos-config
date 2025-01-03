{ pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/*"                       = [ "sxiv.desktop" ];
      "video/*"                       = [ "mpv.desktop" ];
      "text/*"                        = [ "neovide.desktop" ];

      "application/pdf"               = ["firefox.desktop"];
      "text/html"                     = [ "firefox.desktop" ];
      "default-web-browser"           = [ "firefox.desktop" ];
      "x-scheme-handler/http"         = [ "firefox.desktop" ];
      "x-scheme-handler/https"        = [ "firefox.desktop" ];
      "x-scheme-handler/about"        = [ "firefox.desktop" ];
      "x-scheme-handler/unknown"      = [ "firefox.desktop" ];
      "x-scheme-handler/mailto"       = [ "thunderbird.desktop" ];

      "inode/directory"               = [ "thunar.desktop" ];
      "application/zip"               = [ "thunar.desktop" ];
      "application/rar"               = [ "thunar.desktop" ];
      "application/7z"                = [ "thunar.desktop" ];
      "application/*tar"              = [ "thunar.desktop" ];
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      #xdg-desktop-portal-hyprland
    ];
  };
  home.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
