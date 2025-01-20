{ lib, ... }:
{
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
    settings = {
      auto-optimise-store = lib.mkDefault true;
      gc-keep-outputs = lib.mkDefault false;
      gc-keep-derivations = lib.mkDefault false;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  nixpkgs = {
    config.allowUnfree = lib.mkForce true;
    hostPlatform = "x86_64-linux";
  };
}
