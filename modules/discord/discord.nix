{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  home.packages = [
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}


