{ config, hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix) Locale TimeZone;
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
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [ "audit=0" "console=tty0" "erst_disable" "nmi_watchdog=0" "noatime" "nowatchdog" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 50;
        editor = false;
        enable = true;
      };
      timeout = 3;
    };
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback # v4l2loopback is for OBS Virtual Cam Support
    ];
    tmp.cleanOnBoot = true;
  };

  console.keyMap = "us";

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
      "nts.netnod.se"
      "nts.time.nl"
    ];
  };

  security = {
    rtkit.enable = true;
    pam.services.login.kwallet.enable = lib.mkForce false;
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

  services = {
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c Hyprland -t --user-menu";
          user = "greeter";
        };
      };
      vt = 1;
    };
    gvfs.enable = true;
    libinput.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
    stubby = {
      enable = true;
      settings = pkgs.stubby.passthru.settingsExample // {
        resolution_type = "GETDNS_RESOLUTION_STUB";
        dns_transport_list = ["GETDNS_TRANSPORT_TLS"];
        tls_authentication = "GETDNS_AUTHENTICATION_REQUIRED";
        tls_query_padding_blocksize = 256;
        edns_client_subnet_private = 1;
        idle_timeout = 10000;
        listen_addresses = ["127.0.0.1" "0::1"];
        round_robin_upstreams = 1;
        upstream_recursive_servers = [{
          address_data = "185.222.222.222";
          tls_auth_name = "dot.sb";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "amEjS6OJ74LvhMNJBxN3HXxOMSWAriaFoyMQn/Nb5FU=";
          }];
        } {
          address_data = "45.11.45.11";
          tls_auth_name = "dot.sb";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "amEjS6OJ74LvhMNJBxN3HXxOMSWAriaFoyMQn/Nb5FU=";
          }];
        } {
          address_data = "2a09::";
          tls_auth_name = "dot.sb";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "amEjS6OJ74LvhMNJBxN3HXxOMSWAriaFoyMQn/Nb5FU=";
          }];
        } {
          address_data = "2a11::";
          tls_auth_name = "dot.sb";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "amEjS6OJ74LvhMNJBxN3HXxOMSWAriaFoyMQn/Nb5FU=";
          }];
        }];
      };
    };
  };

  system = {
    rebuild.enableNg = true;
    stateVersion = "25.05";
  };

  systemd = {
    user.services.mate-polkit = {
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
  };

  time = {
    hardwareClockInLocalTime = false;
    timeZone = TimeZone;
  };

  xdg = {
    autostart.enable = lib.mkForce false;
    terminal-exec.enable = lib.mkDefault true;
  };
}
