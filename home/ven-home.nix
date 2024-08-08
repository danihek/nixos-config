{ config, pkgs, ... }:

{
  imports = [
    ./available.nix
  ];

  home.username = "ven";
  home.homeDirectory = "/home/ven";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.alacritty
    pkgs.nodejs_22
    pkgs.pywal
  ];

  programs.alacritty.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

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
