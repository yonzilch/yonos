{ hostname, lib, pkgs, ... }:
with lib; let
  inherit (import ../../../hosts/${hostname}/env.nix) QEMU-VM-Use-Case;
in
mkIf QEMU-VM-Use-Case {
  home.packages = with pkgs; [
    virt-manager
  ];
}
