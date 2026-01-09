_: {
  disko.devices = {
    disk = {
      "SSSTC_CL4-8D512_00233540017F" = {
        device = "/dev/disk/by-id/nvme-SSSTC_CL4-8D512_00233540017F";
        type = "disk";
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
                type = "filesystem";
                format = "vfat";
                mountOptions = ["umask=0077"];
                mountpoint = "/boot";
              };
              priority = 2;
              size = "1G";
              type = "EF00";
            };
            luks-root = {
              content = {
                content = {
                  type = "filesystem";
                  format = "f2fs";
                  mountpoint = "/";
                  extraArgs = [
                    "-O"
                    "compression,extra_attr,inode_checksum,sb_checksum"
                  ];
                  mountOptions = [
                    "atgc,compress_algorithm=zstd:6,compress_chksum,gc_merge,lazytime,nodiscard"
                  ];
                };
                name = "luks-root";
                type = "luks";
              };
              size = "100%";
            };
          };
          type = "gpt";
        };
      };
    };
  };
}
