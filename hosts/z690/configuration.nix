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
    extraSpecialArgs = { inherit inputs; USERNAME = USERNAME; };
    users = {
      ${USERNAME} = import ../../home/dh-home.nix;
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
  
  services.minecraft-server = {
    enable = false;
    eula = true;
    declarative = true;

    dataDir = "/var/lib/minecraft-server";

    serverProperties = {
      gamemode = "survival";
      difficulty = "hard";
      online-mode = "false";
      simulation-distance = 10;
      level-seed = "4";
    };
    jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";
  };

  # Bootloader.
  boot.tmp.cleanOnBoot = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking = {
    hostName = "nix";
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" ];
    networkmanager.enable = true; 

    interfaces.enp4s0.ipv4.addresses = [ {
      address = "192.168.1.195";
      prefixLength = 24;
    } ];

    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 8080 25565 ];
      allowedUDPPorts = [ 443 80 8080 25565 ];

      allowedTCPPortRanges = [ 
        { from = 1700; to = 1764; } # KDE Connect and Weylus
      ];  
      allowedUDPPortRanges = [ 
        { from = 1700; to = 1764; } # KDE Connect and Weylus
      ];
    };
  };

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
    NIX_FLAKE_CURRENT_CONFIG = "mainpc";
  };

  environment.systemPackages = with pkgs; [
    lact
  ];
 
  hardware.graphics.enable = true;
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true; 
}
