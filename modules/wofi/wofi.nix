{
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      insensitiv = true;
      columns = "5";
      width = "600";
      height = "400";
      filter_rate = "100";
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      drun-display_generic = true;
    };
  };
}
