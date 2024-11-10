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
	        shape = "Beam";
	        blinking = "Always";
            interval = 0.3;
	      };
          vi_mode_style = {
            shape = "Block";
	        blinking = "Always";
            interval = 0.3;
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
