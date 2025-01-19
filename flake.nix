{
  description =
  "YonOS is a Nix and Flakes❄️ based config customized with Occam's razor
   NixOS is cool🧊, but it'll make you feel cold🥶 when eating this flake, I guess.";

  nixConfig = {
    extra-substituters = [
      "https://chaotic-nyx.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    stylix.url = "github:danth/stylix";

    self-nur.url = "github:yonzilch/nur-packages";
  };

  outputs = inputs@{ chaotic, nixpkgs, home-manager, ... }:
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
            chaotic.nixosModules.default
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
