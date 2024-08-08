{ config, lib, pkgs, ... }:

{

  imports = [
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    alacritty
    slurp
    grim
    waypipe
  ];

  services.mako =
    let
    in
    {
      enable = true;
      backgroundColor = "#0A0E14";
      borderColor = "#53BDFA";
      defaultTimeout = 30 * 1000; # millis
      font = "monospace 10";
      icons = true;
      maxIconSize = 96;
      maxVisible = 3;
      sort = "-time";
      textColor = "#B3B1AD";
      width = 500;
    };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    checkConfig = false;
    extraSessionCommands = ''
      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
    '';
    config = rec {
      bars = [ ];
      modifier = "Mod1";
      menu = "${pkgs.wofi}/bin/wofi --show run";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      keybindings =
        let
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          playerctl = "${pkgs.playerctl}/bin/playerctl";
        in
        lib.mkOptionDefault {
          "${modifier}+Shift+s" = "exec slurp | grim -g -";
          "${modifier}+Pause" = "mode passthrough";

          # audio keys
          XF86AudioMute = "exec ${pactl} set-sink-mute 0 toggle";
          XF86AudioLowerVolume = "exec ${pactl} set-sink-volume 0 -5%";
          XF86AudioRaiseVolume = "exec ${pactl} set-sink-volume 0 +5%";
          XF86AudioMicMute = "exec ${pactl} set-source-mute 0 toggle";

          # media keys
          XF86AudioPlay = "exec ${playerctl} play-pause";
          XF86AudioPause = "exec ${playerctl} play-pause";
          XF86AudioNext = "exec ${playerctl} next";
          XF86AudioPrev = "exec ${playerctl} previous";
        };
      input = {
        "*" = {
          xkb_layout = "pl";
          xkb_options = "caps:escape";
          repeat_rate = "50";
          repeat_delay = "200";
        };
      };
      output = {
        "LVDS-1" = { mode = "1600x900@60.000Hz"; };
      };
      modes = {
        passthrough = {
          "Mod1+Pause" = "mode default";
        };
        resize = {
          "h" = "resize shrink width 10 px";
          "j" = "resize grow height 10 px";
          "k" = "resize shrink height 10 px";
          "l" = "resize grow width 10 px";
          "Left" = "resize shrink width 10 px";
          "Down" = "resize grow height 10 px";
          "Up" = "resize shrink height 10 px";
          "Right" = "resize grow width 10 px";
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };
    };
    extraConfig = ''
      # Styling
      default_border none

      # lock inhibitors
      for_window [app_id="firefox"] inhibit_idle fullscreen
      for_window [app_id="Firefox"] inhibit_idle fullscreen
      for_window [class="dota2"] inhibit_idle fullscreen
    '';
  };
}
