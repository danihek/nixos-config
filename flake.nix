
{
  description = "danihek's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    dpcs = {
      url = "github:danihek/dpcs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    themecord = {
      url = "github:danihek/Themecord/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = 
  {
    self,
    dpcs,
    nixpkgs,
    themecord,
    home-manager,
    ... 
  } 
  @inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/shared.nix
          ./hosts/t430/configuration.nix
          inputs.home-manager.nixosModules.default 

          ({ config, pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              themecord.packages.x86_64-linux.default
            ];
          })

          ({ config, pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              dpcs.packages.x86_64-linux.default
            ];
          })

        ];
      };
      
      nixosConfigurations.mainpc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/shared.nix
          ./hosts/z690/configuration.nix
          inputs.home-manager.nixosModules.default

          ({ config, pkgs, ... }: {
           environment.systemPackages = with pkgs; [
              themecord.packages.x86_64-linux.default
           ];
          })
          
          ({ config, pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              dpcs.packages.x86_64-linux.default
            ];
         })

        ];
      };
    };
}
