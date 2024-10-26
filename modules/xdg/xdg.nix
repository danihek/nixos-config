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

      "inode/directory"               = [ "thunar" ];
      "application/zip"               = [ "thunar" ];
      "application/rar"               = [ "thunar" ];
      "application/7z"                = [ "thunar" ];
      "application/*tar"              = [ "thunar" ];
    };
  };
}
