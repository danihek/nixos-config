{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

  services.emacs = {
    enable = false;
    package = pkgs.emacs;
  };
}
