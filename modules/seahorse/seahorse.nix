{ config, pkgs, lib, ... }:

{
  options = {
    programs.seahorse = {
      enable = lib.mkEnableOption "Seahorse, a GNOME application for managing encryption keys and passwords in the GNOME Keyring";
    };
  };

  config = lib.mkIf config.programs.seahorse.enable {
    programs.ssh.askPassword = lib.mkDefault "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
    environment.systemPackages = [
      pkgs.seahorse
    ];
    services.dbus.packages = [
      pkgs.seahorse
    ];

  };
}
