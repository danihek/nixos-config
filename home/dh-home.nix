{ config, pkgs, ... }:

{
  imports = [
    ../modules/modules.nix
  ];

  home.username = "${USERNAME}";
  home.homeDirectory = "/home/${USERNAME}";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.alacritty
    pkgs.nodejs_22
    pkgs.pywal
  ];

  programs.alacritty.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.home-manager.enable = true;
}
