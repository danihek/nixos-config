
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swww
    wofi
    waybar
    hyprland
    hyprlock
    hypridle
    wl-clipboard
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
