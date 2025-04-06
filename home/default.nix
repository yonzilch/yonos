{
  hostname,
  lib,
  username,
  ...
}: let
  inherit (import ../hosts/${hostname}/env.nix) StateVersion;
  ls = lib.filesystem.listFilesRecursive;
in {
  imports =
    ls ./cli
    ++ ls ./gui
    ++ ls ./tui
    ++ ls ./wayland;

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
