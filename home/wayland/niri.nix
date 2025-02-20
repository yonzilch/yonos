{ hostname, lib, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix) WM;
in
with lib;
mkIf (WM == "niri")
{
  programs.niri = {
    enable = true;
  };
}
