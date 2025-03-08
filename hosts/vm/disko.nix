_: {
  disko.devices = {
    disk = {
      mirror1 = {
        content = {
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
              priority = 0;
            };
            ESP = {
              size = "1G";
              type = "EF00";
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountOptions = [ "nofail" "umask=0077" ];
                mountpoint = "/boot";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-0-0-1";
        type = "disk";
      };
      mirror2 = {
        content = {
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
              priority = 0;
            };
            ESP = {
              size = "1G";
              type = "EF00";
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountOptions = [ "nofail" "umask=0077" ];
                mountpoint = "/boot-mirror";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-0-0-2";
        type = "disk";
      };
    };
    zpool = {
      zroot = {
        datasets = {
          home = {
            mountpoint = "/home";
            options."com.sun:auto-snapshot" = "false";
            type = "zfs_fs";
          };
          nix = {
            mountpoint = "/nix";
            options."com.sun:auto-snapshot" = "false";
            type = "zfs_fs";
          };
          persist = {
            mountpoint = "/persist";
            options."com.sun:auto-snapshot" = "false";
            type = "zfs_fs";
          };
          root = {
            mountpoint = "/";
            options = {
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
              #keylocation = "file:///tmp/secret.key";
              keylocation = "prompt";
              "com.sun:auto-snapshot" = "false";
            };
            type = "zfs_fs";
          };
        };
        mode = "mirror";
        options = {
          ashift = "12";
          compatibility = "grub2";
        };
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          compression = "lz4";
          mountpoint = "none";
          xattr = "sa";
        };
        type = "zpool";
      };
    };
  };
}
