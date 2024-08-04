{ lib, pkgs, config, ... }: 

{
  home.packages = with pkgs; [
    grim
    slurp
    swappy
    playerctl
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {

      monitor = [
        ",preferred,auto,auto"
      ];

      "$terminal" = "alacritty";
      "$menu" = "wofi --show drun";
      "$lock" = "hyprlock";

      general = lib.mkDefault {
        gaps_in = 4;
        gaps_out = 10;

        border_size = 2;

       "col.active_border" = "rgba(242, 215, 229, 0.8)";
       "col.inactive_border" = "rgba(167, 160, 163, 0.8)";
       #"col.active_border" = "rgba(${config.lib.stylix.colors.base0D}ff)";
       #"col.inactive_border" = "rgba(${config.lib.stylix.colors.base02}ff)";

        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"

        "NIXOS_OZONE_WL,1"
        "MOZ_ENABLE_WAYLAND,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      decoration = lib.mkForce {
        rounding = 20;

        active_opacity = 1.0;
        inactive_opacity = 0.7;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        blur = {
          enabled = true;
          new_optimizations = "on";
          size = 4;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.3, 0, 0, 1";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 5, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
      };
 
      input = {
        kb_layout = "pl";
        follow_mouse = 1;
        repeat_delay = 200;
        repeat_rate = 50;
      };

      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec,$terminal"
        "$mod, Q, killactive,"

        "$mod, E, exec, nemo"
        "$mod, O, exec, $menu"
        "$mod, L, exec, $lock"
        "$mod, R, exec, rofmoji"
        "$mod, B, exec, firefox"
        "$mod, P, exec, pavucontrol"
        
        "$mod,V, togglefloating"
        "$mod,J, togglesplit"
          
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
          
        "$mod CTRL, left, movewindow, l"
        "$mod CTRL, right, movewindow, r"
        "$mod CTRL, up, movewindow, u"
        "$mod CTRL, down, movewindow, d"
          
        "$mod, D,movetoworkspace,special"
        "$mod, D, togglespecialworkspace"
          
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        "$mod, minus, splitratio, -0.15"
        "$mod, equal, splitratio, +0.15"

        "$mod SHIFT, right, resizeactive, 100 0"
        "$mod SHIFT, left, resizeactive, -100 0"
        "$mod SHIFT, up, resizeactive, 0 -100"
        "$mod SHIFT, down, resizeactive, 0 100"
         
        ",XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"
        
        "$mod SHIFT, S, exec, grim -g \"$(slurp -d)\" - | tee >(swappy -f - -o - | wl-copy) | wl-copy"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      misc = {
        disable_hyprland_logo = true;
        animate_mouse_windowdragging = false;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
      };
    };
  };
}
