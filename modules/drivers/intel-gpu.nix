{
  hostname,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) GPU-Intel;
in
  with lib; {
    config = mkIf GPU-Intel {
      nixpkgs.config.packageOverrides = pkgs: {
        intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
      };

      # OpenGL
      hardware.graphics = {
        extraPackages = with pkgs; [
          intel-media-driver
          intel-vaapi-driver
          libvdpau-va-gl
          libva-vdpau-driver
          vpl-gpu-rt
        ];
      };
    };
  }
