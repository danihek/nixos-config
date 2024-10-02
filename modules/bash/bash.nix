{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    shellAliases = {
      g = "git";
      sl = "ls";
      ls = "eza";
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
      # fzf - Completion & Keybindings
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi

      # Pywal colors
      [ -d "$HOME/.cache/wal" ] && eval "$(cat $HOME/.cache/wal/colors.sh)"

      # Prompt 
      PS1='\u@\h:\w > '

       # Keybindings
          bind '"\e[1;5A": history-search-backward'
          bind '"\e[1;5B": history-search-forward'
    '';
    
    sessionVariables = {
      FZF_DEFAULT_OPTS="--color=16";
    };
  };
}
