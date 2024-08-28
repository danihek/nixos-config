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

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
  '';

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
      enable = false;
      allowedTCPPorts = [ 443 80 8080 25565 8999 ];
      allowedUDPPorts = [ 443 80 8080 25565 8999 ];

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
    ckb-next
    lact
  ];


 
  powerManagement.cpuFreqGovernor = "performance";
  hardware.graphics.enable = true;
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true; 

  hardware.ckb-next.enable = true;
  
  # Services
  services.minecraft-server = {
    enable = true;
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

  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
          type            "httpd"
          name            "My HTTP Stream"
          encoder         "vorbis"
          port            "8000"
          bind_to_address "0.0.0.0"
          quality         "5.0"
          format          "44100:16:2"
      }
    '';
  };
}
