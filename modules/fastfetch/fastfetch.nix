{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixosminimal";
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
        {
          type = "custom";
          key = "who?";
          format = "ダニシェク";
        }
        "break"
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
            type = "os";
            key = "│ ├";
            keyColor = "green";
        }
        {
          type = "packages";
          key = "│ ├󰏖";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "│ └";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = " DE/WM";
          keyColor = "blue";
        }
        {
          type = "host";
          key = "󰌢 PC";
          keyColor = "green";
        }
      ];
    };
  };
}
