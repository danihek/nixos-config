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
      ven = import ../../home/ven-home.nix;
    };
  };

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
  nixpkgs.config.allowUnfree = true;

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
    obsidian
    alacritty
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
    mpv
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
    unzip
    pstree
    zoxide
    killall
    ripgrep
    openscad
    obs-studio
    linuxPackages.usbip

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
    tokyonight-gtk-theme
    gsettings-desktop-schemas
    libsForQt5.qtstyleplugin-kvantum
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
  services.openssh.enable = true;
  services.upower.enable = true;

  # OpenGL
  hardware.graphics.enable = true;

  system.stateVersion = "24.05";
}
