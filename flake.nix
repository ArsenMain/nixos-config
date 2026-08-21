{
  description = "Lily's Lovely fLake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    # Since more attributes than are expected can be passed here [variadic] we name the attribute set inputs with the @inputs syntax, being able to access any given but not explicitly named atributes
    {
      nixpkgs,
      home-manager,
      nvf,
      niri,
      ...
    }@inputs:
    {
      nixosConfigurations.stina = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/stina
          ./gen
          nvf.nixosModules.default
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.lily.home.stateVersion = "25.11";
            };
          }
        ];
      };

      nixosConfigurations.missabuse = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/missabuse
          ./gen
          nvf.nixosModules.default
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.lily.home.stateVersion = "25.11";
            };
          }
        ];
      };
    };
}
