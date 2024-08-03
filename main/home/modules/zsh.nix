{ pkgs, ... }:

{
  home.packages = [
    pkgs.thefuck
    pkgs.fzf
    pkgs.fzf-zsh
    pkgs.zsh-fzf-tab
    pkgs.zsh-fzf-history-search
  ];
  
  programs.fzf = {
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = 
      [ 
          "git"
          "man"
          "mix"
          "tig"
          "nmap"
          "sudo"
          "tmux"
          "yarn"
          "docker"
          "systemd"
          "vi-mode"
          "encode64"
          "thefuck" 
          "git-extras"
          "zsh-navigation-tools"
      ];
      theme = "robbyrussell";
    };

    shellAliases = {
      g = "git";
      sl = "ls";
      tm = "tmux";
      nv = "neovide";
      cl = "clear & l";
      fucking = "sudo";
      mkcl = "make clean";
      TODO = "vim ~/.TODO.md";
      l = "lsd --group-dirs=first";
      hellwm = "~/code/c/hellwm/hellwm";
      la = "lsd -la --group-dirs=first";
      ll = "lsd -lh --group-dirs=first";
      lla = "lsd -lha --group-dirs=first";
      cpl = "make clean ; make && ./hellwm";
    };

    initExtra = ''
      autoload -Uz compinit
      compinit

      # Keys
      bindkey '5~' kill-word
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;3D" backward-word
      bindkey "^[[1;5D" backward-word
      bindkey '^H' backward-kill-word
      bindkey "^[[H" beginning-of-line
    '';
    
    envExtra = ''
      # Variables
      export IMAGE="imv"
      export VIDEO="mpv"
      export KEYTIMEOUT=1
      export TERM="alacritty"
      export BROWSER="firefox"
      export OPENER="xdg-open"
      export TERMINAL="alacritty"
      export TERM="xterm-256color"
      export LAUNCHER="wofi --show drun"
      export FZF_DEFAULT_OPTS="--color=16"
    '';
  };
}
