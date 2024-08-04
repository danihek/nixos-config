
{
  description = "danihek's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:donovanglover/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
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
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./main/desktop/configuration.nix
          ./main/modules/modulesEnabled.nix

          inputs.stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
