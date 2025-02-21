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
      Documentation = [ "man:systemd.special(7)" ];
    };
    Target = {
      After = "graphical-session-pre.target";
      Before = "xdg-desktop-autostart.target";
      BindsTo = "graphical-session.target";
      Wants = [
        "graphical-session-pre.target"
      ];
      DefaultDependencies = false;
    };
  };
  home.packages = with pkgs; [
    nautilus
    niri
  ];
  xdg.portal = {
    configPackages = [
      pkgs.gnome-session
    ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
