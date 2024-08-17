{ config, lib, pkgs, ... }:

{
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
    cmake
    clang
    clang-tools
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
    (mpv.override {scripts = [mpvScripts.mpris];}) # mpv
    imv
    mako
    wofi
    mupdf
    yt-dlp
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
    wget
    curl
    entr
    tlrc
    file
    zola
    gimp
    unzip
    cobalt #mdbook mdbook-katex
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
    imagemagick
    android-tools #gradle sdkmanager flutter
    markdown-oxide
    linuxPackages.usbip
    libreoffice-qt6-still

    # Flex
    cowsay
    cbonsai
    cmatrix
    fortune
    pipes-rs

    # Rest..
    gnome-keyring
    libsForQt5.qt5ct
    gnome-themes-extra
    tokyonight-gtk-theme
    gsettings-desktop-schemas
    libsForQt5.qtstyleplugin-kvantum
];

  # Nix
  programs.nix-ld.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

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
  services.gnome.gnome-keyring.enable = true;

  # Hardware 
  hardware.graphics.enable = true;

  system.stateVersion = "24.05";
}
