{ config, hostname, lib, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix) Bluetooth;
in
with lib;
{
  services.blueman-applet.enable = Bluetooth;
}
