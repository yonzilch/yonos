{hostname, ...}: let
  inherit (import ../../hosts/${hostname}/env.nix) Bluetooth;
in {
  services.blueman-applet.enable = Bluetooth;
}
