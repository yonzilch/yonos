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
  BootLoader = "systemd-boot";
  DNS-Method = "NetworkManager";
  KernelPackages = "linuxPackages_xanmod";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  StateVersion = "26.05";
  TimeSync-Method = "NTS";
  TimeZone = "Asia/Singapore";

  ## Wayland related
  MonitorSettings = ''output = "", mode = "highres", position = "auto", scale = 2'';
  OutputSettings = "output * resolution 3840x2160@144Hz scale 2";
  ScaleLevel = "2";
  WM = "Hyprland";
}
