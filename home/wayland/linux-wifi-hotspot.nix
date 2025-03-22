{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix)
  HotSpot-Use-Case;
in
lib.mkIf HotSpot-Use-Case {
  home.packages = with pkgs; [
    linux-wifi-hotspot
  ];
}
