{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = false;
  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = false;
  HotSpot-Use-Case = false;
  ZFS-Networking-HostID = "b53024b6";
  ZFS-Use-Case = true;

  ## Software related
  QEMU-VM-Use-Case = true;
  Transparent-Proxy = true;

  # Options
  ## Basic
  BootLoader = "systemd-boot";
  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "25.05";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , highres, auto, 2";
  OutputSettings = "output * scale 2";
  ScaleLevel = "2";
  WM = "sway";
}
