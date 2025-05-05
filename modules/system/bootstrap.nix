{
  config,
  hostname,
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/env.nix)
    BootLoader
    KernelPackages
    KeyboardLayout
    Locale
    StateVersion
    TimeZone
    ZFS-Use-Case
    ;
in
  with lib; {
    boot = {
      bcache.enable = false;
      consoleLogLevel = 2; # Only errors and warnings are displayed
      extraModprobeConfig = "blacklist mei mei_hdcp mei_me mei_pxp iTCO_wdt pstore sp5100_tco";
      extraModulePackages = [
        config.boot.kernelPackages.v4l2loopback # v4l2loopback is for OBS Virtual Cam Support
      ];
      initrd = {
        compressor = "zstd";
        compressorArgs = ["-T0" "-19" "--long"];
        systemd.enable = true;
        verbose = false;
      };
      kernel.sysctl = {
        "kernel.core_pattern" = "|/bin/false"; # Disable automatic core dumps
        "vm.max_map_count" = 2147483642; # Needed For Some Steam Games
      };
      kernelModules = ["v4l2loopback"]; # v4l2loopback is for OBS Virtual Cam Support
      kernelPackages = pkgs.${KernelPackages};
      kernelParams = ["audit=0" "console=tty1" "erst_disable" "nmi_watchdog=0" "noatime" "nowatchdog"];
      loader = {
        grub = mkIf (strings.hasInfix "grub" BootLoader) {
          configurationLimit = 50;
          device = "nodev";
          efiInstallAsRemovable = true;
          efiSupport = true;
          enable = true;
          mirroredBoots = mkIf (BootLoader == "grub-mirror") [
            {
              devices = ["nodev"];
              path = "/boot";
            }
            {
              devices = ["nodev"];
              path = "/boot-mirror";
            }
          ];
          theme = mkForce "${pkgs.minimal-grub-theme}";
          zfsSupport = ZFS-Use-Case;
        };
        systemd-boot = mkIf (BootLoader == "systemd-boot") {
          configurationLimit = 50;
          editor = false;
          enable = true;
        };
        timeout = 3;
      };
      tmp.cleanOnBoot = true;
    };

    console = {
      earlySetup = true;
      keyMap = KeyboardLayout;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    i18n = {
      defaultLocale = Locale;
      extraLocaleSettings = {
        LC_ADDRESS = Locale;
        LC_IDENTIFICATION = Locale;
        LC_MEASUREMENT = Locale;
        LC_MONETARY = Locale;
        LC_NAME = Locale;
        LC_NUMERIC = Locale;
        LC_PAPER = Locale;
        LC_TELEPHONE = Locale;
        LC_TIME = Locale;
      };
    };

    networking = {
      dhcpcd.extraConfig = "nohook resolv.conf";
      firewall.enable = false;
      hostName = hostname;
      nameservers = ["127.0.0.1" "::1"];
      networkmanager = {
        dns = "none";
        enable = true;
      };
      resolvconf.enable = mkForce false;
    };

    security = {
      rtkit.enable = true;
      sudo.enable = false;
      sudo-rs = {
        enable = true;
        execWheelOnly = true;
      };
      pam.services = {
        hyprlock = {};
        login.kwallet.enable = mkForce false;
      };
      polkit = {
        enable = true;
        extraConfig = ''
          polkit.addRule(function(action, subject) {
            if (
              subject.isInGroup("users")
                && (
                  action.id == "org.freedesktop.login1.reboot" ||
                  action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                  action.id == "org.freedesktop.login1.power-off" ||
                  action.id == "org.freedesktop.login1.power-off-multiple-sessions"
                )
              )
            {
              return polkit.Result.YES;
            }
          })
        '';
      };
    };

    system = {
      rebuild.enableNg = true;
      stateVersion = StateVersion;
    };

    time = {
      hardwareClockInLocalTime = false;
      timeZone = TimeZone;
    };
  }
