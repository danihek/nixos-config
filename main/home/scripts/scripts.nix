{ pkgs, ... }:
let
  setwall = pkgs.writeShellScriptBin "setwall" ''
    #!/bin/sh

    wallpaper_path=$HOME/pics/wallpapers
    pywal="wal -i"
    wallpaper=$(echo $(ls $wallpaper_path -1 | grep ".jpg\|.png" | shuf | head -n 1))

    $HOME/.cache/current_wall
    ln -sfr $wallpaper_path/$wallpaper $HOME/.cache/current_wall
    
    $pywal $wallpaper_path/$wallpaper
    swww img $wallpaper_path/$wallpaper \
      --transition-bezier .56,1.12,1,.6 \
      --transition-fps=165 \
      --transition-type="any" \
      --transition-duration=0.3
  '';
in {
  home = {
    packages = [
      wallset
    ];
  };
}
