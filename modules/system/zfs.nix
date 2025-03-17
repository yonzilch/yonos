{
  hostname,
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/env.nix)
    KernelPackages
    ZFS-Networking-HostID
    ZFS-Use-Case
    ;
in
{
  config = lib.mkIf ZFS-Use-Case {
    boot = {
      kernelParams = [
        "zfs_force=1"
      ];
      zfs = {
        forceImportRoot = false;
        devNodes = "/dev/disk/by-id";
        package = lib.mkIf (KernelPackages == "linuxPackages_cachyos") pkgs.zfs_cachyos;
      };
    };
    networking.hostId = ZFS-Networking-HostID;
    services.zfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
      };
      trim = {
        enable = true; # hdd no need
        interval = "weekly";
      };
      autoSnapshot.enable = true;
    };
  };
}
