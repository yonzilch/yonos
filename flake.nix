{
  description = "YonOS is a Nix and Flakes❄️ based config customized with Occam's razor
   NixOS is cool🧊, but it'll make you feel cold🥶 when eating this flake, I guess.";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    stylix.url = "github:danth/stylix";

    self-nur.url = "github:yonzilch/nur-packages";
  };

  outputs = inputs @ {
    chaotic,
    daeuniverse,
    disko,
    nixpkgs,
    home-manager,
    stylix,
    ...
  }: let
    hostname = "metaphyuni";
    username = "admin";
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit hostname;
          inherit inputs;
          inherit username;
        };
        modules = [
          ./hosts/${hostname}/default.nix
          chaotic.nixosModules.default
          daeuniverse.nixosModules.daed
          disko.nixosModules.disko
          stylix.nixosModules.stylix
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
