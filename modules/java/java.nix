{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jre17_minimal;
  };
}
