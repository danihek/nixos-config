{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      spacing = 0;
      height = 0;
      margin-top = 8;
      margin-right = 8;
      margin-bottom = 0;
      margin-left = 8;

      modules-left = [
        "custom/launcher"
        "hyprland/workspaces"
      ];

      modules-center = [ "clock" ];

      modules-right = [
        "cpu_text"
        "cpu"
        "memory"
        "battery"
        "network"
        "pulseaudio"
      ];

      "custom/launcher" = {
        format = " ";
        on-click = "rofi -show drun";
        on-click-right = "killall rofi";
        tooltip = false;
      };

      #"hyprland/workspaces" = {
      #  disable-scroll = true;
      #  all-outputs = true;
      #  tooltip = false;
      #};

      "hyprland/workspaces" = {
        format = "{icon}";
        active-only = true;
        all-outputs = false;
        format-icons = {
          "1" = "一";
          "2" = "二";
          "3" = "三";
          "4" = "四";
          "5" = "五";
          "6" = "六";
          "7" = "七";
          "8" = "八";
          "9" = "九";
          "10"= "十";
        };
      };

      tray = {
        spacing = 10;
      };

      clock = {
        format = "{:%H:%M - %a, %d %b %Y}";
        tooltip = false;
      };

      cpu = {
        format = "cpu {usage}%";
        interval = 2;
        states = { critical = 95; };
      };

      memory = {
        format = "mem {percentage}%";
        interval = 2;
        states = { critical = 98; };
      };

      battery = {
        format = "bat {capacity}%";
        interval = 5;
        states = {
          warning = 20;
          critical = 10;
        };
        tooltip = false;
      };

      network = {
        format-wifi = "wifi {bandwidthDownBits}";
        format-ethernet = "enth {bandwidthDownBits}";
        format-disconnected = "no network";
        interval = 5;
        tooltip = false;
      };

      pulseaudio = {
        scroll-step = 5;
        max-volume = 150;
        format = "vol {volume}%";
        format-bluetooth = "vol {volume}%";
        nospacing = 1;
        on-click = "pavucontrol";
        tooltip = false;
      };

      "custom/music" = {
        format = " 𝄞 {}";
        escape = true;
        interval = 1;
        tooltip = false;
        exec = "playerctl metadata --format='{{ title }}'";
        on-click = "playerctl play-pause";
        max-length = 50;
      };

      reload_on_style_change = true;
    }];

    style = ''
@import '../../.cache/wal/colors-waybar.css';

* {
    border: none;
    min-height: 0;
    font-family: "JetBrains Nerd Font Mono";
    font-weight: 500;
    font-size: 14px;
    padding: 0;
}

window#waybar {
    background: @background;
    border: 2px solid @foreground;
    border-radius: 4px;
}

tooltip {
    background-color: @background;
    border: 2px solid @color14;
    font-size: 2px;
}

tooltip label {
	margin: 8px;
}

#clock,
#tray,
#cpu,
#memory,
#battery,
#network,
#pulseaudio,
#language {
    margin: 6px 6px 6px 0px;
    padding: 2px 8px;
	border-radius: 4px;
}

#workspaces {
    margin: 6px 0px 6px 6px;
    border-radius: 4px;
}

#workspaces button {
    all: initial;
    min-width: 0;
    box-shadow: inset 0 -3px transparent;
    padding: 2px 4px;
    color: @color14;
    background-color: @background;
    border: 2px solid @color14;
    border-radius: 4px;
    margin-right: 2px;
}

#workspaces button.active {
    color: #000000;
    background-color: @color14;
}

#workspaces button.urgent {
    background-color: #a095f3;
    color: #000000;
	border: 2px solid #a095f3;
}

#clock {
    background-color: @color14;
    border: 2px solid @background;
    color: #000000;
}

#cpu,
#memory,
#network,
#pulseaudio,
#battery,
#tray,
#language {
    background-color: @background;
    border: 2px solid @color14;
    color: @color14;
}

#network {
	min-width: 100px;
}

#cpu,
#memory,
#battery,
#pulseaudio {
	min-width: 60px;
}

#cpu.critical,
#memory.critical {
    color: #a095f3;
    border: 2px solid #a095f3;
}

#battery.warning,
#battery.critical,
#battery.urgent {
    color: #a095f3;
    border: 2px solid #a095f3;
}

#custom-launcher {
	font-size: 20px;
	padding-left: 10px;
	padding-right: 5px;
	transition: none;
	color: @color14;
}

#custom-control {
	font-size: 20px;
	padding-left: 5px;
	padding-right: 5px;
	transition: none;
	color: @color14;
}

#language {
	min-width: 20px;
}
       '';
  };
}
