{
  description = "YonOS is a Nix and Flakes❄️ based config set customized with Occam's razor
    NixOS is cool🧊, but it'll make you feel cold🥶 when eating this flake, I guess.";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
  };
  outputs = inputs: let
    hostname = "nixos";
    username = "admin";
  in {
    nixosConfigurations = {
      "${hostname}" = inputs.nixpkgs.lib.nixosSystem {
        modules = [./hosts];
        specialArgs = {inherit hostname inputs username;};
      };
    };
  };
}
