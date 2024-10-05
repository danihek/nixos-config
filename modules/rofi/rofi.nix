{ pkgs, config, ... }:

{
  programs.rofi = let
    inherit (config.lib.formats.rasi) mkLiteral;
  in
  {
    enable = true;
    cycle = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.foot}/bin/foot";

    font = "MesloLGS Nerd Font Mono 10";
    theme = "${config.xdg.cacheHome}/wal/colors-rofi-light.rasi";

    extraConfig = {
      #element-icon = { size = 2.5; };
      show-icons = true;
      scrollbar = false;
      dpi = 192;
    };
    plugins = with pkgs; [
      rofi-emoji
    ];
  };
}
