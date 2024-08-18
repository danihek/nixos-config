{ pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-size = 24;
      cursor-theme = "Numix-Cursor";
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };

    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      size = 24;
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  qt = {
    enable = true;
      platformTheme = "gtk3";
      style = {
      name = "gruvbox-dark";
    };
  };

  home.sessionVariables.GTK_THEME = "gruvbox-dark";
}
