{ pkgs, ... }:
let
  hypr-colors = ''
    $background = rgb(%%background.rgb%%)
    $foreground = rgb(%%foreground.rgb%%)
    $color0 = rgb(%%color0.rgb%%)
    $color1 = rgb(%%color1.rgb%%)
    $color2 = rgb(%%color2.rgb%%)
    $color3 = rgb(%%color3.rgb%%)
    $color4 = rgb(%%color4.rgb%%)
    $color5 = rgb(%%color5.rgb%%)
    $color6 = rgb(%%color6.rgb%%)
    $color7 = rgb(%%color7.rgb%%)
    $color8 = rgb(%%color8.rgb%%)
    $color9 = rgb(%%color9.rgb%%)
    $color10 = rgb(%%color10.rgb%%)
    $color11 = rgb(%%color11.rgb%%)
    $color12 = rgb(%%color12.rgb%%)
    $color13 = rgb(%%color13.rgb%%)
    $color14 = rgb(%%color14.rgb%%)
    $color15 = rgb(%%color15.rgb%%)
  '';
  waybar-colors = ''
    @define-color foreground %%foreground%%;
    @define-color background %%background%%;
    @define-color cursor %%cursor%%;
    @define-color color0 %%color0%%;
    @define-color color1 %%color1%%;
    @define-color color2 %%color2%%;
    @define-color color3 %%color3%%;
    @define-color color4 %%color4%%;
    @define-color color5 %%color5%%;
    @define-color color6 %%color6%%;
    @define-color color7 %%color7%%;
    @define-color color8 %%color8%%;
    @define-color color9 %%color9%%;
    @define-color color10 %%color10%%;
    @define-color color11 %%color11%%;
    @define-color color12 %%color12%%;
    @define-color color13 %%color13%%;
    @define-color color14 %%color14%%;
    @define-color color15 %%color15%%;
  '';
  discord-colors = ''
    --background: #%% background.hex %%;
    --foreground: #%% foreground.hex %%;
    --cursor: #%% cursor.hex %%;
    --border: #%% border.hex %%;
    
    --color0: #%% color0.hex %%;
    --color1: #%% color1.hex %%;
    --color2: #%% color2.hex %%;
    --color3: #%% color3.hex %%;
    --color4: #%% color4.hex %%;
    --color5: #%% color5.hex %%;
    --color6: #%% color6.hex %%;
    --color7: #%% color7.hex %%;
    --color8: #%% color8.hex %%;
    --color9: #%% color9.hex %%;
    --color10: #%% color10.hex %%;
    --color11: #%% color11.hex %%;
    --color12: #%% color12.hex %%;
    --color13: #%% color13.hex %%;
    --color14: #%% color14.hex %%;
    --color15: #%% color15.hex %%;
  '';
  foot-colors = ''
    [colors]
    background=%%background.rgb%%
    foreground=%%foreground.rgb%%
    regular0=%%color0.rgb%%
    regular1=%%color1.rgb%%
    regular2=%%color2.rgb%%
    regular3=%%color3.rgb%%
    regular4=%%color4.rgb%%
    regular5=%%color5.rgb%%
    regular6=%%color6.rgb%%
    regular7=%%color7.rgb%%
    bright0=%%color8.rgb%%
    bright1=%%color9.rgb%%
    bright2=%%color10.rgb%%
    bright3=%%color11.rgb%%
    bright4=%%color12.rgb%%
    bright5=%%color13.rgb%%
    bright6=%%color14.rgb%%
    bright7=%%color15.rgb%%
  '';
  wofi-colors = ''
      window {
        margin: 0px;
        border: 1px solid #%%foreground.rgb%%;
        background-color: #%%background.rgb%%;
      }

      #input {
        margin: 5px;
        border: none;
        background-color: #%%color8.rgb%%;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: #%%background.rgb%%;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: #%%background.rgb%%;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #ffffff;
      }

      #entry:selected {
        background-color: #%%color8.rgb%%;
      }
    '';
in {
  home.file = {
    #".config/wal/templates/colors-foot.ini".text = ''${foot-colors}'';
    ##".config/wal/templates/colors-wofi.css".text = ''${wofi-colors}''; #somehow broken
    #".config/wal/templates/colors-waybar.css".text = ''${waybar-colors}'';
    #".config/wal/templates/colors-hyprland.conf".text = ''${hypr-colors}'';
    #".config/wal/templates/colors-discord.css".text = ''${discord-colors}'';
  };
}
