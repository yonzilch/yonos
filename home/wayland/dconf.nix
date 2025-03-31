{ hostname, lib, ... }:
with lib;
let
  inherit (import ../../hosts/${hostname}/env.nix) QEMU-VM-Use-Case;
in
{
  dconf.settings = mkMerge [
    {
      "org/nemo/preferences" = {
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
