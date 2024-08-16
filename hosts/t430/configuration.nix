# configuration.nix

{ inputs, config, pkgs, ... }:

{
  imports =
    [
      ../shared.nix
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      ven = import ../../home/ven-home.nix;
    };
  }; 

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  
  networking = {
    networkmanager.enable = true;
    hostName = "nix";
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" ];

    interfaces.wlp3s0.ipv4.addresses = [ {
      address = "192.168.1.190";
      prefixLength = 24;
    } ];
  };

  # User settings
  users.users.ven = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "ven";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.variables = {
    NIX_FLAKE_CURRENT_CONFIG = "laptop";
  };

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
}
