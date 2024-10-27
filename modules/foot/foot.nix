{ pkgs, lib, config, USERNAME, ...}:

{
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
     main = {
       include= "/home/${USERNAME}/.cache/wal/colors-foot.ini";
       term = "screen-256color";

       #font = "JetBrainsMono Nerd Font:size=11";
       font  = "JetBrains Mono Medium:size=11";

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
