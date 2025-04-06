{
  hostname,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) GPU-AMD;
in
  with lib; {
    config = mkIf GPU-AMD {
      systemd.tmpfiles.rules = ["L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"];
      services.xserver.videoDrivers = ["amdgpu"];
    };
  }
