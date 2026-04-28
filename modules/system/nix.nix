{
  inputs,
  lib,
  ...
}:
with lib; {
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  nix = {
    channel.enable = false;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    # package = pkgs.lix; # use lix instead of nix would cause clan-cli error
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      connect-timeout = 5;
      gc-keep-derivations = false;
      gc-keep-outputs = false;
      keep-going = true;
      log-lines = 25;
      nix-path = mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      substituters = [
        "https://cache.garnix.io" # See https://github.com/daeuniverse/flake.nix
        "https://cache.nixos.org" # See https://nixos.wiki/wiki/Binary_Cache
        "https://nix-community.cachix.org" # See https://nix-community.org/cache/
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      warn-dirty = false;
    };
  };
  nixpkgs = {
    config.allowUnfree = false;
    hostPlatform = "x86_64-linux";
  };
}
