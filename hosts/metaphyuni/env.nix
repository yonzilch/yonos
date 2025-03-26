{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = true;
  GPU-AMD = false;
  GPU-Nvidia = false;
  GPU-Intel = false;
  HotSpot-Use-Case = true;
  ZFS-Networking-HostID = "60114255";
  ZFS-Use-Case = true;

  ## Software related
  QEMU-VM-Use-Case = true;
  Transparent-Proxy = false;


  # Options
  ## Basic
  BootLoader = "grub-mirror";
  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "monitor = , 2560x1600@100, auto, 1.6";
  OutputSettings = "output * resolution 2560x1600@100 scale 1.6";
  ScaleLevel = "1.6";
  WM = "Hyprland";
}
