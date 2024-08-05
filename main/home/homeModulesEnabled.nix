{
  imports = [
    ./modules/gtk/gtk.nix
    ./modules/zsh/zsh.nix
    ./modules/cava/cava.nix
    #./modules/sway/sway.nix
    ./modules/pywal/pywal.nix
    ./modules/neovim/neovim.nix
    ./modules/waybar/waybar.nix
    ./modules/hyprland/hyprland.nix
    ./modules/hyprlock/hyprlock.nix
    #./modules/starship/starship.nix
    ./modules/alacritty/alacritty.nix

    ./scripts/scripts.nix
  ];
}


