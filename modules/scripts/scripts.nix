{ pkgs, ... }:
let
  wallpapers_path = "$HOME/pics/wallpapers";

  setwall = pkgs.writeShellScriptBin "setwall" ''
    #!/usr/bin/env bash

    wallpaper_path=${wallpapers_path}
    pywal="wal -i"
    wallpaper=$(echo $(ls $wallpaper_path -1 | grep ".jpg\|.png" | shuf | head -n 1))

    rm $HOME/.cache/current_wall.jpg
    cp $wallpaper_path/$wallpaper $HOME/.cache/current_wall.jpg

    $pywal $wallpaper_path/$wallpaper

    swww img $wallpaper_path/$wallpaper \
      --transition-type="grow" \
      --invert-y

    wbar-reload
    themecord
    pywalfox update
  '';

  wbar-reload = pkgs.writeShellScriptBin "wbar-reload" ''
    #!/usr/bin/env bash
    waybarPID=$(pgrep waybar)
    kill -HUP $waybarPID
    waybar
  '';

  sysconfupdate = pkgs.writeShellScriptBin "sysconfupdate" ''
    #!/usr/bin/env bash
    cd /etc/nixos/
    git pull
    sudo nixos-rebuild switch --flake /etc/nixos#"$NIX_FLAKE_CURRENT_CONFIG"
  '';

  sysconfrebuild = pkgs.writeShellScriptBin "sysconfrebuild" ''
    #!/usr/bin/env bash
    cd /etc/nixos/
    git add .
    git commit -m "nix config auto-commit"
    sudo nixos-rebuild switch --flake /etc/nixos#"$NIX_FLAKE_CURRENT_CONFIG"
  '';

  sysconfrebuildpush = pkgs.writeShellScriptBin "sysconfrebuildpush" ''
    #!/usr/bin/env bash
    cd /etc/nixos/
    git add .
    git commit -m "config update"
    sudo nixos-rebuild switch --flake /etc/nixos#"$NIX_FLAKE_CURRENT_CONFIG"

    if [ ! $? -eq "0" ]; then
      echo "Failed to rebuild..."
      exit
    else
      echo "Build successful, pushing changes to github:"
      git push origin main
    fi
  '';
  hyprviewtoggle = pkgs.writeShellScriptBin "hyprviewtoggle" ''
    #!/usr/bin/env sh
    MODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$MODE" = 0 ] ; then
        hyprctl --batch "\
            keyword animations:enabled 1;\
            keyword decoration:drop_shadow 5;\
            keyword decoration:blur:enabled 1;\
            keyword general:gaps_in 10;\
            keyword general:gaps_out 10;\
            keyword general:border_size 3;\
            keyword decoration:rounding 20"
        exit
    fi
    hyprctl reload
  '';

  # 'i' at the end stands for interactive
  setwalli = pkgs.writeShellScriptBin "setwalli " ''
    #!/bin/bash
    WALLPAPER_DIR=${wallpapers_path}
    
    while true; do
      SELECTED=$(ls "$WALLPAPER_DIR"/*.{png,jpg,jpeg,gif,webp} 2>/dev/null | xargs -n 1 basename | wofi --dmenu --prompt "Select a wallpaper:" -W 300 -H 300)
    
      if [ -n "$SELECTED" ]; then
        swww img --transition-fps 60 --transition-type grow --transition-duration 2 --invert-y --transition-pos "$(hyprctl cursorpos | grep -E '^[0-9]' || echo "0,0")" "$WALLPAPER_DIR/$SELECTED"
      else
        break
      fi
    done
  '';


in {
  home = {
    packages = [
      # Pywal & Sww
      setwall

      # Waybar
      wbar-reload

      # Hyprland
      hyprviewtoggle
      
      # NixOS
      sysconfupdate
      sysconfrebuild
      sysconfrebuildpush
    ];
  };
}
