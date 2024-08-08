
{
  description = "danihek's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = 
  {
    self,
    nixpkgs,
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
          ./hosts/t430/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      
      nixosConfigurations.mainpc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/z690/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
