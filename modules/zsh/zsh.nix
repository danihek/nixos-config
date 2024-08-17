{ pkgs, ... }:

{
 #home.packages = [
 #  pkgs.fzf-zsh
 #  pkgs.zsh-fzf-tab
 #  pkgs.zsh-fzf-history-search
 #];
 #programs.fzf.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      g = "git";
      sl = "ls";
      lf = "yazi"; #xd
      ls = "eza";
      tm = "tmux";
      l = "ls -l";
      ll = "ls -lh";
      la = "ls -alh";
      cl = "clear & l";
      fucking = "sudo";
      lla = "ls -alh";
      tree = "tree";
      mkcl = "make clean";
      neofetch = "fastfetch";
      TODO = "nvim ~/.TODO.md";
      cpl = "make clean ; clear; make";
    };

    initExtra = ''
      autoload -U colors && colors

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
      bindkey '^[begin' beginning-of-line
      bindkey '^[end' end-of-line
      bindkey '^A' beginning-of-line
      bindkey '^E' end-of-line

      PROMPT="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}] "
      set_rprompt()
      {
        RPROMPT="[%{$fg[green]%}($(git rev-parse --abbrev-ref HEAD 2>/dev/null))%{$fg[white]%}:%{$fg[red]%}$(git status --porcelain 2>/dev/null | wc 
-l)%}%{$fg[white]%}] "
      }
      precmd() { set_rprompt }
    '';
    
    envExtra = ''
      # Variables
      export IMAGE="imv"
      export VIDEO="mpv"
      export KEYTIMEOUT=1
      export BROWSER="firefox"
      export OPENER="xdg-open"
      export open="xdg-open"
      export TERMINAL="alacritty"
      export TERM="xterm-256color"
      export LAUNCHER="wofi --show drun"
      export FZF_DEFAULT_OPTS="--color=16"
      export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
    '';
  };
}
