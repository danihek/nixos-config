{ config, pkgs, ... }:

{
  programs = {
    btop = {
      enable = true;
      package = pkgs.btop.overrideAttrs (oldAttrs: rec {
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          "-DBTOP_RSMI_STATIC=ON"
          "-DBTOP_GPU=ON"
        ];
      });
    };
  };
}
