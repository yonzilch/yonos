{ config, hostname, lib, pkgs, username, ... }:
let
  inherit (import ./env.nix) gitUsername gitEmail;
in
{
  imports = map (f: ./. + "/${f}")
      (builtins.filter
      (f: builtins.match ".*\.nix" f != null)
      (builtins.attrNames (builtins.readDir ../../home)));

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
}
