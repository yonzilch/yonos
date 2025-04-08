{
  hostname,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) WM;
in
  with lib;
    mkIf (WM == "niri")
    {
      home.packages = with pkgs; [
        niri
      ];
      systemd.user.targets.niri-session = {
        Unit = {
          After = "graphical-session-pre.target graphical-session.target";
          BindsTo = "graphical-session.target";
          Conflicts = "shutdown.target";
          DefaultDependencies = false;
          Description = "sway compositor session";
          Documentation = "man:systemd.special(7)";
          Wants = "graphical-session-pre.target";
        };
      };
      xdg.portal = {
        config = {
          common = {
            default = ["gtk"];
            "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
            "org.freedesktop.impl.portal.ScreenCast" = "gnome";
            "org.freedesktop.impl.portal.Screenshot" = "gnome";
          };
        };
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
      };
    }
