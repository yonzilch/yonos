{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = true;
  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = true;
  HotSpot-Use-Case = true;
  ZFS-Networking-HostID = "b53024b6";
  ZFS-Use-Case = false;

  ## Software related
  QEMU-VM-Use-Case = true;
  Transparent-Proxy = true;

  # Options
  ## Basic
  BootLoader = "systemd-boot";
  DNS-Method = "DoT";
  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "25.05";
  TimeSync-Method = "NTS";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , highres, auto, 2";
  OutputSettings = "output DP-3 scale 2 res 3840x2160@144.000Hz";
  ScaleLevel = "2";
  WM = "sway";
}
