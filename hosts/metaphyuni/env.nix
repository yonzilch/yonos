{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = true;
  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = false;
  HotSpot-Use-Case = true;
  ZFS-Use-Case = true;

  ## Software related
  QEMU-VM-Use-Case = true;
  Transparent-Proxy = true;

  # Options
  ## Basic
  BootLoader = "grub-mirror";
  DNS-Method = "Plain";
  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "25.11";
  TimeSync-Method = "NTS";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = "
    monitor = eDP-1, 2560x1600@100, auto, 1.6
    monitor = DP-1, 3840x2160@144, auto, 2
    ";
  ScaleLevel = "2";
  WM = "Hyprland";
}
