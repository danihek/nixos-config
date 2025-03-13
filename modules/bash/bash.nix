{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    shellAliases = {
      g = "git";
      sl = "ls";
      nd= "nix develop";
      ls = "eza";
      lf = "yazi"; #xd - only for image support
      tm = "tmux";
      l = "lsd -l";
      tree = "tree";
      ll = "ls -lh";
      nv = "neovide";
      la = "ls -alh";
      lla = "ls -alh";
      cl = "clear ; l";
      fucking = "sudo";
      mkcl = "make clean";
      nrun = "nix-shell -p"; 
      TODO = "vim ~/.TODO.md";
      cpl = "make clean ; clear; make";
    };

    initExtra = ''
      # fzf - Completion & Keybindings
      if command -v fzf-share >/dev/null; then
        if [ -f $(fzf-share)/key-bindings.bash ]; then
            source "$(fzf-share)/key-bindings.bash"
        fi
        
        if [ -f $(fzf-share)/completion.bash ]; then
            source "$(fzf-share)/completion.bash"
        fi
      fi

      # Pywal colors
      #[ -d "$HOME/.cache/wal" ] && eval "$(cat $HOME/.cache/wal/colors.sh)"

      # Hellwal colors
      #[ -d "$HOME/.cache/hellwal" ] && eval "$(cat $HOME/.cache/hellwal/terminal.sh)"

      # Prompt 
      # dh@nix:~ > neofetch
      #PS1='\[\033[36m\]\u\[\033[35m\]@\[\033[31m\]\h:\[\033[32m\]\w \[\033[33m\]>\[\033[37m\] '

      # ~ dh »
      PS1='\[\033[36m\]\u \[\033[33m\]»\[\033[37m\] '

      # Keybindings
      bind '"\e[1;5A": history-search-backward'
      bind '"\e[1;5B": history-search-forward'

      source ~/.cache/hellwal/variables.sh
      sh ~/.cache/hellwal/terminal.sh
    '';
    
    sessionVariables = {
      FZF_DEFAULT_OPTS="--color=16";
    };
  };
}
