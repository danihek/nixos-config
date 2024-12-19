{ config, pkgs, lib, ... }:

{
	programs.waybar = {
		enable = true;
		config = {
			layer = "top";
			position = "top";

			modules-left = [
				"custom/workspaces"
				"custom/arrow10"
			];

			modules-center = [
				"custom/arrow9"
				"custom/window"
				"custom/arrow92"
				];

				modules-right = [
				"custom/arrow9"
				"pulseaudio"
				"custom/arrow8"
				"network"
				"custom/arrow7"
				"memory"
				"custom/arrow6"
				"cpu"
				"custom/arrow5"
				"temperature"
				"custom/arrow4"
				"battery"
				"custom/arrow3"
				"custom/arrow2"
				"tray"
				"clock#date"
				"custom/arrow1"
				"clock#time"
			];

			custom = {
				workspaces = {
					exec = "cat /tmp/hellwm/workspace";
					format = "{}";
					format-alt = "{}";
					interval = 1;
					exec-if = "test -e /tmp/hellwm/workspaces";
				};

				window = {
					exec = "cat /tmp/hellwm/active_client";
					interval = 1;
					max-length = 50;
					format = "{}";
				};

				arrow1 = { format = ""; tooltip = false; };
				arrow2 = { format = ""; tooltip = false; };
				arrow3 = { format = ""; tooltip = false; };
				arrow4 = { format = ""; tooltip = false; };
				arrow5 = { format = ""; tooltip = false; };
				arrow6 = { format = ""; tooltip = false; };
				arrow7 = { format = ""; tooltip = false; };
				arrow8 = { format = ""; tooltip = false; };
				arrow9 = { format = ""; tooltip = false; };
				arrow92 = { format = ""; tooltip = false; };
				arrow10 = { format = ""; tooltip = false; };
			};

			battery = {
				interval = 10;
				states = {
					warning = 30;
					critical = 15;
				};
				format-time = "{H}:{M:02}";
				format = "{icon} {capacity}% ({time})";
				format-charging = " {capacity}% ({time})";
				format-charging-full = " {capacity}%";
				format-full = "{icon} {capacity}%";
				format-alt = "{icon} {power}W";
				format-icons = [ "" "" "" "" "" ];
				tooltip = false;
			};

			"clock#time" = {
				interval = 10;
				format = "{:%H:%M}";
				tooltip = false;
			};

			"clock#date" = {
				interval = 20;
				format = "{:%e %b %Y}";
				tooltip = false;
			};

			cpu = {
				interval = 5;
				tooltip = false;
				format = " {usage}%";
				format-alt = " {load}";
				states = {
					warning = 70;
					critical = 90;
				};
			};

			memory = {
				interval = 5;
				format = " {used:0.1f}G/{total:0.1f}G";
				states = {
					warning = 70;
					critical = 90;
				};
				tooltip = false;
			};

			network = {
				interval = 5;
				format-wifi = " {essid} ({signalStrength}%)";
				format-ethernet = " {ifname}";
				format-disconnected = "No connection";
				format-alt = " {ipaddr}/{cidr}";
				tooltip = false;
			};

			pulseaudio = {
				format = "{icon} {volume}%";
				format-bluetooth = "{icon} {volume}%";
				format-muted = "";
				format-icons = {
					headphone = "";
					"hands-free" = "";
					headset = "";
					phone = "";
					portable = "";
					car = "";
					default = [ "" "" ];
				};
				scroll-step = 1;
				"on-click" = "pavucontrol";
				tooltip = false;
			};

			temperature = {
				"critical-threshold" = 90;
				interval = 5;
				format = "{icon} {temperatureC}°";
				format-icons = [ "" "" "" "" "" ];
				tooltip = false;
			};

			tray = {
				"icon-size" = 18;
	  # "spacing" = 10;
  };
	  };

	  style = ''
		  @import '../../.cache/hellwal/waybar-colors.css';

		  /* Keyframes */

		  @keyframes blink-critical {
		  to {
		/*color: @color15;*/
		background-color: @color1;
		  }
		  }

		  /* Assigning colors to various variables */
		  @define-color warning      @color11;  /* bryellow */
		  @define-color critical     @color1;   /* red */
		  @define-color mode         @color0;   /* black */
		  @define-color unfocused    @color14;  /* bg2 */
		  @define-color focused      @color14;  /* braqua */
		  @define-color inactive     @color5;   /* purple */
		  @define-color sound        @color13;  /* brpurple */
		  @define-color network      @color5;   /* purple */
		  @define-color memory       @color14;  /* braqua */
		  @define-color cpu          @color2;   /* green */
		  @define-color temp         @color10;  /* brgreen */
		  @define-color layout       @color11;  /* bryellow */
		  @define-color battery      @color6;   /* aqua */
		  @define-color date         @color0;   /* black */
		  @define-color time         @color15;  /* white */

		  /* Reset all styles */
		  * {
		  border: none;
		  border-radius: 0;
		  min-height: 0;
		  margin: 0;
		  padding: 0;
		  box-shadow: none;
		  text-shadow: none;
		  icon-shadow: none;
		  }

		  /* The whole bar */
#waybar {
		  background: rgba(40, 40, 40, 0.8784313725); /* #282828e0 */
		  color: @color15;
		  font-family: JetBrains Mono, Siji;
		  font-size: 10pt;
		  /*font-weight: bold;*/
		  }

		  /* Each module */
#battery,
#clock,
#cpu,
#language,
#memory,
#network,
#pulseaudio,
#temperature,
#tray,
#backlight,
#disk,
#user,
#mpris {
		  padding-left: 8pt;
		  padding-right: 8pt;
		  }

		  /* Each critical module */
