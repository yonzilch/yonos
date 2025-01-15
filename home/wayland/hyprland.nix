{ config, lib, pkgs, ... }:
with lib;
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
  };
}
