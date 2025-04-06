{
  hostname,
  lib,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) QEMU-VM-Use-Case;
in
  with lib; {
    dconf.settings = mkMerge [
      {
        "org/nemo/preferences" = {
          "date-font-choice" = "no-mono";
          "date-format" = "iso";
          "default-folder-viewer" = "list-view";
          "show-hidden-files" = true;
        };
      }
      (mkIf QEMU-VM-Use-Case {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      })
    ];
  }
