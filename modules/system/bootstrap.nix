{ config, hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix)
  BootLoader KernelPackages KeyboardLayout Locale TimeZone;
in
{
  boot = {
    bcache.enable = false;
    consoleLogLevel = 2; # Only errors and warnings are displayed
    extraModprobeConfig = "blacklist mei mei_hdcp mei_me mei_pxp iTCO_wdt pstore sp5100_tco";
    initrd = {
      compressor = "zstd";
      compressorArgs = [ "-T0" "-19" "--long" ];
      systemd = {
        enable = true;
        network.wait-online.enable = false;
      };
      verbose = false;
    };
    kernel.sysctl = {
      "kernel.core_pattern" = "|/bin/false"; # Disable automatic core dumps
      "vm.max_map_count" = 2147483642; # Needed For Some Steam Games
    };
    kernelModules = [ "v4l2loopback" ];# v4l2loopback is for OBS Virtual Cam Support
    kernelPackages = pkgs.${KernelPackages};
    kernelParams = [ "audit=0" "console=tty0" "erst_disable" "nmi_watchdog=0" "noatime" "nowatchdog" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = lib.mkIf (BootLoader == "systemd-boot") {
        configurationLimit = 50;
        editor = false;
        enable = true;
      };
      grub = lib.mkIf (BootLoader == "grub") {
        configurationLimit = 50;
        device = "nodev";
        enable = true;
      };
      timeout = 3;
    };
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback # v4l2loopback is for OBS Virtual Cam Support
    ];
    tmp.cleanOnBoot = true;
  };

  console.keyMap = KeyboardLayout;

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
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager = {
      dns = "none";
      enable = true;
    };
    resolvconf.enable = lib.mkForce false;
    timeServers = [
      "ntppool1.time.nl"
      "ntppool2.time.nl"
      "ntp.ripe.net"
    ];
  };

  security = {
    rtkit.enable = true;
    pam.services = {
      hyprlock = {};
      login.kwallet.enable = lib.mkForce false;
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
    stateVersion = config.system.nixos.release;
  };

  systemd.user.services.mate-polkit = {
    description = "mate-polkit-agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  time = {
    hardwareClockInLocalTime = false;
    timeZone = TimeZone;
  };
}
