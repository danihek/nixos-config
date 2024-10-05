{ config, pkgs, ... }:

{

  programs.wofi = {
    enable = true;

    settings = {
      allow_images = true;
      insensitiv = true;
      no_actions = true;
      columns = 2;
      show = "drun";
    };
    style = ''
      @import url('~/.cache/wal/colors-wofi.css')
    '';
  }
}
