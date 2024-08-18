{ pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    
    settings = {
      stylesheet="style.css";
      show="drun";
      matching="fuzzy";
      no_actions="true";
      always_parse_args="true";
      show_all="true";
      print_command="true";
      insensitive="true";
      prompt="What package senpai...?";
      allow_markup="true";
      allow_images="true";
    };
    style = ''
@import '~/.cache/wal/colors-waybar.css'

#window {
  margin: 0px;

  border-radius: 7px;
  background-color: @background;
  font-family: "JetBrains Mono Regular Nerd Font Complete";
  font-size: 16px;
  background: @foregournd
}

#input {
  margin: 15px;
  border: 2px solid @flamingo;
  border-radius: 10px;
  color: @background;
  background: @foreground;
}

#input:focus {
  background: @background;
}

#input:focus image {
  color: @foregrond;
}

#input image {
	color: @background;
}

#inner-box {
  margin: 5px;
  border: none;
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 7px;
  background-color: inherit;
}

#outer-box {
  margin: 5px;
  border: none;
  background-color: inherit;
  border-radius: 7px;
}

#scroll {
  margin: 0px;
  border: none;
}

#text {
  margin: 5px;
  border: none;
  color: @foreground;
} 

#entry:selected {
  border-radius: 10px;
  background: @background;
}

#text:selected {
	background-color: inherit;
	color: @foreground;
	font-weight: normal;
}
    '';
  };
}
