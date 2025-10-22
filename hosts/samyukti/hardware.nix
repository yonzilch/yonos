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

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8713458b-45c1-430c-b545-585fb7296001";
    fsType = "xfs";
  };

  boot.initrd.luks.devices."luks-50c130bb-d2fd-4719-8b27-252e0e586edb".device = "/dev/disk/by-uuid/50c130bb-d2fd-4719-8b27-252e0e586edb";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9965-0792";
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
      # Continute when it failed
      "nofail"
      # Do not synchronously update access or modification times
      "lazytime"
    ];
  };
  systemd.tmpfiles.rules = [
    "d /run/media/admin/hdd1 0777 admin admin - -"
    "d /run/media/admin/hdd2 0777 admin admin - -"
  ];

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
