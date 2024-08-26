{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      height = 30;
      layer = "top";
      position = "top";
      modules-center = [ "hyprland/window" ];
      modules-left = [ "hyprland/workspaces" "custom/music" ];
      modules-right = [
        "pulseaudio"
        "battery"
        "clock"
      ];
      battery = {
        format = "{icon} {capacity}% ";
        format-alt = "{icon} {time} ";
        format-charging = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = " {capacity}% ";
        states = {
          critical = 20;
          warning = 30;
        };
      }; 
      "hyprland/workspaces" = {
        format = "{icon}";
        "all-outputs" = true;
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
            "10" = "十";
            "11" = "十一";
          };
        "active-only" = false;
	     "disable-scroll" = true;
	     "warp-on-scroll" = false;
	     persistant_workspaces = {
		    "1" = "[]";
	 	    "2" = "[]";
	 	    "3" = "[]";
	 	    "4" = "[]";
	 	  };
      };
      "custom/music" = {
        format = "  {}";
        escape = true;
        interval = 5;
        tooltip = false;
        exec = "playerctl metadata --format='{{ title }}'";
        on-click = "playerctl play-pause";
        max-length = 50;
      };
      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      network = {
        interval = 1;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%)  ";
      };
      pulseaudio = {
        format = " {icon} {volume}% ";
        format-bluetooth = " {icon} {volume}% {format_source} ";
        format-bluetooth-muted = " {icon}  {format_source} ";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = "  {format_source} ";
        format-source = " {volume}% " ;
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      temperature = {
        critical-threshold = 80;
        format = " {icon}{temperatureC}°C ";
        format-icons = [ "" "" "" ];
      };
    }];

    style = ''
@import '../../.cache/wal/colors-waybar.css';

* {
	border: none;
   font-family: Jetbrains Mono;
	font-size: 13px;
	border-radius: 0;	
	padding: 0px 0px 0px 0px;
}

#window {
	color: @foreground;
}
window#waybar {
   background: @background;
}


#workspaces {
	background: @background;
}
#workspaces button {
	color: @foreground;
	background: @background;
	padding: 0px 4px 0px 4px;
}
#workspaces button:hover {
	text-shadow: inherit;
	box-shadow: inherit;
	transition: none;
   color: @color5;
}
#workspaces button.active {
	color: @background;
	background: @foreground;
}


#pulseaudio {
	border: solid 2px @foreground;
	background: @foreground;
	color: @background;
}
#clock {
	border: solid 2px @foreground;
	padding: 0px 5px 0px 0px;
	background: @foreground;
	color: @background;
}
#network {
	border: solid 2px @foreground;
	background: @foreground;
	color: @background;
}
#temperature {
	border: solid 2px @foreground;
	background: @foreground;
	color: @background;
}
#battery {
	border: solid 2px @foreground;
	background: @foreground;
	color: @background;
}
#battery.warning {
  border-color: #EF6C00;
  color: #EF6C00;
}
#battery.critical {
  border-color: #D32F2F;
  color: #D32F2F;
}
#battery.charging {
  border-color: #4CAF50;
  color: #4CAF50;
}
       '';
  };
}
