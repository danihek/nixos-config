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

      parse_git_branch() {
        branch=$(git rev-parse --abbrev-ref HEAD)
        [ $? -eq 0 ] && echo $branch | sed 's/$/ /' > /dev/null
      }

      # Prompt 
      PS1="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}] "

      set_git_prompt() {
        printf -- "%''${COLUMNS}s\n" "$(tput setaf 3)$(parse_git_branch)"
      }
      precmd() {
        set_git_prompt
      }

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
