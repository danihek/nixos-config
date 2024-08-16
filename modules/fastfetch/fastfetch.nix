{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
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
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14} ={17}:{20}";
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
