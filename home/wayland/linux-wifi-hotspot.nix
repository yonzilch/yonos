{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix)
  HotSpotUsage;
in
lib.mkIf HotSpotUsage {
  home.packages = with pkgs; [
    linux-wifi-hotspot
  ];
}
