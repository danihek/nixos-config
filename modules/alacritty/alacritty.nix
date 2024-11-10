{
  programs.alacritty = {
    settings = {
      window = {
        padding.x = 1;
        padding.y = 1;
        decorations = "none";
        dynamic_title = true;
        opacity = 0.6;
        #startup_mode = "Windowed";
      };

      cursor = {
	      style = {
	        shape = "Block";
	        blinking = "Always";
            blink_interval = 350;
	      };
          vi_mode_style = {
            shape = "Block";
	        blinking = "Always";
            blink_interval = 250;
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
