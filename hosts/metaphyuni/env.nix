{
  Bluetooth = true;

  BootLoader = "grub-mirror";

  GPU-AMD = false;
  GPU-Nvidia = false;
  GPU-Intel = false;

  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  KeyboardOptions = "caps:escape";
  Locale = "en_US.UTF-8";
  TimeZone = "Asia/Singapore";

  MonitorSettings = "monitor = , 2560x1600@165, auto, 1.5";
  ScaleLevel = "1";

  Transparent-Proxy = false;
  QEMU-VM-Use-Case = true;

  WM = "Hyprland";
  ZFS-Use-Case = true;
}
