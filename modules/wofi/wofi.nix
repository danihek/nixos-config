{ config, lib, pkgs, vars, ... }:

let
  colors = import ../theming/colors.nix;
in
{
    home-manager.users.${vars.user} = {
      home = {
        packages = with pkgs; [
          wofi
        ];
      };
    };

      home.file = {
        ".config/wofi/config" = {
          text = ''
            width=100%
            height=27
            xoffset=0
            yoffset=-27
            location=1
            prompt=Search...
            filter_rate=100
            allow_markup=false
            no_actions=true
            halign=fill
            orientation=horizontal
            content_halign=fill
            insensitive=true
            allow_images=true
            image_size=10
            hide_scroll=true
          '';
        };
        ".config/wofi/style.css" = {
          text = ''
            window {
              /*background-color: #130f12;*/
              background-color: rgba(0, 0, 0, 0.8);
            }

            #input {
              all: unset;
              border: none;
              color: #99adbd;
              background-color: #99adbd;
              padding-left: 5px;
            }

            #outer-box {
              border: none;
              border-bottom: 1px solid #99adbd;
            }

            #text:selected {
              /*color: rgba(255, 255, 255, 0.8);*/
              color: rgba(0, 0, 0, 0.8);
            }

            #entry {
              color: #99adbd;
              padding-right: 10px;
            }

            #entry:selected {
              all: unset;
              border-radius: 0px;
              background-color: #99adbd;
              padding-right: 10px;
            }

            #img {
              padding-right: 5px;
              padding-left: 10px;
            }
          '';
        };
        ".config/wofi/power.sh" = {
          executable = true;
          text = ''
            #!/bin/sh

            entries="󰍃 Logout\n󰒲 Suspend\n Reboot\n⏻ Shutdown"

            selected=$(echo -e $entries|wofi --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

            case $selected in
              logout)
                exec hyprctl dispatch exit;;
              suspend)
                exec systemctl suspend;;
              reboot)
                exec systemctl reboot;;
              shutdown)
                exec systemctl poweroff -i;;
            esac
          '';
        };
      };
    };
  };
}
