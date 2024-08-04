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
    pkgs.pywal
  ];

  programs.alacritty.enable = true;
  #programs.pywal.enable = true;
  programs.fzf.enable = true;

  programs.git = {
    enable = true;
    userName = "danihek";
    userEmail = "danihek07@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "oauth";
    };

    aliases = {
      pu = "push";
      ch = "checkout";
      co = "commit";
    };
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
