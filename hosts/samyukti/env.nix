{
  Bluetooth = true;

  BootLoader = "systemd-boot";

  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = true;

  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  TimeZone = "Asia/Singapore";

  MonitorSettings = "monitor = , highres, auto, 2";
  ScaleLevel = "2";

  Power-Implement = true;
  Transparent-Proxy = false;
  QEMU-VM-Use-Case = true;

  WM = "Hyprland";
  ZFS-Use-Case = true;
}
