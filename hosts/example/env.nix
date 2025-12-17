# ============================================================================
# env.nix - Host-Specific Environment Configuration
# ============================================================================
#
# This file contains all host-specific configuration options for NixOS.
# Each host should have its own env.nix file in hosts/${hostname}/ directory.
#
# Purpose:
#   - Centralize hardware and software configuration options
#   - Enable/disable features based on specific use cases
#   - Configure system-level settings (bootloader, kernel, locale, etc.)
#   - Manage Wayland/display settings
#
# Usage:
#   This file is imported by other configuration modules to determine
#   which features to enable and how to configure the system.
#
# ============================================================================
{
  # ============================================================================
  # Specific Use Cases
  # ============================================================================

  ## Hardware Related
  # ----------------------------------------------------------------------------

  # Bluetooth support
  # See: https://github.com/blueman-project/blueman
  Bluetooth = false;

  # AMD GPU support
  # See: https://nixos.wiki/wiki/AMD_GPU
  GPU-AMD = false;

  # Nvidia GPU support
  # See: https://nixos.wiki/wiki/Nvidia
  GPU-Nvidia = false;

  # Intel GPU support
  # See: https://nixos.wiki/wiki/Intel_Graphics
  GPU-Intel = false;

  # Internet hotspot/connection sharing
  # See: https://nixos.wiki/wiki/Internet_Connection_Sharing
  HotSpot-Use-Case = false;

  # ZFS filesystem support
  # See: https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html
  ZFS-Use-Case = false;

  # ZFS networking host ID (required if ZFS-Use-Case = true)
  # Generate with: head -c4 /dev/urandom | od -A none -t x4
  # See: https://search.nixos.org/options?show=networking.hostId
  ZFS-Networking-HostID = "";

  ## Software Related
  # ----------------------------------------------------------------------------

  # QEMU/KVM virtualization support
  # See: https://github.com/qemu/qemu
  # See: https://github.com/virt-manager/virt-manager
  QEMU-VM-Use-Case = false;

  # Transparent proxy (daed)
  # See: https://github.com/daeuniverse/daed
  Transparent-Proxy = false;

  # ============================================================================
  # System Options
  # ============================================================================

  ## Bootloader Configuration
  # ----------------------------------------------------------------------------
  # Options: "grub" | "grub-mirror" | "limine" | "systemd-boot"
  # See: https://nixos.wiki/wiki/Bootloader
  # See: https://search.nixos.org/options?show=boot.loader.grub.mirroredBoots
  BootLoader = "systemd-boot";

  ## DNS Configuration
  # ----------------------------------------------------------------------------
  # Options: "NetworkManager" | "unbound"
  #
  # NetworkManager (default):
  #   - DNS lookup follows upstream network configuration
  #   - Simple and automatic, works out of the box
  #   - Uses DNS servers provided by DHCP/network
  #
  # unbound:
  #   - Enables DNS over TLS (DoT) to encrypt DNS traffic
  #   - Local caching DNS resolver for better privacy and performance
  #   - See: https://nixos.wiki/wiki/Encrypted_DNS
  #   - See: https://unbound.docs.nlnetlabs.nl/en/latest/getting-started/configuration.html
  DNS-Method = "NetworkManager";

  ## Kernel Configuration
  # ----------------------------------------------------------------------------
  # Recommended: "linuxPackages_cachyos"
  # See: https://search.nixos.org/options?show=boot.kernelPackages
  # See: https://www.nyx.chaotic.cx/#using-sched-ext-schedulers
  KernelPackages = "linuxPackages_zen";

  ## Localization
  # ----------------------------------------------------------------------------
  # Keyboard layout
  # See: https://en.wikipedia.org/wiki/Keyboard_layout
  KeyboardLayout = "us";

  # System locale
  # See: https://docs.moodle.org/405/en/Table_of_locales
  Locale = "en_US.UTF-8";

  # Time zone
  # See: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  TimeZone = "Asia/Singapore";

  ## Time Synchronization
  # ----------------------------------------------------------------------------
  # Options: "NTS" | "Plain"
  # NTS: Network Time Security (encrypted)
  # Plain: Standard NTP (unencrypted)
  # See: https://en.wikipedia.org/wiki/Network_Time_Protocol
  # See: https://github.com/pendulum-project/ntpd-rs
  TimeSync-Method = "Plain";

  ## System Version
  # ----------------------------------------------------------------------------
  # NixOS state version - DO NOT CHANGE after initial installation
  # See: https://mynixos.com/nixpkgs/option/system.stateVersion
  StateVersion = "25.11";

  # ============================================================================
  # Wayland/Display Options
  # ============================================================================

  ## Window Manager
  # ----------------------------------------------------------------------------
  # Options: "Hyprland" | "niri" | "sway"
  WM = "sway";

  ## Display Configuration
  # ----------------------------------------------------------------------------
  # Monitor settings for Hyprland
  # See: https://wiki.hyprland.org/Configuring/Monitors
  MonitorSettings = "monitor = , preferred, auto, auto";

  # Output settings for sway
  # See: https://github.com/swaywm/sway/wiki#display-configuration
  OutputSettings = "output * scale 2";

  # HiDPI scale level
  # For Hyprland: https://wiki.hyprland.org/Configuring/XWayland/#hidpi-xwayland
  # For sway: https://github.com/swaywm/sway/wiki#hidpi
  ScaleLevel = "2";
}
