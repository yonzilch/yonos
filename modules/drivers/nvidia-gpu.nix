{
  config,
  hostname,
  lib,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) GPU-Nvidia;
in
  with lib; {
    config = mkIf GPU-Nvidia {
      # Because of unfree NVIDIA drivers, make nixpkgs allowUnfree.
      nixpkgs.config.allowUnfree = mkForce true;
      hardware.nvidia-container-toolkit.enable = true;
      hardware.nvidia = {
        # Modesetting is required.
        modesetting.enable = true;
        # Accessible via `nvidia-settings`.
        nvidiaSettings = true;
        # Nvidia power management. Experimental, and may cause sleep/suspend to fail.
        powerManagement.enable = true;
        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;
        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = false;
        # Enable the Nvidia settings menu,
        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };
      services.xserver.videoDrivers = ["nvidia"];
    };
  }
