{
  programs.alacritty = {
    settings = {
      window = {
        padding.x = 15;
   	    padding.y = 15;
   	    decorations = "none";
   	    startup_mode = "Windowed";
   	    dynamic_title = true;
   	    opacity = 0.6;
        #background = "#0f1210";
      };

      cursor = {
	      style = {
	        shape = "Beam";
	        blinking = "Always";
	      };
      };

      mouse = {
        hide_when_typing = true;
      };

      font = {
        normal = {
          #family = "Source Code Pro";
          family = "JetBrains Mono Medium";
        };
      };
    }; 
  };
}
