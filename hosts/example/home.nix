{ config, hostname, lib, pkgs, username, ... }:
let
  inherit (import ./env.nix) gitUsername gitEmail;
in
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

  programs = {
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
    };
    home-manager.enable = true;
  };

  stylix.targets = {
    hyprland.enable = false;
    rofi.enable = false;
    waybar.enable = false;
  };
}
