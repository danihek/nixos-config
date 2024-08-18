# configuration.nix

{ inputs, config, pkgs, ... }:

let
  USERNAME = "ven";
in
{
  imports =
    [
      ../shared.nix
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; USERNAME = USERNAME; };
    users = {
      ${USERNAME} = import ../../home/ven-home.nix;
    };
  }; 

  # User settings
  users.users.${USERNAME} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "${USERNAME}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking = {
    hostName = "nix";
    defaultGateway = "192.168.1.190";
    nameservers = [ "1.1.1.1" ];
    networkmanager.enable = true; 

    interfaces.wlp3s0.ipv4.addresses = [ {
      address = "192.168.1.195";
      prefixLength = 24;
    } ];

    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 8080 ];
      allowedUDPPorts = [ 443 80 8080 ];

      allowedTCPPortRanges = [ 
        { from = 1700; to = 1764; } # KDE Connect and Weylus
      ];  
      allowedUDPPortRanges = [ 
        { from = 1700; to = 1764; } # KDE Connect and Weylus
      ];
    };
  };

  environment.variables = {
    NIX_FLAKE_CURRENT_CONFIG = "laptop";
  };

  # Bluetooth
  services.blueman.enable = false;
  hardware.bluetooth.enable = false; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
}
