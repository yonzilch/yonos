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
    checkConfig = false;
    enable = true;
    extraOptions = [
      "--unsupported-gpu"
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
  xdg = {
    configFile.".config/sway/config".text = concatStrings [
      ''
        ${OutputSettings}
        set $SCALE ${ScaleLevel}
        include $HOME/.config/sway/swaywm/*
      ''
    ];
    portal = {
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
  };
}
