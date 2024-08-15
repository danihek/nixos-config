{ pkgs, ... }:

{
  home.packages = [
    pkgs.thefuck
    pkgs.fzf-zsh
    pkgs.zsh-fzf-tab
    pkgs.zsh-fzf-history-search
  ];
  
  programs.fzf.enableZshIntegration = true;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = 
      [ 
          "git"
          "tmux"
          "vi-mode"
          "thefuck" 
          "git-extras"
          "zsh-navigation-tools"
      ];
      theme = "kphoen";
    };

    shellAliases = {
      g = "git";
      sl = "ls";
      lf = "yazi"; #xd
      ls = "eza";
      tm = "tmux";
      l = "eza -l";
      ll = "eza -lh";
      nv = "neovide";
      la = "eza -alh";
      cl = "clear & l";
      fucking = "sudo";
      lla = "eza -alh";
      tree = "eza --tree";
      mkcl = "make clean";
      TODO = "vim ~/.TODO.md";
      cpl = "make clean ; clear; make";
    };

    initExtra = ''
      # Keys
      bindkey '5~' kill-word
      bindkey '^K' kill-line
      bindkey "^[[3~" delete-char
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;3D" backward-word
      bindkey "^[[1;5D" backward-word
      bindkey '^H' backward-kill-word

      bindkey "^[[H" end-of-line
      bindkey "^[[F" beginning-of-line
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
      #export TERM="screen-256color"
      export LAUNCHER="wofi --show drun"
      export FZF_DEFAULT_OPTS="--color=16"
      export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
    '';
  };
}
