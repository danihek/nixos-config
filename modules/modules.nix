{ lib, pkgs, config, inputs, ... }:

{
  imports = [
    # Enabled
      ./gtk/gtk.nix
      ./git/git.nix
      ./ssh/ssh.nix
      ./vim/vim.nix
      ./bash/bash.nix
      ./btop/btop.nix
      ./foot/foot.nix
      ./tmux/tmux.nix
      ./wofi/wofi.nix
      ./mako/mako.nix
      ./tgpt/tgpt.nix
      #./cava/cava.nix
      ./rofi/rofi.nix
      ./emacs/emacs.nix
      ./pywal/pywal.nix
      ./neovim/neovim.nix
      ./waybar/waybar.nix
      ./wallust/wallust.nix
      #./firefox/firefox.nix
      ./discord/discord.nix
      ./pywalfox/pywalfox.nix
      ./hyprland/hyprland.nix
      ./hyprlock/hyprlock.nix
      ./spicetify/spicetify.nix
      ./fastfetch/fastfetch.nix
      ./alacritty/alacritty.nix

    # Disabled
      #./java/java.nix
      #./sway/sway.nix
      #./starship/starship.nix
      #./omp/omp.nix i dot have time to configure it

    # Scripts
      ./scripts/scripts.nix
  ];
}
