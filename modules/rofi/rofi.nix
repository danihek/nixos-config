{ pkgs, ... }:

{
  programs.rofi = {
        enable = true;
  
        extraConfig = {
          disable-history = false;
          show-icons = true;
          sidebar-mode = false;
          sort = true;
  
          drun-display-format = "{icon} {name}";
          display-drun = "   Run ";
          display-window = " 﩯 Window ";
  
          modi = concatStringsSep "," [
            "run"
            "drun"
            "filebrowser"
          ];
  
          xoffset = 0;
          yoffset = 0;
    };
  };
}
