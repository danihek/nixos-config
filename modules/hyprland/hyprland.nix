{ lib, pkgs, config, USERNAME, ... }: 

{
  home.packages = with pkgs; [
    grim
    swww
    slurp
    swappy
    playerctl
    wl-clipboard
    brightnessctl
  ];

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  };

  home.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    
    extraConfig = ''
      source = /home/${USERNAME}/.cache/wal/colors-hyprland.conf
    '';

    settings = {
      monitor = [
       # "DP-1,2560x1440@165,0x50,1"
        "DP-2,2560x1440@165,2560x0,1,transform,1"
        "LVDS-1,1920x1080@60,0x0,0" # my T430 with fhd ips B)
      ];

      "$terminal" = ''footclient -o "include=/home/${USERNAME}/.cache/wal/colors-foot.ini"'';
      "$menu" = "wofi --show drun";
      "$lock" = "hyprlock";

      general = {
        gaps_in = 10;
        gaps_out = 20;
        border_size = 3;
        "col.active_border" = "rgb(bfc9f3)";
        "col.inactive_border" = "rgb(242430)";
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
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      decoration = lib.mkForce {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 1.0;
        drop_shadow = false;

        blur = {
          enabled = true;
          new_optimizations = "on";
          size = 4;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = false;

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
        pseudotile = false;
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
        "$mod SHIFT, ESCAPE, exec, hyprctl dispatch exit"

        "$mod, E, exec, thunar"
        "$mod, O, exec, $menu"
        "$mod, R, exec, rofmoji"
        "$mod, B, exec, firefox"
        "$mod, P, exec, pavucontrol"
        "$mod CTRL SHIFT, L, exec, $lock"

        "$mod, U, exec, setwall"
        
        "$mod, V, togglefloating"
        "$mod, J, togglesplit"
        "$mod, F, fullscreen"

        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod CTRL, h, movewindow, l"   "$mod SHIFT, h, resizeactive, 100 0"
        "$mod CTRL, l, movewindow, r"   "$mod SHIFT, l, resizeactive, -100 0"
        "$mod CTRL, k, movewindow, u"   "$mod SHIFT, k, resizeactive, 0 -100"
        "$mod CTRL, j, movewindow, d"   "$mod SHIFT, j, resizeactive, 0 100"
          
        "$mod SHIFT, D,movetoworkspace,special"
        "$mod, D, togglespecialworkspace"
          
        "$mod, 1, workspace, 1"  "$mod SHIFT, 1, movetoworkspace, 1" 
        "$mod, 2, workspace, 2"  "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod, 3, workspace, 3"  "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod, 4, workspace, 4"  "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod, 5, workspace, 5"  "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod, 6, workspace, 6"  "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod, 7, workspace, 7"  "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod, 8, workspace, 8"  "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod, 9, workspace, 9"  "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod, 0, workspace, 10" "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod, /, workspace, 11" "$mod SHIFT, /, movetoworkspace, 11"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        "$mod, minus, splitratio, -0.15"
        "$mod, equal, splitratio, +0.15"

        "$mod, F1, exec, hyprviewtoggle"
        
        ",XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"
        
        "$mod SHIFT, S, exec, grim -g \"$(slurp -d)\" - | tee >(swappy -f - -o - | wl-copy) | wl-copy"

        "$mod ALT, DOWN, exec, hyprctl keyword monitor LVDS-1,1920x1080@60,0x0,1,transform,0"
        "$mod ALT, UP, exec, hyprctl keyword monitor LVDS-1,1920x1080@60,0x0,1,transform,2"
        "$mod ALT, LEFT, exec, hyprctl keyword monitor LVDS-1,1920x1080@60,0x0,1,transform,1"
        "$mod ALT, RIGHT, exec, hyprctl keyword monitor LVDS-1,1920x1080@60,0x0,1,transform,3"

      ];
 
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"

        "ALT, XF86AudioRaiseVolume, exec, brightnessctl s +1%"
        "ALT, XF86AudioLowerVolume, exec, brightnessctl s 1%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "swww init ; sleep 1; setwall"
        #"pywalfox start"
        "lxqt-policykit-agent"
        "hyprctl setcursor Posy_Cursor_Black 24"
        "ckb-next -b"
      ];

      windowrulev2 = [
        "float, title:^(Picture in Picture)$"
        "float, title:^(Volume Control)$"
        "opacity 1.0 override 1.0 override, title:^(Picture in Picture)$"
        "pin, title:^(Picture in Picture)$"
        "idleinhibit fullscreen, class:^(google-chrome)$"
        "suppressevent maximize, class:.*"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
      ];
      
      misc = {
        disable_hyprland_logo = true;
      };
    };
  };
}
