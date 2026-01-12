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
  QEMU-VM-Use-Case = true;

  # Options
  ## Basic
  BootLoader = "limine";
  DNS-Method = "unbound";
  KernelPackages = "linuxPackages_xanmod";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "25.11";
  TimeSync-Method = "NTS";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , highres, auto, 2";
  OutputSettings = "output * scale 2";
  ScaleLevel = "2";
  WM = "sway";
}
