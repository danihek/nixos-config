{ pkgs, ... }:

{
  programs.weylus = {
    enable = true;
    users = [ "dh" ];
    openFirewall = true;
  };
}
