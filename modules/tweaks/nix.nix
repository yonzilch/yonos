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
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" ];
      gc-keep-derivations = lib.mkDefault false;
      gc-keep-outputs = lib.mkDefault false;
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      warn-dirty = lib.mkDefault false;
    };
  };
  nixpkgs = {
    config.allowUnfree = lib.mkForce true;
    hostPlatform = "x86_64-linux";
  };
}
