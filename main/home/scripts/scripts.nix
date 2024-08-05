{ pkgs, ... }:
let
  setwall = pkgs.writeShellScriptBin "setwall" ''
    #!/bin/sh

    wallpaper_path=$HOME/pics/wallpapers
    pywal="wal -i"
    wallpaper=$(echo $(ls $wallpaper_path -1 | grep ".jpg\|.png" | shuf | head -n 1))

    rm $HOME/.cache/current_wall.jpg
    cp $wallpaper_path/$wallpaper $HOME/.cache/current_wall.jpg

    #ln -sf $wallpaper_path/$wallpaper $HOME/.cache/current_wall.jpg
    
    $pywal $wallpaper_path/$wallpaper

    #rm /home/ven/.config/vesktop/themes/colors-discord.css
    cp $HOME/.cache/wal/colors-discord.css $HOME/.config/vesktop/themes/

    swww img $wallpaper_path/$wallpaper \
      --transition-bezier .56,1.12,1,.6 \
      --transition-fps=165 \
      --transition-type="any" \
      --transition-duration=0.3
  '';
in {
  home = {
    packages = [
      setwall
    ];
  };
}
