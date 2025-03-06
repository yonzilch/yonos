{
  hostname,
  lib,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/env.nix)
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
      };
    };
    # Where hostID can be generated with:
    # head -c4 /dev/urandom | od -A none -t x4
    # networking.hostId = "";
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
