{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
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
    '';
    
    sessionVariables = {
      IMAGE="imv";
      VIDEO="mpv";
      KEYTIMEOUT=1;
      BROWSER="firefox";
      OPENER="xdg-open";
      open="xdg-open";
      TERMINAL="alacritty";
      TERM="xterm-256color";
      LAUNCHER="wofi --show drun";
      FZF_DEFAULT_OPTS="--color=16";
      _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd";
    };
  };
}
