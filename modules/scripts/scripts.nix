{ pkgs, ... }:
let
  wallpapers_path = "$HOME/pics/wallpapers";

  setwall = pkgs.writeShellScriptBin "setwall" ''
    #!/usr/bin/env sh

    wallpaper_path=${wallpapers_path}
    pywal="wal -i"

    if [ "$1" != "" ]; then
      wallpaper="$1"
    else
      wallpaper=$(echo $(ls $wallpaper_path -1 | grep ".jpg\|.png" | shuf | head -n 1))
    fi

    rm $HOME/.cache/current_wall.jpg
    cp $wallpaper_path/$wallpaper $HOME/.cache/current_wall.jpg

    $pywal $wallpaper_path/$wallpaper

    swww img $wallpaper_path/$wallpaper \
      --transition-type="grow" \
      --invert-y \
      --transition-duration 2 \
      --transition-fps 165

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
    else
        hyprctl --batch " \
            keyword animations:enabled 0; \
            keyword decoration:drop_shadow 0; \
            keyword decoration:blur:enabled 1; \
            keyword general:gaps_in 10; \
            keyword general:gaps_out 10; \
            keyword general:border_size 2; \
            keyword decoration:rounding 0"
    fi
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
