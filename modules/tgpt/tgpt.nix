{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tgpt
  ];
}
