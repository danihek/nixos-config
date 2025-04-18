{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-option -g status-style bg=colour235,fg=colour136,default
      set-option -g pane-border-style fg=colour235
      set-option -g pane-active-border-style fg=colour240
      set-option -g message-style bg=colour235,fg=colour166
      
      set-option -g display-panes-active-colour colour33
      set-option -g display-panes-colour colour166 
      set-option -g default-shell /run/current-system/sw/bin/bash

      set-window-option -g clock-mode-colour green 
      set-window-option -g window-status-style fg=colour244,bg=default,dim
      set-window-option -g window-status-current-style fg=colour166,bg=default,bright
      
      set -g status-interval 1
      set -g status-justify centre
      set -g status-left-length 20
      set -g status-right-length 140
      set -g status-left '#[fg=green,bright]#(whoami)@#[fg=cyan]#H #[fg=red]•#[fg=yellow]  #[default]'
      set -g status-right '#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) #[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") #[fg=white,bg=default]%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d'
      
      set -g base-index 1
      set -s escape-time 50
      set -g visual-activity on
      set-window-option -g mode-keys vi
      set-window-option -g automatic-rename


      # Fix tmux-neovim error
      # https://www.reddit.com/r/NixOS/comments/13iqrj8/tmux_resurrect_doesnt_resurrect_nvim_sessions/
      resurrect_dir="$HOME/.tmux/resurrect"
      set -g @resurrect-dir $resurrect_dir
      set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'

      setw -g aggressive-resize on
      setw -g monitor-activity on

      bind l display-popup "dpcs"
    '';
  };
}
