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
                mountOptions = [ "umask=0077" ];
                mountpoint = "/boot1";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "mirror";
              };
            };
          };
          type = "gpt";
        };
        device = "/dev/sda";
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
                mountOptions = [ "umask=0077" ];
                mountpoint = "/boot1";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "mirror";
              };
            };
          };
          type = "gpt";
        };
        device = "/dev/sda";
        type = "disk";
      };
    };
    zpool = {
      mirror = {
        datasets = {
          root = {
            mountpoint = "/";
            type = "zfs_fs";
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "false";
            };
          };
        };
        mode = "mirror";
        options.ashift = "12";
        type = "zpool";
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          compression = "lz4";
          mountpoint = "none";
          xattr = "sa";
        };
      };
    };
  };
}
