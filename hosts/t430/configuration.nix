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
    shell = pkgs.bash;
    isNormalUser = true;
    description = "${USERNAME}";
    extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" "video" ];
    packages = with pkgs; [];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
  '';

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Power management
  powerManagement.enable = false;
  services.thermald.enable = false;
  powerManagement.powertop.enable = false;

  services.tlp = {
      enable = false;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 10;
      };
  };

  networking = {
    hostName = "nix";
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" ];
    networkmanager.enable = true; 

    interfaces.wlp3s0.ipv4.addresses = [ {
      address = "192.168.1.190";
      prefixLength = 24;
    } ];

    firewall = {
      enable = false;
    };
  };

  environment.variables = {
    NIX_FLAKE_CURRENT_CONFIG = "laptop";
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false; # powers up the default Bluetooth controller on boot

    settings = ''
      [Input]
      UserspaceHID=true
    '';
  };

  hardware.bluetooth.settings = {
    General = {
        Experimental = true;
    };
  };
}
