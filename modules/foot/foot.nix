{ lib, pkgs, config, home-manager, ...}:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
     main = {
       include= "/home/${config.users.users.${username}}/.cache/wal/colors-foot.ini";
       term = "xterm-256color";
       font = "JetBrainsMono Nerd Font:size=13";
       dpi-aware = "yes";
     };

     colors = {
       alpha = ".75";
     };

     cursor = {
       style = "block";
     };

     mouse = {
       hide-when-typing = "yes";
     };

     tweak = {
       sixel = "yes";
     };
    };   
  };
}
