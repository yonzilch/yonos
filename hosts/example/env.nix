{
  Bluetooth = false; # see https://github.com/blueman-project/blueman

  BootLoader = "systemd-boot"; # Possible options: grub, grub-mirror, systemd-boot # see https://nixos.wiki/wiki/Bootloader https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=mirroredBoots

  GPU-AMD = false; # see https://nixos.wiki/wiki/AMD_GPU
  GPU-Nvidia = false; # see https://nixos.wiki/wiki/Nvidia
  GPU-Intel = false; # see https://nixos.wiki/wiki/Intel_Graphics

  KernelPackages = "linuxPackages_zen"; # see https://search.nixos.org/options?show=boot.kernelPackages https://www.nyx.chaotic.cx/#using-sched-ext-schedulers
  KeyboardLayout = "us"; # see https://en.wikipedia.org/wiki/Keyboard_layout
  Locale = "en_US.UTF-8"; # see https://docs.moodle.org/405/en/Table_of_locales
  TimeZone = "Asia/Singapore"; # see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

  MonitorSettings = "monitor = , preferred, auto, 1"; # see https://wiki.hyprland.org/Configuring/Monitors/
  ScaleLevel = "1"; # see https://wiki.hyprland.org/Configuring/XWayland/#hidpi-xwayland

  Transparent-Proxy = false; # see https://github.com/daeuniverse/daed
  QEMU-VM-Use-Case = false; # see https://github.com/qemu/qemu

  WM = "Hyprland"; # Possible options: Hyprland, niri
  ZFS-Use-Case = false; # see https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html
}
