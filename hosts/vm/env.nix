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
  Proxy-Provider = "daed";
  QEMU-VM-Use-Case = false;

  # Options
  ## Basic
  BootLoader = "grub";
  DNS-Method = "NetworkManager";
  KernelPackages = "linuxPackages_xanmod_stable";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "25.11";
  TimeSync-Method = "NTS";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , 2560x1440@60, auto, 1.6";
  OutputSettings = "output * resolution 2560x1440@60Hz scale 1.6";
  ScaleLevel = "1.6";
  WM = "niri";
}
