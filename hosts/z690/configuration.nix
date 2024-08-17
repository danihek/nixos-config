# configuration.nix

{ inputs, config, pkgs, ... }:

let
  USERNAME = "dh";
in
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
      dh = import ../../home/dh-home.nix;
    };
  };

  # Bootloader.
  boot.tmp.cleanOnBoot = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    networkmanager.enable = true;
    hostName = "nix";

    interfaces.enp4s0.ipv4.addresses = [ {
      address = "192.168.1.195";
      prefixLength = 24;
    } ];
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" ];
  };

  # User settings
  users.users.dh = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "dh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.variables = {
    NIX_FLAKE_CURRENT_CONFIG = "mainpc";
  };

  # Bluetooth
  services.blueman.enable = false;
  hardware.bluetooth.enable = false; 
  hardware.bluetooth.powerOnBoot = false; 
}
