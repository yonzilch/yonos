{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix) WM;
in
with lib;
mkIf (WM == "niri")
{
  home.packages = with pkgs; [
    nautilus
    niri
  ];
  xdg.portal = {
    configPackages = [
      pkgs.gnome.gnome-session
    ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome ];
  };
}
