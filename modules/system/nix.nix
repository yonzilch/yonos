{ inputs, lib, ... }:
{
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  nix = {
    channel.enable = false;
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    # package = pkgs.lix; # use lix instead of nix would cause clan-cli error
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" ];
      gc-keep-derivations = lib.mkDefault false;
      gc-keep-outputs = lib.mkDefault false;
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      substituters = [
        "https://cache.garnix.io" # see https://github.com/daeuniverse/flake.nix
        "https://cache.nixos.org" # see https://nixos.wiki/wiki/Binary_Cache
        "https://chaotic-nyx.cachix.org" # see https://github.com/chaotic-cx/nyx
        "https://nix-community.cachix.org" # see https://nix-community.org/cache/
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      warn-dirty = lib.mkDefault false;
    };
  };
  nixpkgs = {
    config.allowUnfree = lib.mkDefault false;
    hostPlatform = "x86_64-linux";
  };
}
