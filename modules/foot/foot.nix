{ pkgs, USERNAME, ...}:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
     main = {
       include= "/home/${USERNAME}/.cache/wal/colors-foot.ini";
       term = "screen-256color";
       font = "JetBrainsMono Nerd Font:size=13";
       dpi-aware = "yes";
     };

     colors = {
       alpha = ".75";
     };

     cursor = {
       style = "block";
     };

     key-bindings = {
       scrollback-up-line = "Shift+k";
       scrollback-down-line = "Shift+j";
       scrollback-up-half-page = "Control+Shift+k";
       scrollback-down-half-page = "Control+Shift+j";
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
