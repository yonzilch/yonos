{ config, hostname, inputs, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix)
    MonitorSettings
    ScaleLevel
    ;
in
with lib;
{
  home.packages = with pkgs; [
    hyprpaper
    hyprpolkitagent
    xorg.xprop
  ];
  programs.hyprlock = {
    enable = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];
    systemd.enable = true;
    xwayland.enable = true;
    extraConfig = concatStrings [
    ''
      ${MonitorSettings}
      $SCALE = ${ScaleLevel}
      source = ~/.config/hypr/hyprland-basic.conf
    ''
    ];
  };
}
