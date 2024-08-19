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

      set-window-option -g clock-mode-colour green 
      set-window-option -g window-status-style fg=colour244,bg=default,dim
      set-window-option -g window-status-current-style fg=colour166,bg=default,bright
      
      set -g status-interval 1
      set -g status-justify centre
      set -g status-left-length 20
      set -g status-right-length 140
      set -g status-left '#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r | cut -c 1-6)#[default]'
      set -g status-right '#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) #[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") #[fg=white,bg=default]%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d'
      
      set -g base-index 1
      set -s escape-time 50
      set -g visual-activity on
      set-window-option -g mode-keys vi
      set-window-option -g automatic-rename

      setw -g aggressive-resize on
      setw -g monitor-activity on

      bind l display-popup "~/code/bash/wls/wls.sh $(cat Makefile | grep PKGS | cut -d'=' -f 2 | head -n 1)"
    '';
  };
}
