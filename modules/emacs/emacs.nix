{ lib, config, pkgs, ... }:

let cfg = config.modules.editors.emacs;
    emacs = with pkgs; (emacsPackagesFor
      (if config.modules.desktop.type == "wayland"
       then emacs-pgtk
       else emacs-git)).emacsWithPackages (epkgs: with epkgs; [
         treesit-grammars.with-all-grammars
         vterm
         mu4e
       ]);
in {
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
    # doom = rec {
    #   enable = mkBoolOpt false;
    #   forgeUrl = mkOpt types.str "https://github.com";
    #   repoUrl = mkOpt types.str "${forgeUrl}/doomemacs/doomemacs";
    #   configRepoUrl = mkOpt types.str "${forgeUrl}/hlissner/.doom.d";
    # };
  };

  config = cfg.enable {

    user.packages = with pkgs; [
      (mkLauncherEntry "Emacs (Debug Mode)" {
        description = "Start Emacs in debug mode";
        icon = "emacs";
        exec = "${emacs}/bin/emacs --debug-init";
      })

      ## Emacs itself
      binutils            # native-comp needs 'as', provided by this
      emacs               # HEAD + native-comp

      ## Doom dependencies
      git
      ripgrep
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      (mkIf (config.programs.gnupg.agent.enable)
        pinentry-emacs)   # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :email mu4e
      mu
      unstable.isync
      # :checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang beancount
      beancount
      fava
      # :lang nix
      age
    ];

    fonts.packages = [
      (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
  };
}

#{
#  programs.emacs = {
#    enable = true;
#    extraPackages = (
#      epkgs:
#      [
#        epkgs.melpaPackages.use-package
#
#        epkgs.melpaPackages.cargo
#        epkgs.melpaPackages.flycheck
#        epkgs.melpaPackages.flymake-cursor
#        epkgs.melpaPackages.magit
#        epkgs.melpaPackages.smex
#        epkgs.melpaPackages.rainbow-delimiters
#
#        epkgs.melpaPackages.markdown-mode
#        epkgs.melpaPackages.rust-mode
#        epkgs.melpaPackages.toml-mode
#        epkgs.melpaPackages.web-mode
#        epkgs.melpaPackages.yaml-mode
#       ]
#      );
#  };
#
#  home.file.".emacs.d/init.el".text = ''
#    (scroll-bar-mode -1)
#    (menu-bar-mode -1)
#    (tool-bar-mode -1)
#    (global-display-line-numbers-mode)
#    
#    (ido-mode 1)
#    (ido-everywhere 1)
#    
#    (custom-set-variables
#     '(display-line-numbers-type (quote relative)))
#    '';
#}
