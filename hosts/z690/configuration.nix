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

  # Bootloader.
  boot.tmp.cleanOnBoot = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "video=DP-1:2560x1440@165"
    "video=DP-2:2560x1440@165"
  ];

  systemd.tmpfiles.rules = 
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

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
    NIX_FLAKE_CURRENT_CONFIG = "mainpc";
  };

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  hardware = {
      opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
    
    extraPackages = with pkgs; [
      driversi686Linux.amdvl
      rocmPackages.clr.icd
      amdvlk
    ];
  };

  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # Bluetooth
  services.blueman.enable = false;
  hardware.bluetooth.enable = false; 
  hardware.bluetooth.powerOnBoot = false; 
}
