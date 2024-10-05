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
    theme = "${config.xdg.cacheHome}/wal/colors-rofi-custom.rasi"; # Custom theme

    extraConfig = {
      show-icons = true;           # Enable icons
      element-icon = true;         # Ensure icons are displayed
      element-icon-size = "3.0ch"; # Increase the icon size

      scrollbar = false;           # Disable scrollbar for a minimal look

      # Grid layout with larger icons and more space between elements
      columns = 3; # 3-column grid layout
      lines = 5;   # Show 5 lines per page, you can increase this

      # Custom prompt text for personalization
      prompt = "Choose your action 💻: ";

      # Padding and spacing for better layout
      padding = "10px 20px";
      spacing = "10px";

      # Custom line height to space out elements
      line-height = "1.8";
    };

    plugins = with pkgs; [
      rofi-emoji  # Emoji support in Rofi
    ];
  };
}

