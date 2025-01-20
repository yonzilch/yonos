{ config, lib, pkgs, username, ... }:
{
  boot = {
    consoleLogLevel = 2; # Only errors and warnings are displayed
    initrd = {
      compressor = "zstd";
      compressorArgs = [ "-T0" "-19" "--long" ];
      systemd.enable = true;
      verbose = false;
    };
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642; # Needed For Some Steam Games
    };
    kernelModules = [ "v4l2loopback" ];# v4l2loopback is for OBS Virtual Cam Support
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [ "audit=0" "console=tty0" "erst_disable" "noatime" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        configurationLimit = 10;
        device = "nodev"; # "nodev" for efi only
        enable = true;
        efiSupport = true;
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Poweroff" {
            halt
          }
        '';
      };
    };
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback # v4l2loopback is for OBS Virtual Cam Support
    ];
  };

  console.keyMap = "us";

  hardware.graphics = {
    enable = true;
  };

  programs = {
    fuse.userAllowOther = true;
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = username;
        };
      };
      vt = 1;
    };
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
    timesyncd.enable = false;
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

     # NFS Support
#    rpcbind.enable = false;
#    nfs.server.enable = false;
  };

  security = {
    rtkit.enable = true;
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
  system.stateVersion = "25.05";

#  turn off swap by default
#  swapDevices = [{ device = "/swapfile"; size = 4096; }];

  xdg = {
    autostart.enable = lib.mkForce false;
    terminal-exec.enable = lib.mkDefault true;
  };
}
