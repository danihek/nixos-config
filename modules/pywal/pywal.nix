
{ pkgs, ... }:
let
  hypr-colors = ''
    $background = rgb({background.strip})
    $foreground = rgb({foreground.strip})
    $color0 = rgb({color0.strip})
    $color1 = rgb({color1.strip})
    $color2 = rgb({color2.strip})
    $color3 = rgb({color3.strip})
    $color4 = rgb({color4.strip})
    $color5 = rgb({color5.strip})
    $color6 = rgb({color6.strip})
    $color7 = rgb({color7.strip})
    $color8 = rgb({color8.strip})
    $color9 = rgb({color9.strip})
    $color10 = rgb({color10.strip})
    $color11 = rgb({color11.strip})
    $color12 = rgb({color12.strip})
    $color13 = rgb({color13.strip})
    $color14 = rgb({color14.strip})
    $color15 = rgb({color15.strip})
  '';
  waybar-colors = ''
    @define-color foreground {foreground};
    @define-color background {background};
    @define-color cursor {cursor};
    @define-color color0 {color0};
    @define-color color1 {color1};
    @define-color color2 {color2};
    @define-color color3 {color3};
    @define-color color4 {color4};
    @define-color color5 {color5};
    @define-color color6 {color6};
    @define-color color7 {color7};
    @define-color color8 {color8};
    @define-color color9 {color9};
    @define-color color10 {color10};
    @define-color color11 {color11};
    @define-color color12 {color12};
    @define-color color13 {color13};
    @define-color color14 {color14};
    @define-color color15 {color15};
  '';
  discord-colors = ''
    --accent-color: {color9};
    --border-color: {color3};
    --background-1: {color12};
    --background-2: {color13};
    --background-mentioned: {color3} !important;
    --background-mentioned-hover: {color3} !important;
    --background-modifier-hover: {color6} !important;
    --background-modifier-active: {color3} !important;
    --text-normal: {color15} !important;
    --text-positive: {color15} !important;
    --text-muted: {color15} !important;
    --text-link: {color15} !important;
    --button-background: {color5} !important;
    --button-background-hover: {color0} !important;
    --button-background-active: {color0} !important;
    --button-accent-hover: {color0} !important;
    --button-accent-active: {color5} !important;
    --button-destructive: {color5} !important;
    --button-destructive-hover: {color4} !important;
    --button-destructive-active: {color4} !important;
    --settings-icon-color: {color0} !important;
    --tab-selected: {color2} !important;
    --switch: {color1} !important;
  '';
  foot-colors = ''
    [colors]
    background={background.strip}
    foreground={foreground.strip}
    regular0={color0.strip}
    regular1={color1.strip}
    regular2={color2.strip}
    regular3={color3.strip}
    regular4={color4.strip}
    regular5={color5.strip}
    regular6={color6.strip}
    regular7={color7.strip}
    bright0={color8.strip}
    bright1={color9.strip}
    bright2={color10.strip}
    bright3={color11.strip}
    bright4={color12.strip}
    bright5={color13.strip}
    bright6={color14.strip}
    bright7={color15.strip}
  '';
in {
  home.file = {
    ".config/wal/templates/colors-hyprland.conf".text = ''
      ${hypr-colors}
    '';
    ".config/wal/templates/colors-waybar.css".text = ''
      ${waybar-colors}
    '';
    ".config/wal/templates/colors-discord.css".text = ''
      ${discord-colors}
    '';
    ".config/wal/templates/colors-foot.ini".text = ''
      ${foot-colors}
    '';
  };
}
