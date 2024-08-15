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
      dh = import ../../home/dh-home.nix;
    };
  };

  fonts.packages = with pkgs; [
    dina-font
    fira-code
    nerdfonts
    noto-fonts
    minecraftia
    proggyfonts
    font-awesome
    jetbrains-mono
    noto-fonts-cjk
    liberation_ttf
    noto-fonts-emoji
    fira-code-symbols
    terminus-nerdfont
    mplus-outline-fonts.githubRelease
  ];

  # Nix
  programs.nix-ld.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # List packages installed in system profile:
  environment.systemPackages = with pkgs; [
    # Shell, Terminal, Text Editor etc.
    vim 
    foot
    kitty
    neovide
    hyprlock
    obsidian
    alacritty ueberzugpp # yazi support
    vimPlugins.vim-plug 
    
    # Nix
    home-manager

    # Top's
    btop
    htop
    
    # Browsers
    links2
    firefox
    librewolf 

    # Dev
    gdb
    git
    lua
    udev
    clang
    libGL
    seatd
    libgcc
    libGLU
    pixman
    godot_4
    glxinfo
    gnumake
    libllvm
    llvm_18
    wayland
    wlroots
    libclang
    libclang
    libinput 
    libsecret
    pkg-config
    clang-tools
    xorg.libxcb
    libxkbcommon
    xorg.xcbutilwm
    wayland-scanner
    wayland-protocols
    gitAndTools.gitFull
    git-credential-oauth
    wlroots_0_18
    
    # Utility
    #mpv
    (mpv.override {scripts = [mpvScripts.mpris];})
    imv
    mako
    wofi
    mupdf
    upower
    libnotify
    pavucontrol
    brightnessctl
    #cinnamon.nemo
    xfce.thunar

    # Polkit
    lxqt.lxqt-policykit

    # Media
    #viber
    vesktop
    element-desktop

    # Tools
    lf
    jq
    lsd
    eza
    fzf
    bat
    wtf
    vimv
    tree
    tldr
    yazi
    tmux
    wget
    curl
    entr
    tlrc
    file
    zola
    unzip
    scrcpy
    ffmpeg
    pstree
    zoxide
    weylus
    ani-cli
    killall
    ripgrep
    openscad
    vscodium
    ckb-next # keyboard
    kdeconnect # watch and mobile
    obs-studio
    android-tools gradle
    markdown-oxide
    linuxPackages.usbip
    libreoffice-qt6-still

    # Flex
    cowsay
    cbonsai
    cmatrix
    fortune
    neofetch
    pipes-rs
    fastfetch

    # Rest..
    gnome-keyring
    libsForQt5.qt5ct
    gnome-themes-extra
    graphite-gtk-theme
    tokyonight-gtk-theme
    gsettings-desktop-schemas
    libsForQt5.qtstyleplugin-kvantum
  ];

  # Networking
  networking = {
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" ];

    interfaces.enp4s0.ipv4.addresses = [ {
      address = "192.168.1.195";
      prefixLength = 24;
    } ];
  };

  networking.firewall = { 
    enable = false;
    allowedTCPPorts = [ 9001 ];
    allowedUDPPorts = [ 9001 ];

    allowedTCPPortRanges = [ 
      { from = 1700; to = 1764; } # KDE Connect and Weylus
    ];  
    allowedUDPPortRanges = [ 
      { from = 1700; to = 1764; } # KDE Connect and Weylus
    ];  
  };

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

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Programs
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  # Services
  services.upower.enable = true;
  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Hardware 
  hardware.graphics.enable = true;

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  system.stateVersion = "24.05";
}
