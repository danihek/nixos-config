{ config, pkgs, ... }:

{
  imports = [
    ./homeModulesEnabled.nix
  ];

  home.username = "ven";
  home.homeDirectory = "/home/ven";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.alacritty
    pkgs.nodejs_22
  ];

  programs.fzf = {
    enable = true;
  };

  programs.git = {
    enable = true;

    aliases = {
      pu = "push";
      ch = "checkout";
      co = "commit";
    };
  }; 

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvBoxPlus";
  };

  xdg.mimeApps.defaultApplications = {
    "image/*" = [ "sxiv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
  };

  programs.home-manager.enable = true;
}
