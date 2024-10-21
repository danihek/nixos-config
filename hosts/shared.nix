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

  # Editor
  environment.variables.EDITOR = "neovim";

  # Packages
  environment.systemPackages = with pkgs; [
    # Shell, Terminal, Text Editor etc.
    vim 
    foot
    kitty
    neovide
    hyprlock
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

    # Dev
    gdb
    git
    lua
    udev
    sfml
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
    #cinnamon.nemo
    xfce.thunar

    # Polkit
    lxqt.lxqt-policykit

    # Media
    #viber
    vesktop
    element-desktop

    # Music
    mpd
    moc
    cava
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
    gimp
    wine
    p7zip
    unzip
    kicad
    cobalt #mdbook mdbook-katex
    scrcpy
    bitwig-studio reaper ffmpeg # audio, video
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
    kdeconnect # watch and mobile
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
    gnome-keyring
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
  ];

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
  
  # Services
  services.gvfs.enable = true;
  services.upower.enable = true;
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.avahi = { enable = true; nssmdns4 = true; openFirewall = true; };
  services.printing.drivers = [ pkgs.hplip ];


  # Hardware 
  hardware.graphics.enable = true;

  system.stateVersion = "24.05";
}
