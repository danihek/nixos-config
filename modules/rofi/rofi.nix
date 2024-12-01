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
    # Set terminal to foot
    terminal = "${pkgs.foot}/bin/foot";

    # Custom font for better aesthetics
    font = "MesloLGS Nerd Font Mono 12"; # Larger font for better readability
    theme = "${config.xdg.cacheHome}/hellwal/rofi-colors.rasi";

    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus-Apps";
      terminal = "foot";
      cycle = false;
      hide-scrollbar = true;
      disable-history = false;
      opacity = "0.5";
    };

    plugins = with pkgs; [
      rofi-emoji  # Emoji support in Rofi
    ];
  };
}

