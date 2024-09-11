{ pkgs, ... }:

{
  xdg.mimeApps.defaultApplications = {
    "image/*" = [ "sxiv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];

    "default-web-browser"           = [ "firefox.desktop" ];
    "text/html"                     = [ "firefox.desktop" ];
    "x-scheme-handler/http"         = [ "firefox.desktop" ];
    "x-scheme-handler/https"        = [ "firefox.desktop" ];
    "x-scheme-handler/about"        = [ "firefox.desktop" ];
    "x-scheme-handler/unknown"      = [ "firefox.desktop" ];
  };
}
