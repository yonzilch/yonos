{
  hostname,
  lib,
  ...
}:
with lib; let
  inherit (import ../../hosts/${hostname}/env.nix) QEMU-VM-Use-Case;
in {
  config = mkIf QEMU-VM-Use-Case {
    services = {
      spice-vdagentd.enable = true;
      spice-webdavd.enable = true;
    };
    virtualisation.libvirtd.enable = true;
  };
}