#mode,
#memory.critical,
#cpu.critical,
#temperature.critical,
#battery.critical.discharging {
		  animation-timing-function: linear;
		  animation-iteration-count: infinite;
		  animation-direction: alternate;
		  animation-name: blink-critical;
		  animation-duration: 1s;
		  }

		  /* Each warning */
#network.disconnected,
#memory.warning,
#cpu.warning,
#temperature.warning,
#battery.warning.discharging {
		  color: @color11;
		  }

#custom-workspaces {
		  background: @color14;
		  color: @color0;
		  }

		  /* Workspaces stuff */
#custom-workspaces button {
		  /*font-weight: bold;*/
		  padding-left: 2pt;
		  padding-right: 2pt;
		  color: @color15;
		  background: @color14;
		  }

		  /* Inactive (on unfocused output) */
#custom-workspaces button.visible {
		  color: @color15;
		  background: @color5;
		  }

		  /* Active (on focused output) */
#custom-workspaces button.focused {
		  color: @color0;
		  background: @color14;
		  }

		  /* Contains an urgent window */
#custom-workspaces button.urgent {
		  color: @color0;
		  background: @color11;
		  }

		  /* Style when cursor is on the button */
#custom-workspaces button:hover {
		  background: @color0;
		  color: @color15;
		  }

#custom-window {
		  background: @color13;
		  color: @color0;
		  }

#pulseaudio {
		  background: @color13;
		  color: @color0;
		  }

#network {
		  background: @color5;
		  color: @color15;
		  }

#memory {
		  background: @color14;
		  color: @color0;
		  }

#cpu {
		  background: @color2;
		  color: @color15;
		  }

#temperature {
		  background: @color10;
		  color: @color0;
		  }

#language {
		  background: @color11;
		  color: @color0;
		  }

#battery {
		  background: @color6;
		  color: @color15;
		  }

#tray {
		  background: @color0;
		  }

#clock.date {
		  background: @color0;
		  color: @color15;
		  }

#clock.time {
		  background: @color15;
		  color: @color0;
		  }

#custom-arrow1 {
		  font-size: 11pt;
		  color: @color15;
		  background: @color0;
		  }

#custom-arrow2 {
		  font-size: 11pt;
		  color: @color0;
		  background: @color11;
		  }

#custom-arrow3 {
		  font-size: 11pt;
		  color: @color11;
		  background: @color6;
		  }

#custom-arrow4 {
		  font-size: 11pt;
		  color: @color6;
		  background: @color10;
		  }

#custom-arrow5 {
		  font-size: 11pt;
		  color: @color10;
		  background: @color2;
		  }

#custom-arrow6 {
		  font-size: 11pt;
		  color: @color2;
		  background: @color14;
		  }

#custom-arrow7 {
		  font-size: 11pt;
		  color: @color14;
		  background: @color5;
		  }

#custom-arrow8 {
		  font-size: 11pt;
		  color: @color5;
		  background: @color13;
		  }

#custom-arrow9 {
		  font-size: 11pt;
		  color: @color13;
		  background: transparent;
		  }

#custom-arrow92 {
		  font-size: 11pt;
		  color: @color13;
		  background: transparent;
		  }

#custom-arrow10 {
		  font-size: 11pt;
		  color: @color14;
		  background: transparent;
		  }'';
	  };
  }
