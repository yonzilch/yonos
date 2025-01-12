{ config, lib, pkgs, ... }:
with lib;
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };
}
