{ pkgs, ... }:

{
  programs.rofi = {
        enable = true;
        package = cfg.package;
        plugins = [ pkgs.rofi-power-menu ];
  
        extraConfig = {
          disable-history = false;
          show-icons = true;
          sidebar-mode = false;
          sort = true;
  
          drun-display-format = "{icon} {name}";
          display-drun = "   Run ";
          display-window = " 﩯 Window ";
          display-power-menu = "  Power Menu ";
  
          modi = concatStringsSep "," [
            "run"
            "drun"
            "filebrowser"
            "power-menu"
          ];
  
          xoffset = 0;
          yoffset = 0;
    };
  };
}
