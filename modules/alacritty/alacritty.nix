{
  programs.alacritty = {
    settings = {
      window = {
        padding.x = 1;
        padding.y = 1;
        decorations = "none";
        dynamic_title = true;
        opacity = 0.6;
      };

      cursor = {
          blink_interval = 350;
	      style = {
	        shape = "Block";
            #blinking = "Always";
	      };
          vi_mode_style = {
            shape = "Block";
            #blinking = "Always";
          };
      };

      mouse = {
        hide_when_typing = true;
      };

      font = {
        normal = {
          family = "JetBrains Mono Medium";
        };
      };
    }; 
  };
}
