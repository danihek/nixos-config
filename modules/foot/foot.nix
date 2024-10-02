{ pkgs, USERNAME, ...}:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
     main = {
       include= "/home/${USERNAME}/.cache/wal/colors-foot.ini";
       term = "screen-256color";
       font = "JetBrainsMono Nerd Font:size=9";
       dpi-aware = "yes";
       pad = "10x10 cnenter";
     };

     colors = {
       alpha = ".75";
     };

     cursor = {
       style = "block";
     };

     key-bindings = {
       scrollback-up-line = "Alt+k";
       scrollback-down-line = "Alt+j";
       scrollback-up-half-page = "Alt+Shift+k";
       scrollback-down-half-page = "Alt+Shift+j";
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
