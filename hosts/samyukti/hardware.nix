{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "uas"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  boot.initrd.luks.devices."luks-b25a930d-cdb4-40bc-8e88-43b33f1539b7".device = "/dev/disk/by-uuid/b25a930d-cdb4-40bc-8e88-43b33f1539b7";

  fileSystems."/" = {
    device = "/dev/mapper/luks-b25a930d-cdb4-40bc-8e88-43b33f1539b7";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DCEA-AF87";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/run/media/admin/hdd1" = {
    device = "/dev/disk/by-id/ata-HSH721414ALN6M0_VEGU6RTY";
    fsType = "f2fs";
    options = [
      # Continute when it failed
      "nofail"
      # Enable compress
      "compress_algorithm=zstd:6"
      "compress_chksum"
      # Enable better garbage collector
      "gc_merge"
      # Do not synchronously update access or modification times
      "lazytime"
    ];
  };
  fileSystems."/run/media/admin/hdd2" = {
    device = "/dev/disk/by-id/ata-ST2000VX000-1ES164_W4Z317X9-part1";
    fsType = "exfat";
    options = [
      "nofail"
      "gid=100"
      "lazytime"
      "uid=1000"
      "umask=0000"
    ];
  };
  systemd.tmpfiles.rules = [
    "d /run/media/admin/hdd1 0755 admin admin - -"
    "d /run/media/admin/hdd2 0755 admin admin - -"
  ];

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
