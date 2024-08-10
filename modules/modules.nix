{
  imports = [
    # Enabled
      ./gtk/gtk.nix
      ./git/git.nix
      ./zsh/zsh.nix
      ./mako/mako.nix
      ./tgpt/tgpt.nix
      ./cava/cava.nix
      ./pywal/pywal.nix
      ./neovim/neovim.nix
      ./waybar/waybar.nix
      ./discord/discord.nix
      ./pywalfox/pywalfox.nix
      ./hyprland/hyprland.nix
      ./hyprlock/hyprlock.nix
      ./alacritty/alacritty.nix

    # Disabled
      #./sway/sway.nix
      #./starship/starship.nix

    # Scripts
      ./scripts/scripts.nix
  ];
}


