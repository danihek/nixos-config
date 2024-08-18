{ pkgs, ... }:

let
  gruvboxPlus = import ./gruvbox-plus.nix { inherit pkgs; };
in
{
  gtk.enable = true;
  
  gtk.cursorTheme.package = pkgs.numix-cursor-theme;
  gtk.cursorTheme.name = "Numix-Cursor";
  
  gtk.theme.package = pkgs.gruvbox-dark-gtk;
  gtk.theme.name = "gruvbox-dark";
  
  gtk.iconTheme.package = pkgs.gruvbox-dark-icons-gtk;
  gtk.iconTheme.name = "gruvbox-dark";
  
  qt.enable = true;
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;
}

# dconf.settings = {
#   "org/gnome/desktop/interface" = {
#     gtk-theme = "gruvbox-dark";
#     color-scheme = "prefer-dark";
#     cursor-size = 24;
#     cursor-theme = "Numix-Cursor";
#   };
# };

# gtk = {
#   enable = true;

#   iconTheme = {
#     name = "gruvbox-dark";
#     package = pkgs.gruvbox-dark-icons-gtk;
#   };

#   theme = {
#     name = "gruvbox-dark";
#     package = pkgs.gruvbox-dark-gtk;
#   };

#   cursorTheme = {
#     name = "Numix-Cursor";
#     size = 24;
#     package = pkgs.numix-cursor-theme;
#   };

#   gtk3.extraConfig = {
#     Settings = ''
#       gtk-application-prefer-dark-theme=1
#     '';
#   };

#   gtk4.extraConfig = {
#     Settings = ''
#       gtk-application-prefer-dark-theme=1
#     '';
#   };
# };

# qt = {
#   enable = true;
#     platformTheme = "gtk3";
#     style = {
#     name = "gruvbox-dark";
#   };
# };
# home.sessionVariables.GTK_THEME = "gruvbox-dark";
#}
