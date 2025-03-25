{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix)
  WM;
in
with lib;
mkIf (WM == "sway")
{
  home.packages = with pkgs; [
    xorg.xprop
  ];
  wayland.windowManager.sway = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    xwayland.enable = true;
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
