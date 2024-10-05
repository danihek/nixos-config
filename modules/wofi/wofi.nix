{
  programs.wofi = {
    enable = true;
    settings = {
      stylesheet = "~/.cache/wal/colors-wofi.css";
      allow_images = true;
      insensitiv = true;
      no_actions = true;
      columns = 5;
      show = "drun";
      term = "foot";
      layer = "overlay";
    };
  };
}
