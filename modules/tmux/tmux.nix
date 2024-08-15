{ pkgs, ... }:

{
  programs.tmux = {
  enable = true;
  extraConfig = ''
    ...
    set -g default-terminal "xterm-256color-bce"
  '';
  };
}
