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
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "audit=0" "console=tty0" "noatime" ];
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
    plymouth.enable = lib.mkDefault true;
  };

  console.keyMap = "us";

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk
      material-icons
    ];
  };

  hardware.graphics = {
    enable = true;
  };

  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        };
      };
    };
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    libinput.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
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

}
