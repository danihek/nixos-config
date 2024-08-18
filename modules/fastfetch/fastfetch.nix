{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
        padding = {
          right = 1;
        };
      };
      display = {
        size.binaryPrefix = "si";
        color = "blue";
        separator = "  ";
      };
      modules = [
        "break"
        "break"
        "break"
        "break"
        "break"
        {
          type = "custom";
          key = "who?";
          format = "ダニシェク";
        }
        "break"
        {
          type = "host";
          key = "󰌢 PC";
          keyColor = "blue";
        }
        {
            type = "os";
            key = "│ ├";
            keyColor = "blue";
        }
        {
          type = "packages";
          key = "│ ├󰏖";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "shell";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
      ];
    };
  };
}
