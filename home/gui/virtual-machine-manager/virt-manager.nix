{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../../hosts/${hostname}/env.nix) QEMU-VM-Use-Case;
in
with lib;
mkIf QEMU-VM-Use-Case {
  home.packages = with pkgs; [
    virt-manager
  ];
}
