{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    extraPackages = (
      epkgs:
      [
        epkgs.melpaPackages.use-package

        epkgs.melpaPackages.cargo
        epkgs.melpaPackages.flycheck
        epkgs.melpaPackages.flymake-cursor
        epkgs.melpaPackages.magit
        epkgs.melpaPackages.smex
        epkgs.melpaPackages.rainbow-delimiters

        epkgs.melpaPackages.markdown-mode
        epkgs.melpaPackages.rust-mode
        epkgs.melpaPackages.toml-mode
        epkgs.melpaPackages.web-mode
        epkgs.melpaPackages.yaml-mode
       ]
      );
  };

  home.file.".emacs.d/init.el".text = ''
    (scroll-bar-mode -1)
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (global-display-line-numbers-mode)
    
    (ido-mode 1)
    (ido-everywhere 1)
    
    (custom-set-variables
     '(display-line-numbers-type (quote relative)))
    '';
}
