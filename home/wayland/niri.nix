{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix) WM;
in
with lib;
mkIf (WM == "niri")
{
  systemd.user.targets.niri-session = {
    Unit = {
      Description = "niri compositor session";
      Documentation = "man:systemd.special(7)";
    };
    Target = {
      After = "graphical-session-pre.target";
      BindsTo = "graphical-session.target";
      Wants = "graphical-session-pre.target";
      DefaultDependencies = false;
    };
  };
  home.packages = with pkgs; [
    niri
  ];
  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
