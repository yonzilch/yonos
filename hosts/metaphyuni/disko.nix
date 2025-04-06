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
                mountOptions = ["nofail" "umask=0077"];
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
        device = "/dev/disk/by-id/nvme-SSSTC_CL4-8D512_00233540017F";
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
                mountOptions = ["nofail" "umask=0077"];
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
        device = "/dev/disk/by-id/nvme-SSSTC_CL4-8D512_002212400M02";
        type = "disk";
      };
    };
    zpool = {
      zroot = {
        datasets = {
          home = {
            mountpoint = "/home";
            options."com.sun:auto-snapshot" = "true";
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
              mountpoint = "legacy";
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
