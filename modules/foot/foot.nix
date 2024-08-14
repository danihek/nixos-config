{ pkgs, ...}:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
     main = {
       include= "~/.cache/wal/colors-foot.ini";
       term = "screen-256color";
       font = "JetBrainsMono Nerd Font:size=12";
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
