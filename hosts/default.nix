{ hostname, lib, username, ... }:
let
  inherit (import ./${hostname}/env.nix) StateVersion;
in
{
  imports = lib.filesystem.listFilesRecursive ../home;

  home = {
    file = {
      ".config" = {
        force = true;
        recursive = true;
        source = ../dotfiles/.config;
      };
      ".local" = {
        force = true;
        recursive = true;
        source = ../dotfiles/.local;
      };
    };
    homeDirectory = "/home/${username}";
    stateVersion = StateVersion;
    username = "${username}";
  };

  programs.home-manager.enable = true;
}
