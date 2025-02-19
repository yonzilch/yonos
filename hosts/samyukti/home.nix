{ hostname, lib, username, ... }:
with lib;
let
  inherit (import ../../hosts/${hostname}/env.nix) QEMU-VM-Use-Case;
in
{
  imports = lib.filesystem.listFilesRecursive ../../home;

  dconf.settings = mkIf QEMU-VM-Use-Case {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  home = {
    file = {
      ".config" = {
        force = true;
        recursive = true;
        source = ../../dotfiles/.config;
      };
      ".local" = {
        force = true;
        recursive = true;
        source = ../../dotfiles/.local;
      };
    };
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EDITOR = "nvim";
    };
    stateVersion = "25.05";
    username = "${username}";
  };

  programs.home-manager.enable = true;
}
