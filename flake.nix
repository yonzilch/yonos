{
  description =
  "YonOS is a Nix and Flakes❄️ based config customized with Occam's razor
   NixOS is cool🧊, but it'll make you feel cold🥶 when eating this flake, I guess.";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    stylix.url = "github:danth/stylix";

    self-nur.url = "github:yonzilch/nur-packages";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      hostname = "samyukti";
      username = "admin";
    in
    {
      nixosConfigurations = {
        "${hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit hostname;
            inherit inputs;
            inherit username;
          };
          modules = [
            ./hosts/${hostname}/config.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit hostname;
                inherit inputs;
                inherit username;
              };
              home-manager.users.${username} = import ./hosts/${hostname}/home.nix;
            }
          ];
        };
      };
    };
}
