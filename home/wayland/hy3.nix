{ config, lib, pkgs, ... }:
with lib;
{
  wayland.windowManager.hyprland.plugins = [
    pkgs.hyprlandPlugins.hy3
  ];
}
