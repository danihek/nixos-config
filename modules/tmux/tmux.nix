{ pkgs, ... }:

{
  programs.tmux = {
  enable = true;
  extraConfig = ''
    ...
    set -g allow-passthrough on
    set -ga update-environment TERM
    set -ga update-environment TERM_PROGRAM
    set -g default-terminal "screen-256color-bce"
  '';
  };
}
