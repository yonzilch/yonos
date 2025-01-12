[WIP-LATER]
see https://github.com/catppuccin/gtk/blob/main/docs/USAGE.md#nix

{ config, lib, pkgs ... }:
{
  home.packages = with pkgs; [
    catppuchin-gtk
  ];

  home.qt = {
    enable = true;
    style = {
      name = "kvantum";
      package = libsForQt5.qtstyleplugin-kvantum;
    };
  };
}
