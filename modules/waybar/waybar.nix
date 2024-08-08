{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      height = 30;
      layer = "top";
      position = "top";
      modules-center = [ "hyprland/window" ];
      modules-left = [ "hyprland/workspaces" ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "clock"
      ];
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "{usage}%  ";
        tooltip = false;
      };
      memory = { format = "{}% "; };
      network = {
        interval = 1;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%)  ";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
    }];

    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

     *{
          font-family: "JetBrains Mono";
          font-size: 14px;
      }

      window#waybar {
          border: 2px;
      }

      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #temperature,
      #battery,
      #clock {
          padding: 0 10px;
          margin: 6px 3px;
          border-radius: 4px;
          border: 1px solid Black;
          font-weight: bold;
          background-color: Black;
          color: White;
          transition: opacity .3s ease-out;
          opacity: 1;
      }

      #custom-coretemp,
      #language,
      #network,
      #bluetooth,
      #cpu {
          margin-right: 0px;
          padding-right: 3px;
          border-top-right-radius: 0px;
          border-bottom-right-radius: 0px;
      }

      #temperature,
      #network,
      #pulseaudio,
      #memory {
          margin-left: 0px;
          padding-left: 3px;
          border-top-left-radius: 0px;
          border-bottom-left-radius: 0px;
      }

      #cpu {
          padding-right: 0;
      }

      #mode {
          border-color: transparent;
          background-color: transparent;
          color: Black;
      }

      #workspaces button {
          transition: background-color .3s ease-out;
      }

      #workspaces button.focused {
          color: Black;
          background-color: White;
      }

      #workspaces button.active {
        transition: background-color .3s ease-out;
        background-color: White;
        color: Black;
      }

      #battery.warning {
          border-color: #EF6C00;
          background-color: #EF6C00;
          color: white;
      }
      #battery.critical {
          border-color: #F44336;
          background-color: #F44336;
          color: white;
      }
      #battery.charging {
          background-color: #4EFF63;
          border-color: #4EFF63;
          color: white;
      }
    '';
  };
}
