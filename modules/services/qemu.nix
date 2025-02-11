{ hostname, lib, ... }:
with lib;
let
  inherit (import ../../hosts/${hostname}/env.nix) QEMU-VM-Use-Case;
in
{
  config = mkIf QEMU-VM-Use-Case {

    programs.virt-manager.enable = true;

    services = {
      cockpit.enable = true;
      qemuGuest.enable = true;
      spice-vdagentd.enable = true;
      spice-webdavd.enable = true;
    };

    virtualisation.libvirtd.enable = true;
  };
}
