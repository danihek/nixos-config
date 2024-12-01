{ config, lib, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    dina-font
    fira-code
    noto-fonts
    minecraftia
    proggyfonts
    font-awesome
    jetbrains-mono
    liberation_ttf
    noto-fonts-emoji
    fira-code-symbols
    noto-fonts-cjk-sans
    mplus-outline-fonts.githubRelease
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    # Shell, Terminal, Text Editor etc.
    vim 
    foot
    kitty
    neovide
    obsidian
    alacritty #ueberzugpp # yazi support
    vimPlugins.vim-plug 
 
    # Nix
    home-manager

    # Top's
    htop
    btop
    powertop
    
    # Browsers
    brave
    links2 lynx
    firefox
    qutebrowser
    librewolf 

    # Mail
    thunderbird

    # Doc
    pkgs.man-pages
    pkgs.man-pages-posix

    # Dev
    gdb
    git
    lua lua51Packages.lua
    gcc
    udev
    sfml
    hplip 
    csfml
    cmake
    clang clang-tools
    libGL
    seatd
    cargo
    rustup
    libgcc
    libGLU
    pixman
    python3
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
    mupdf zathura 
    yt-dlp
    upower
    libnotify
    pavucontrol
    brightnessctl
    xfce.thunar xfce.thunar-archive-plugin 

    # Polkit
    lxqt.lxqt-policykit

    # Media
    #viber
    vesktop
    element-desktop

    # Music
    mpd
    moc
    cmus
    spotify spicetify-cli
    ncmpcpp
    rhythmbox

    # Tools
    lf
    jq
    lsd
    eza
    fzf
    bat
    wtf
    rar
    tor
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
    gimp pinta
    wine
    p7zip
    unzip
    kicad
    cobalt #mdbook mdbook-katex
    scrcpy
    reaper ffmpeg # audio, video
    pstree
    zoxide
    weylus
    busybox
    arduino
    ani-cli manga-tui
    killall
    ripgrep
    openscad
    librecad
    vscodium
    kdenlive
    obs-studio
    imagemagick
    android-tools #gradle sdkmanager flutter
    markdown-oxide
    linuxPackages.usbip
    libreoffice-qt6-still

    # Fun
    osu-lazer-bin

    # Flex
    cowsay
    cbonsai
    cmatrix
    fortune
    pipes-rs

    # Rest..
    xdg-utils
    nerd-fonts
    gnome-keyring
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
  ];

  # Env Variables 
  environment.variables = {
    EDITOR = "nvim";
  };

  # Nix
  programs.nix-ld.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

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

  # Doc
  documentation.dev.enable = true;

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
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  hardware.graphics.enable = true;
  
  # Services
  services.gvfs.enable = true;
  services.upower.enable = true;
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.avahi = { enable = true; nssmdns4 = true; openFirewall = true; };
  services.printing.drivers = [ pkgs.hplip ];

  system.stateVersion = "24.05";
}
