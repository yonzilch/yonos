{
  Bluetooth = true;

  BootLoader = "systemd-boot";

  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = true;

  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  KeyboardOptions = "caps:escape";
  Locale = "en_US.UTF-8";
  TimeZone = "Asia/Singapore";

  MonitorSettings = "monitor = , highres, auto, 2";
  ScaleLevel = "2";

  Transparent-Proxy = false;
  QEMU-VM-Use-Case = true;

  WM = "Hyprland"; # [WIP] niri crash report: (wlogout:6119): Gdk-WARNING **: 15:55:39.572: Settings portal not found: Error calling StartServiceByName for org.freedesktop.portal.Desktop: Timeout was reached
}
