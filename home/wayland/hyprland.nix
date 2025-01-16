{ config, lib, pkgs, ... }:
with lib;
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];
    systemd.enable = false;
    xwayland.enable = true;
  };
}
