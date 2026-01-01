{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = false;
  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = true;
  HotSpot-Use-Case = false;
  ZFS-Networking-HostID = "b53024b6";
  ZFS-Use-Case = false;

  ## Software related
  Proxy-Provider = "throne";
  QEMU-VM-Use-Case = false;

  # Options
  ## Basic
  BootLoader = "limine";
  DNS-Method = "unbound";
  KernelPackages = "linuxPackages_zen";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "26.05";
  TimeSync-Method = "NTS";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , highres, auto, 2";
  OutputSettings = "output DP-3 scale 2 res 3840x2160@144.000Hz";
  ScaleLevel = "2";
  WM = "sway";
}
