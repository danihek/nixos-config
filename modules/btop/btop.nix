{ config, pkgs, ... }:

{
  programs = {
    btop = {
      enable = true;
      package = pkgs.master.btop.overrideAttrs (oldAttrs: rec {
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          "-DBTOP_RSMI_STATIC=ON"
          "-DBTOP_GPU=ON"
        ];
      });
    };
  };
}
