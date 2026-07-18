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
  StateVersion = "26.05";
  TimeSync-Method = "NTS";
  TimeZone = "Asia/Singapore";
  Username = "admin";

  ## Wayland related
  MonitorSettings = ''
    hl.monitor({output = "eDP-1", mode = "2560x1600@120", position = "1920x0", scale = 1.6})
    hl.monitor({output = "DP-1", mode = "3840x2560@120", position = "0x0", scale = 2})
  '';
  OutputSettings = "output * resolution 2560x1600@165Hz scale 1.6";
  ScaleLevel = "2";
  WM = "Hyprland";
}
