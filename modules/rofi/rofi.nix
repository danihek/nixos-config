{ pkgs, config, ... }:

{
  programs.rofi = let
    inherit (config.lib.formats.rasi) mkLiteral;
  in
  {
    enable = true;
    cycle = true;
    # Install the wayland variant of rofi
    package = pkgs.rofi-wayland;
    # Set terminal to kitty
    terminal = "${pkgs.foot}/bin/foot";

    font = "MesloLGS Nerd Font Mono 10";
    theme = "${config.xdg.cacheHome}/wal/colors-rofi-light.rasi";

    extraConfig = {
      show-icons = true;
      scrollbar = false;
      element-icon = true; # Ensure icons are enabled
      element-icon-size = "2.0ch"; # Increase the size of icons, adjust as needed
    };
    plugins = with pkgs; [
      rofi-emoji
    ];
  };
}
