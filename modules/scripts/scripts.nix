{ pkgs, ... }:
let
  wallpapers_path = "$HOME/pics/wallpapers";

  setwall = pkgs.writeShellScriptBin "setwall" ''

    if [ "$1" != "" ] ; then 
        # generate palette and templates from given image
        $HOME/c/code/helltheme --image "~/pics/wallpapers/$1"
    else
        # generate palette and templates from random image
        $HOME/c/code/helltheme --image ~/pics/wallpapers --random
    fi


    # source variables so you have accesss to $colors and $wallpaper
    source ~/.cache/hellwal/variables.sh
    
    # update discord colors
    themecord
    
    # apply wallpaper
    swww img "$wallpaper" \
      --transition-type="grow" \
      --transition-duration 2 \
      --transition-fps 165 \
      --resize="crop" \
      --invert-y
    
    # copy generated hellwal colors to pywal location, so pywalfox can understand it
    cp ~/.cache/hellwal/colors.json ~/.cache/wal/
    
    # update pywalfox
    pywalfox update
    
    # reload waybar with new colors
    wbar-reload
  '';

  wbar-reload = pkgs.writeShellScriptBin "wbar-reload" ''
    #!/usr/bin/env bash
    waybarPID=$(pgrep waybar)
    kill $waybarPID
    nohup waybar > /dev/null 2>&1 &
    echo "waybar reloaded!"
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
            keyword general:border_size 0;\
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
  hyprupdategaps = pkgs.writeShellScriptBin "hyprupdategaps" ''
    #!/usr/bin/env sh
    
    gaps_in=$(hyprctl -j getoption general:gaps_in | jq '.custom' | awk '{print $1}' | cut -c 2-)
    gaps_out=$(hyprctl -j getoption general:gaps_out | jq '.custom' | awk '{print $1}' | cut -c 2-)
    
    function inc_gaps_in () {
      hyprctl keyword general:gaps_in $((gaps_in+5))
    }
    
    function dec_gaps_in () {
      hyprctl keyword general:gaps_in $((gaps_in-5))
    }
    
    function inc_gaps_out () {
      hyprctl keyword general:gaps_out $((gaps_out+5))
    }
    
    function dec_gaps_out () {
      hyprctl keyword general:gaps_out $((gaps_out-5))
    }
    
    while [[ $# -gt 0 ]]; do
      case $1 in
        --inc_gaps_in)   inc_gaps_in;   shift ;;
        --dec_gaps_in)   dec_gaps_in;   shift ;;
        --inc_gaps_out)  inc_gaps_out;  shift ;;
        --dec_gaps_out)  dec_gaps_out;  shift ;;
        *)               printf "Error: Unknown option %s" "$1"; exit 1 ;;
      esac
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
      hyprupdategaps 
      
      # NixOS
      sysconfupdate
      sysconfrebuild
      sysconfrebuildpush
    ];
  };
}
