{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix)
    MonitorSettings GPU-Nvidia KeyboardLayout ScaleLevel WM;
in
with lib;
mkIf (WM == "Hyprland")
{
  home.packages = with pkgs; [
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
      $KEYBOARDLAYOUT = ${KeyboardLayout}
      $SCALE = ${ScaleLevel}
      source = ~/.config/hypr/hyprland-basic.conf
    ''
    ];
    settings = mkIf GPU-Nvidia {
      env = [
        # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "AQ_DRM_DEVICES,/dev/dri/card1"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # fix https://github.com/hyprwm/Hyprland/issues/1520
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
    };
  };
}
