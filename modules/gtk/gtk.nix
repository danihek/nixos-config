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
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Gruvbox-Dark-BL";
      package = pkgs.tokyonight-gtk-theme;
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
      platformTheme = "qt5ct";
      style = {
      package = with pkgs; [ adwaita-qt adwaita-qt6 ];
      name = "adwaita-dark";
    };
  };

  home.sessionVariables.GTK_THEME = "Gruvbox-Dark-BL";
}
