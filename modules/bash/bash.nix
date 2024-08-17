{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      g = "git";
      sl = "ls";
      lf = "yazi"; #xd
      tm = "tmux";
      l = "ls -l";
      ll = "ls -lh";
      nv = "neovide";
      la = "ls -alh";
      cl = "clear & l";
      fucking = "sudo";
      lla = "ls -alh";
      tree = "tree";
      mkcl = "make clean";
      neofetch = "fastfetch";
      TODO = "vim ~/.TODO.md";
      cpl = "make clean ; clear; make";
    };

    initExtra = ''
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi

      # Prompt 
      PROMPT="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)] "

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
      export open="xdg-open"
      export TERMINAL="alacritty"
      export TERM="xterm-256color"
      export LAUNCHER="wofi --show drun"
      export FZF_DEFAULT_OPTS="--color=16"
      export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
    '';
  };
}
