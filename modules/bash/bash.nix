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
       GIT_PS1_CMD() { [ "$PS1_CMD1" != "" ] && PS1_CMD1="$PS1_CMD1 "; }
       PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>> /dev/null) ; GIT_PS1_CMD'
       PS1='[\[\e[38;5;169;1m\]\u\[\e[0;38;5;196m\]@\[\e[38;5;69;1m\]\h\[\e[0m\]:\[\e[38;5;128m\]\w\[\e[0m\]]\e[38;5;156m\] ${PS1_CMD1}\[\e[0m\]'
    '';
    
    sessionVariables = {
      TERM="screen-256color";
      FZF_DEFAULT_OPTS="--color=16";
    };
  };
}
