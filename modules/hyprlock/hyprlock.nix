{ lib, config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    sourceFirst = true;
    
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = [
        {
            path = "$HOME/.cache/current_wall.jpg";
            color = "rgba(25, 20, 20, 1.0)";

            blur_passes = "0";
            blur_size = "7";
            noise = "0.0117";
            contrast = "0.8916";
            brightness = "0.8172";
            vibrancy = "0.1696";
            vibrancy_darkness = "0.0";
        }
      ];
      
      image = [
        {
          path = "$HOME/pics/avatar.png";
          size = "150";
          rounding = "-1";
          border_size = "4";
          border_color = "$color6";
          rotate = "0";
          reload_time = "-1";

          position = "0, 150";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          text = "ヤッホー, ダニシェク";
          text_align = "center";
          color = "$foreground";
          font_size = "30";
          font_family = "Hack";

          position = "0, 50";
          halign = "center";
          valign = "center";
        }
      ];
      
      input-field = [
        {
          size = "200, 60";
          outline_thickness = "2";
          dots_size = "0.13";
          dots_spacing = "0.15";
          dots_center = "true";
          dots_rounding = "-1";
          outer_color = "$color2";
          inner_color = "$color14";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = "true";
          fade_timeout = "1000";
          placeholder_text = "";
          hide_input = "false";
          rounding = "-1";
          check_color = "rgb(204, 136, 34)";
          fail_color = "rgb(20, 18, 18)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_timeout = "1000";
          fail_transition = "300";
          capslock_color = "-1";
          numlock_color = "-1";
          bothlock_color = "-1";
          invert_numlock = "false";
          swap_font_color = "false";
    
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];
    };

    extraConfig = ''
      source = $HOME/.cache/wal/colors-hyprland.conf
      source = ~/.config/hypr/medialock.conf
    '';
  };

  home.file.".config/hypr/scripts/medialock.sh" = {
    text = builtins.readFile ./medialock.sh;
    executable = true;
  };
  home.file.".config/hypr/scripts/rsum.sh" = {
    text = builtins.readFile ./rsum.sh;
    executable = true;
  };
  home.file.".config/hypr/medialock.conf" = {
    text = ''
      # Media image
image {
    monitor =
    path = ~/.cache/hyprland/medialock.cache
    reload_time = 0 # Reload only when medialock sends signal
    reload_cmd = echo ~/.cache/hyprland/medialock.cache
    size = 64
    border_size = 2
    border_color = $border

    position = -144, 124
    halign = center
    valign = bottom
}
shape {
    monitor =
    size = 360, 72
    color = $black
    rounding = -1
    border_size = 2
    border_color = $border
    rotate = 0
    xray = false # if true, make a "hole" in the background (rectangle of specified size, no rotation)

    position = 0, 120
    halign = center
    valign = bottom
}
# Song title
label {
    monitor =
    text = cmd[update:100] ~/.config/hypr/bin/medialock "{{title}}"
    text_align = left
    color = $white
    font_size = 12
    font_family = Plus Jakarta Sans 10

    position = 0, 164
    halign = center
    valign = bottom
}
# Song artist
label {
    monitor =
    text = cmd[update:100] ~/.config/hypr/bin/medialock "{{artist}}"
    text_align = left
    color = $white
    font_size = 12
    font_family = Plus Jakarta Sans 10

    position = 0, 144
    halign = center
    valign = bottom
}

# Player status
label {
    monitor =
    text = cmd[update:100] ~/.config/hypr/bin/medialock "{{status_icon}} "
    text_align = left
    color = $white
    font_size = 22
    font_family = CaskaydiaCove Nerd Font 10

    position = 150, 142
    halign = center
    valign = bottom
}

# Song elapsed time
label {
    monitor =
    text = cmd[update:100] ~/.config/hypr/bin/medialock "{{elapsed}}"
    text_align = left
    color = $border
    font_size = 8
    font_family = CaskaydiaCove Nerd Font 10

    position = -90, 130
    halign = center
    valign = bottom
}
# Song duration
label {
    monitor =
    text = cmd[update:100] ~/.config/hypr/bin/medialock "{{duration}}"
    text_align = left
    color = $border
    font_size = 8
    font_family = CaskaydiaCove Nerd Font 10

    position = 90, 130
    halign = center
    valign = bottom
}
# Player progress bar
label {
    monitor =
    text = cmd[update:1000] ~/.config/hypr/bin/medialock "<b>&gt;{{progress_bar}}&lt;</b>"
    text_align = left
    color = $border
    font_size = 5
    font_family = CaskaydiaCove Nerd Font 10

    position = 0, 132
    halign = center
    valign = bottom
}
    '';
  };
}
