{
  hostname,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/env.nix) QEMU-VM-Use-Case;
in
  with lib;
    mkIf QEMU-VM-Use-Case {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };

      home.packages = with pkgs; [
        virt-manager
      ];
    }
