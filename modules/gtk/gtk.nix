{ pkgs, config, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Macchiato-Dark";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 24;
  };

  gtk = {
    enable = true;
    font = {
      name = "Hack";
      size = 12;
      package = pkgs.hack-font;
    };
    cursorTheme = {
      size = 24;
      name = "Catppuccin-Macchiato-Dark";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "candy-icons";
      package = pkgs.candy-icons;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
  };

 #qt = {
 #  enable = true;
 #  platformTheme = "gtk";
 #  style = {
 #      name = "adwaita-dark";
 #      package = pkgs.adwaita-qt;
 #  };
 #};

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-size = 24;
      cursor-theme = "Catppuccin-Macchiato-Dark";
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Dracula";
    };
  };

  home.sessionVariables.GTK_THEME = "Dracula";
}
