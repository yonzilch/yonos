{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = false;
  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = false;
  Power-Implement = true;
  ZFS-Use-Case = true;

  ## Software related
  QEMU-VM-Use-Case = true;
  Transparent-Proxy = false;


  # Options
  ## Basic
  BootLoader = "systemd-boot";
  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , highres, auto, 2";
  ScaleLevel = "2";
  WM = "Hyprland";
}
