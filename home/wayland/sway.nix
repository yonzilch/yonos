{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix)
  OutputSettings ScaleLevel WM;
in
with lib;
mkIf (WM == "sway")
{
  home.packages = with pkgs; [
    xorg.xprop
  ];
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraConfig = concatStrings [
    ''
      ${OutputSettings}
      include $HOME/.config/sway/swaywm/*
      set $SCALE ${ScaleLevel}
    ''
    ];
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    xwayland = true;
  };
  xdg.portal = {
    config = {
      common = {
        default = ["gtk"];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}
