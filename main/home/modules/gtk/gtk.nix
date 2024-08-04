{ lib, pkgs, ... }: 

{
  gtk = {
    enable = true;
    font = {
      name = "Hack";
      size = 11;
    };
    iconTheme = {
      name = "Sweet-Red";
      package = pkgs.sweet-folders;
    };
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
  };

  home.sessionVariables.GTK_THEME = "gruvbox-dark";
}
