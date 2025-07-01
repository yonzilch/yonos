{
  hostname,
  lib,
  pkgs,
  ...
}:
let
  inherit (import ../../hosts/${hostname}/env.nix)
    GPU-Nvidia
    MonitorSettings
    KeyboardLayout
    ScaleLevel
    WM
    ;
in
with lib;
mkIf (WM == "Hyprland") {
  home.packages = with pkgs; [
    xorg.xprop
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
    extraConfig = concatStrings [
      ''
        ${MonitorSettings}
        $KEYBOARDLAYOUT = ${KeyboardLayout}
        $SCALE = ${ScaleLevel}
        source = ~/.config/hypr/hyprland/*
      ''
    ];
    settings = mkIf GPU-Nvidia {
      env = [
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "LIBVA_DRIVER_NAME,nvidia"
        "NVD_BACKEND,direct"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
    };
  };
  xdg.portal = {
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
