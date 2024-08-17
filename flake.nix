
{
  description = "danihek's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    themecord = {
      url = "github:danihek/Themecord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = 
  {
    self,
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
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          ({ config, pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              themecord.packages.x86_64-linux.default
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
        ];
      };
    };
}
