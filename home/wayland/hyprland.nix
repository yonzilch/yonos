{
  hostname,
  lib,
  pkgs,
  ...
}:
let
  inherit (import ../../hosts/${hostname}/env.nix)
    GPU-Nvidia
    KeyboardLayout
    MonitorSettings
    ScaleLevel
    WM
    ;
in
with lib;
mkIf (WM == "Hyprland") {
  home.packages = with pkgs; [
    xprop
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = concatStrings [
      ''
        hl.monitor({${MonitorSettings}})
        hl.config({input = {kb_layout = "${KeyboardLayout}",}})
        hl.exec_cmd(
            "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c" ..
            " -set _XWAYLAND_GLOBAL_OUTPUT_SCALE " .. ${ScaleLevel}
        )
        require("hyprland.autostart")
        require("hyprland.basic")
        require("hyprland.bind")
      ''
    ];
    plugins = [ pkgs.hyprlandPlugins.hy3 ];
    settings.env = mkIf GPU-Nvidia [
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "LIBVA_DRIVER_NAME,nvidia"
      "NVD_BACKEND,direct"
      "WLR_NO_HARDWARE_CURSORS,1"
    ];
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
  };
  xdg.portal = {
    config.common.default = [ "gtk" ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
