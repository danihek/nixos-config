{
  imports = [
    # Enabled
      ./gtk/gtk.nix
      ./git/git.nix
      ./zsh/zsh.nix
      ./ssh/ssh.nix
      #./omp/omp.nix i dot have time to configure it
      ./foot/foot.nix
      ./tmux/tmux.nix
      ./wofi/wofi.nix
      ./mako/mako.nix
      ./tgpt/tgpt.nix
      ./cava/cava.nix
      ./pywal/pywal.nix
      ./neovim/neovim.nix
      ./waybar/waybar.nix
      ./discord/discord.nix
      ./pywalfox/pywalfox.nix
      ./hyprland/hyprland.nix
      #./hyprlock/hyprlock.nix
      ./alacritty/alacritty.nix

    # Disabled
      #./java/java.nix
      #./sway/sway.nix
      #./starship/starship.nix

    # Scripts
      ./scripts/scripts.nix
  ];
}


