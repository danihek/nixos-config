{ pkgs, lib, config, USERNAME, ...}:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
     main = {
       include= "/home/${USERNAME}/.cache/wal/colors-foot.ini";
       term = "screen-256color";
       border-width = 0;

       #font = "JetBrainsMono Nerd Font:size=9";
       font = "JetBrainsMono Nerd Font:size=11";

       dpi-aware = "yes";
       pad = "0x0";
     };

     url = {
       protocols = "http, https, ftp, ftps, file, gemini, gopher";
     };

     colors = {
       alpha = ".75";
     };

     cursor = {
       style = "block";
     };

     key-bindings = {
#      scrollback-up-line = "Alt+K";
#      scrollback-down-line = "Alt+K";
#      scrollback-up-half-page = "Alt+Shift+K";
#      scrollback-down-half-page = "Alt+Shift+K";
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
