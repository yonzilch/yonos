{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = true;
  GPU-AMD = false;
  GPU-Nvidia = false;
  GPU-Intel = false;
  HotSpot-Use-Case = false;
  ZFS-Networking-HostID = "";
  ZFS-Use-Case = false;

  ## Software related
  Proxy-Provider = "throne";
  QEMU-VM-Use-Case = false;

  # Options
  ## Basic
  BootLoader = "limine";
  DNS-Method = "NetworkManager";
  KernelPackages = "linuxPackages_xanmod";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "25.11";
  TimeSync-Method = "NTS";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , 2560x1600@120, auto, 1.6";
  OutputSettings = "output * resolution 2560x1600@165Hz scale 1.6";
  ScaleLevel = "1.6";
  WM = "Hyprland";
}
