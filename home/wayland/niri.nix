{ hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix) WM;
in
with lib;
mkIf (WM == "niri")
{
  home.packages = with pkgs; [
    niri
  ];
  xdg.portal = {
    config = {
      common = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
  systemd.user.targets.niri-session = {
    Target = {
      After = "graphical-session-pre.target";
      BindsTo = "graphical-session.target";
      DefaultDependencies = false;
      Wants = "graphical-session-pre.target";
    };
    Unit = {
      Description = "niri compositor session";
      Documentation = "man:systemd.special(7)";
    };
  };
  systemd.user.services.xdg-desktop-portal-gnome = {
    Unit = {
      Description = "Portal service (GNOME implementation)";
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.impl.portal.desktop.gnome";
      ExecStart = "${pkgs.xdg-desktop-portal-gnome}/libexec/xdg-desktop-portal-gnome";
    };
  };
}
