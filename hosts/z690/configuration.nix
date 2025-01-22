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
      inputs.spicetify-nix.nixosModules.default
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; USERNAME = USERNAME; };
    users = {
      ${USERNAME} = import ../../home/dh-home.nix;
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
  boot.tmp.cleanOnBoot = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
     #checkReversePath = "loose";
     #allowedTCPPorts = [ 443 80 4070 8080 25565 8999 57621 5353 ];
     #allowedUDPPorts = [ 443 80 4070 8080 25565 8999 57621 5353 ];

     #allowedTCPPortRanges = [ 
     #  { from = 1700; to = 1764; } # KDE Connect and Weylus
     #];  
     #allowedUDPPortRanges = [ 
     #  { from = 1700; to = 1764; } # KDE Connect and Weylus
     #];
    };
  };

  environment.variables = {
    NIX_FLAKE_CURRENT_CONFIG = "mainpc";
  };

  environment.systemPackages = with pkgs; [
    nemo dolphin
    ckb-next
    amdvlk
    rpcs3
    lact
  ];
  
  powerManagement.cpuFreqGovernor = "performance";
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
    #rocmPackages.clr.icd
  ];
 

  # Virtualization etc
  programs.virt-manager.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true; 

  # Corsair Keyboard
  hardware.ckb-next.enable = true;

  services.hardware.openrgb.enable = true; 
   
  # Services
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
    
    whitelist = {
      wlosek1_11 = "1fd54f6c-4d3a-3a2b-8789-ec46ee40ac5b";
      leoooo = "e3aa69e2-91e9-39c2-bb47-1a8a2e193afe";
      kotomiki = "b39381fc-a261-394e-9432-0f9f64e306f6";
      sigma_edgar = "1a701200-4e46-3cfb-9aa4-2f303c1aae33";
    };

    jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";
  };

  services.samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;
      settings = {
        "public" = {
            "path" = "/home/dh/dox/tata/";
            "valid user" = "dh";
            "browseable" = "yes";
            "read only" = "no";
            "guest ok" = "yes";
            "create mask" = "0660";
            "directory mask" = "0770";
        };
    };
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
