{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pywalfox-native
  ];

  home.activation.installPywalfox = lib.hm.dag.entryAfter ["writeBoundary"]
  ''
    #!/usr/bin/env bash
    ${pkgs.pywalfox-native}/bin/pywalfox install
  '';
}
