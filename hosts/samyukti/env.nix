{
  # Specific Use Cases
  ## Hardware related
  Bluetooth = false;
  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = false;
  ZFS-Networking-HostID = "b53024b6";
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
  MonitorSettings = "monitor = , highres, auto, 1.875";
  ScaleLevel = "1.875";
  WM = "Hyprland";
}
