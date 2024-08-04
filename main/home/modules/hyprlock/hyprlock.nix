{ lib, config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = [
        {
            path = "/home/ven/.cache/current_wall";
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
          path = "/home/ven/pics/avatar.png";
          size = "150";
          rounding = "-1";
          border_size = "4";
          border_color = "rgb(121, 21, 221)";
          rotate = "0";
          reload_time = "-1";

          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
      
      input-field = [
        {
          size = "200, 60";
          outline_thickness = "1";
          dots_size = "0.13";
          dots_spacing = "0.15";
          dots_center = "true";
          dots_rounding = "-1";
          outer_color = "rgb(200, 200, 200)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = "true";
          fade_timeout = "1000";
          placeholder_text = "Password sweetie <3";
          hide_input = "false";
          rounding = "-1";
          check_color = "rgb(204, 136, 34)";
          fail_color = "rgb(204, 34, 34)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_timeout = "1000";
          fail_transition = "300";
          capslock_color = "-1";
          numlock_color = "-1";
          bothlock_color = "-1";
          invert_numlock = "false";
          swap_font_color = "false";
    
          position = "0, -50";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
