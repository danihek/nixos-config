{ pkgs, config, ...}:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
     main = {
       include= "~/.cache/dh/colors-foot.ini";
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
