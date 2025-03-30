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
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = inputs @ {
    chaotic,
    daeuniverse,
    disko,
    home-manager,
    nixpkgs,
    stylix,
    ...
  }: let
    hostname = "samyukti";
    username = "admin";
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit hostname inputs username;};
        modules = [
          ./hosts/${hostname}
          chaotic.nixosModules.default
          daeuniverse.nixosModules.daed
          disko.nixosModules.disko
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit hostname inputs username;};
              users.${username} = import ./hosts/${hostname}/home.nix;
            };
          }
        ];
      };
    };
  };
}
