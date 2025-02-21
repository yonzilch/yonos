{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix) WM;
in
with lib;
mkIf (WM == "niri")
{
  home.packages = with pkgs; [
    nautilis
    niri
  ];
}
