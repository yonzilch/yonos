{
  # Specific Use Cases
  ## Hardware related

  ### See https://github.com/blueman-project/blueman
  Bluetooth = true;
  ### See https://nixos.wiki/wiki/AMD_GPU
  GPU-AMD = false;
  ### See https://nixos.wiki/wiki/Nvidia
  GPU-Nvidia = false;
  ### See https://nixos.wiki/wiki/Intel_Graphics
  GPU-Intel = false;
  ### See https://nixos.wiki/wiki/Power_Management https://nixos.wiki/wiki/Laptop
  Power-Implement = true;
  ### See https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html
  ZFS-Use-Case = true;

  ## Software related
  ### See https://github.com/qemu/qemu
  QEMU-VM-Use-Case = true;
  ### See https://github.com/daeuniverse/daed
  Transparent-Proxy = false;


  # Options
  ## Basic

  ### Possible options: grub, grub-mirror, systemd-boot # See https://nixos.wiki/wiki/Bootloader https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=mirroredBoots
  BootLoader = "grub-mirror";

  ### See https://search.nixos.org/options?show=boot.kernelPackages https://www.nyx.chaotic.cx/#using-sched-ext-schedulers
  KernelPackages = "linuxPackages_cachyos";
  ### See https://en.wikipedia.org/wiki/Keyboard_layout
  KeyboardLayout = "us";
  ### See https://docs.moodle.org/405/en/Table_of_locales
  Locale = "en_US.UTF-8";
  ### See https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  TimeZone = "Asia/Singapore";

  ## Wayland related
  ### See https://wiki.hyprland.org/Configuring/Monitors/
  MonitorSettings = "monitor = , 2560x1600@165, auto, 1.6";
  ### See https://wiki.hyprland.org/Configuring/XWayland/#hidpi-xwayland
  ScaleLevel = "1.6";
  ### Possible options: Hyprland, niri
  WM = "Hyprland";
}
