{ pkgs, ... }:

{
  programs.java = { enable = true; package = pkgs.oraclejre8; };
}
