{ pkgs, ... }:

{
  #programs.emacs = {
  #  enable = true;
  #  extraPackages = (
  #    epkgs:
  #    [
  #      epkgs.melpaPackages.use-package

  #      epkgs.melpaPackages.cargo
  #      epkgs.melpaPackages.flycheck
  #      epkgs.melpaPackages.flymake-cursor
  #      epkgs.melpaPackages.magit
  #      epkgs.melpaPackages.smex
  #      epkgs.melpaPackages.rainbow-delimiters

  #  epkgs.melpaPackages.gruber-darker-theme

  #      epkgs.melpaPackages.markdown-mode
  #      epkgs.melpaPackages.rust-mode
  #      epkgs.melpaPackages.toml-mode
  #      epkgs.melpaPackages.web-mode
  #      epkgs.melpaPackages.yaml-mode
  #     ]
  #    );
  #};

  #home.file.".emacs.d/init.el".text = ''
  #  (use-package gruber-darker-theme
  #    :ensure t)
  #  (load-theme 'gruber-darker t)
  #  
  #  (scroll-bar-mode -1)
  #  (menu-bar-mode -1)
  #  (tool-bar-mode -1)
  #  (global-display-line-numbers-mode)

  #  ;; No fucking ringbell sound
  #  (setq visible-bell t)
  #  (setq ring-bell-function 'ignore)

  #  (ido-mode 1)
  #  (ido-everywhere 1)
  #  
  #  (custom-set-variables
  #   '(display-line-numbers-type (quote relative)))
  #  '';
}
