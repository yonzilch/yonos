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
  with lib; {
    config = mkIf ZFS-Use-Case {
      boot = {
        kernelParams = ["zfs_force=1"];
        supportedFilesystems = ["zfs"];
        zfs = {
          devNodes = "/dev/disk/by-id";
          forceImportRoot = false;
          package = mkIf (strings.hasInfix "linuxPackages_cachyos" KernelPackages) pkgs.zfs_cachyos;
        };
      };
      networking.hostId = ZFS-Networking-HostID;
      services.zfs = {
        autoScrub = {
          enable = true;
          interval = "weekly";
        };
        trim = {
          enable = true; # HDD no need
          interval = "weekly";
        };
        autoSnapshot.enable = true;
      };
      systemd.services = {
        zfs-share.enable = mkForce false;
        zfs-zed.enable = mkForce false;
      };
    };
  }
