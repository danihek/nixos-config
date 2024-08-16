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
        "temperature"
        "battery"
        "clock"
      ];
      battery = {
        format = "{icon} {capacity}%";
        format-alt = "{icon} {time}";
        format-charging = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = " {capacity}%";
        states = {
          critical = 20;
          warning = 30;
        };
      };
      clock = {
        format = " {:%H:%M}";
        format-alt = " {:%Y-%m-%d}";
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

.modules-right {
	background: @background;
   padding-right: 2px;
   padding-left: 2px;
}

#window {
	color: @foreground;
}

window#waybar {
	background: rgba(30, 30, 45, 0.5);
   border: solid 2px @foreground;
}

#workspaces {
 	margin: 5px 5px 5px 5px;
	background: @background;
}

#workspaces button {
	padding: 0px 4px 0px 4px;
	color: @foreground;
}

#workspaces button.active {
	color: @background;
	background: @foreground;
}

#pulseaudio {
	border: solid 2px @foreground;
	color: @foreground;
}

#clock {
	border: solid 2px @foreground;
	padding: 0px 5px 0px 0px;
	color: @foreground;
}

#network {
	border: solid 2px @foreground;
	color: @foreground;
}

#temperature {
	border: solid 2px @foreground;
	color: @foreground;
}

#battery {
	border: solid 2px @foreground;
	color: @foreground;
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
