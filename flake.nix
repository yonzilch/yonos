{
  description = ''
    YonOS is a Nix and Flakes❄️ based config set customized with Occam's razor
    NixOS is cool🧊, but it'll make you feel cold🥶 when eating this flake, I guess.
  '';

  inputs = {
    daeuniverse.url = "github:daeuniverse/flake.nix";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-26.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;

      hostsDirectory = ./hosts;

      excludedHosts = [
        "example"
      ];

      hostEntries = builtins.readDir hostsDirectory;

      hostnames = builtins.filter (
        hostname:
        hostEntries.${hostname} == "directory"
        && !(builtins.elem hostname excludedHosts)
        && builtins.pathExists (hostsDirectory + "/${hostname}/default.nix")
      ) (builtins.attrNames hostEntries);

      mkHost =
        hostname:
        let
          hostDirectory = hostsDirectory + "/${hostname}";
          hostEnvironment = import (hostDirectory + "/env.nix");
          username = hostEnvironment.Username;
        in
        lib.nixosSystem {
          modules = [
            ./hosts
            hostDirectory
          ];
          specialArgs = {
            inherit hostname inputs username;
          };
        };
    in
    {
      nixosConfigurations = lib.genAttrs hostnames mkHost;
    };
}
