{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wofi
    swww
    waybar
    hyprlock
    wl-clipboard
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  programs.waybar.enable = true;
  programs.hyprlock.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
