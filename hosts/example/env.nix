{
  # Specific Use Cases
  ## Hardware related

  ### See https://github.com/blueman-project/blueman
  Bluetooth = false;
  ### See https://nixos.wiki/wiki/AMD_GPU
  GPU-AMD = false;
  ### See https://nixos.wiki/wiki/Nvidia
  GPU-Nvidia = false;
  ### See https://nixos.wiki/wiki/Intel_Graphics
  GPU-Intel = false;
  ### See https://nixos.wiki/wiki/Internet_Connection_Sharing
  HotSpot-Use-Case = false;
  ### See https://search.nixos.org/options?channel=unstable&show=networking.hostId&from=0&size=30&sort=relevance&query=networking.hostId
  ### Could be generated by `head -c4 /dev/urandom | od -A none -t x4`
  ZFS-Networking-HostID = "";
  ### See https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html
  ZFS-Use-Case = false;

  ## Software related
  ### See https://github.com/qemu/qemu
  QEMU-VM-Use-Case = false;
  ### See https://github.com/daeuniverse/daed
  Transparent-Proxy = false;

  # Options
  ## System related
  ### Possible options: grub, grub-mirror, systemd-boot # See https://nixos.wiki/wiki/Bootloader https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=mirroredBoots
  BootLoader = "systemd-boot";
  ### See https://search.nixos.org/options?show=boot.kernelPackages https://www.nyx.chaotic.cx/#using-sched-ext-schedulers
  KernelPackages = "linuxPackages_zen";
  ### See https://en.wikipedia.org/wiki/Keyboard_layout
  KeyboardLayout = "us";
  ### See https://docs.moodle.org/405/en/Table_of_locales
  Locale = "en_US.UTF-8";
  ### See https://mynixos.com/nixpkgs/option/system.stateVersion
  StateVersion = "25.05";
  ### See https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  TimeZone = "Asia/Singapore";

  ## Wayland related
  ### MonitorSettings For Hyprland See https://wiki.hyprland.org/Configuring/Monitors/
  MonitorSettings = "monitor = , preferred, auto, 1";
  ### OutputSettings For sway See https://github.com/swaywm/sway/wiki#display-configuration
  OutputSettings = "output * scale 1";

  ### For Hyprland see https://wiki.hyprland.org/Configuring/XWayland/#hidpi-xwayland
  ### For sway see https://github.com/swaywm/sway/wiki#hidpi
  ScaleLevel = "1";

  ### Possible options: Hyprland, niri, sway
  WM = "Hyprland";
}
