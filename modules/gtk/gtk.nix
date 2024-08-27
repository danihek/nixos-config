{ pkgs, config, ... }:

{
  gtk = {
    enable = true;

    theme = {
    	name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-size = 32;
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Nordic";
    };
  };

  home.pointerCursor = {
   # package = pkgs.oreo-cursors-plus;
   # name = "oreo_spark_red_cursors";
    package = pkgs.posy-cursors;
    name = "Posy_Cursor_Black";
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables.GTK_THEME = "Nordic";
}
