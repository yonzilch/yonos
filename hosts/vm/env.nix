{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = false;
  GPU-AMD = false;
  GPU-Nvidia = false;
  GPU-Intel = false;
  HotSpot-Use-Case = false;
  ZFS-Networking-HostID = "5b0ad87c";
  ZFS-Use-Case = true;

  ## Software related
  QEMU-VM-Use-Case = false;
  Transparent-Proxy = false;

  # Options
  ## Basic
  BootLoader = "grub";
  DNS-Method = "DoT";
  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "25.05";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , 2560x1440@60, auto, 1.6";
  OutputSettings = "output * resolution 2560x1440@60Hz scale 1.6";
  ScaleLevel = "1.6";
  WM = "niri";
}
