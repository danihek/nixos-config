# configuration.nix

{ inputs, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      ven = import ../home/ven-home.nix;
    };
  };

  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  
  fonts.packages = with pkgs; [
    dina-font
    fira-code
    nerdfonts
    noto-fonts
    minecraftia
    proggyfonts
    jetbrains-mono
    noto-fonts-cjk
    liberation_ttf
    noto-fonts-emoji
    fira-code-symbols
    mplus-outline-fonts.githubRelease
  ];

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nix";

  # TimeZone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # User settings
  users.users.ven = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "ven";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # List packages installed in system profile:
  environment.systemPackages = with pkgs; [
    # Shell, Terminal, Text Editor etc.
    vim 
    kitty
    neovide
    hyprlock
    alacritty
    vimPlugins.vim-plug 
    
    # Nix
    home-manager

    # Top's
    btop
    htop
    
    # Browsers
    firefox
    librewolf 

    # Dev
    git
    wlroots
    libclang
    clang-tools
    git-credential-oauth
    
    # Utility
    mpv
    imv
    mako
    mupdf
    upower
    libnotify
    pavucontrol
    brightnessctl
    cinnamon.nemo
    
    # Tools
    lf
    lsd
    fzf
    tree
    tldr
    tmux
    wget
    curl
    unzip
    killall

    # Flex
    cmatrix
    neofetch
    fastfetch
  ];

  # Sec
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.hyprlock = {};

  # Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Programs
  programs.zsh.enable = true;
  programs.mtr.enable = true;
  programs.dconf.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  # Services
  services.openssh.enable = true;
  services.upower.enable = true;

  # OpenGL
  hardware.opengl.enable = true;

  system.stateVersion = "24.05";
}
