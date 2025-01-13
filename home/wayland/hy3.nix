{ config, lib, pkgs, ... }:
with lib;
{
  wayland.windowManager.plugins = {
    pkgs.hyprlandPlugins.hy3
  };
}
