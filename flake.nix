{
  description = "YonOS is a Nix and Flakes❄️ based config set customized with Occam's razor
    NixOS is cool🧊, but it'll make you feel cold🥶 when eating this flake, I guess.";

  inputs = {
    daeuniverse.url = "github:daeuniverse/flake.nix";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-26.05";
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
