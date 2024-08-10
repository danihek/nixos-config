{ pkgs, ... }:

{
  services.mako = {
    enable = true;
    layer = "overlay";
    font = "Hack";
    width = 500;
    height = 160;
    defaultTimeout = 10000;
    maxVisible = 10;
    backgroundColor = "#241b1a";
    textColor = "#baa09e";
    borderColor = "#CDfBff";
    progressColor = "over #612821";
    iconPath = "${pkgs.breeze-icons}/share/icons/breeze-dark";
    maxIconSize = 24;
  };
}
