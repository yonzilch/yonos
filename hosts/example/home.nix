{ lib, username, ... }:
{
  imports = lib.filesystem.listFilesRecursive ../../home;

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
    stateVersion = "25.05";
    username = "${username}";
  };

  programs.home-manager.enable = true;
}
