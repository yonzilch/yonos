# ZFS raid1 as root with encryption and zstd compression
_: {
  disko.devices = {
    disk = {
      mirror1 = {
        content = {
          partitions = {
            boot = {
              attributes = [0];
              priority = 1;
              size = "1M";
              type = "EF02";
            };
            esp = {
              content = {
                format = "vfat";
                mountOptions = ["umask=0077"];
                mountpoint = "/boot";
                type = "filesystem";
              };
              priority = 2;
              size = "1G";
              type = "EF00";
            };
            zfs = {
              content = {
                pool = "zroot";
                type = "zfs";
              };
              size = "100%";
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/disk1";
        type = "disk";
      };
      mirror2 = {
        content = {
          partitions = {
            boot = {
              priority = 0;
              size = "1M";
              type = "EF02";
            };
            esp = {
              priority = 1;
              size = "1G";
              type = "EF00";
              content = {
                format = "vfat";
                mountOptions = ["umask=0077"];
                mountpoint = "/boot-mirror";
                type = "filesystem";
              };
            };
            zfs = {
              content = {
                pool = "zroot";
                type = "zfs";
              };
              size = "100%";
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/disk2";
        type = "disk";
      };
    };
    zpool = {
      zroot = {
        datasets = {
          "root" = {
            mountpoint = "/";
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "false";
            };
            type = "zfs_fs";
          };
          "root/home" = {
            mountpoint = "/home";
            options = {
              "com.sun:auto-snapshot" = "true";
            };
            type = "zfs_fs";
          };
          "root/nix" = {
            mountpoint = "/nix";
            options = {
              "com.sun:auto-snapshot" = "false";
            };
            type = "zfs_fs";
          };
          "root/persist" = {
            mountpoint = "/persist";
            options = {
              "com.sun:auto-snapshot" = "true";
            };
            type = "zfs_fs";
          };
        };
        mode = "mirror";
        options = {
          ashift = "12";
          compatibility = "grub2";
        };
        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/root@blank$' || zfs snapshot zroot/root@blank";
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          compression = "zstd";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
          # keylocation = "file:///tmp/secret.key";
          mountpoint = "none";
          xattr = "sa";
        };
        type = "zpool";
      };
    };
  };
}
