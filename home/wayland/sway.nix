{
  hostname,
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/env.nix)
    OutputSettings
    ScaleLevel
    WM
    ;
in
  with lib;
    mkIf (WM == "sway")
    {
      home.packages = with pkgs; [
        sway
        xorg.xprop
      ];
      systemd.user.targets.sway-session = {
        Unit = {
          Description = "sway compositor session";
          Documentation = "man:systemd.special(7)";
          After = "graphical-session-pre.target graphical-session.target";
          BindsTo = "graphical-session.target";
          Conflicts = "shutdown.target";
          DefaultDependencies = false;
          Wants = "graphical-session-pre.target";
        };
      };
      xdg = {
        configFile."sway/config".text = concatStrings [
          ''
            ${OutputSettings}
            set $SCALE ${ScaleLevel}
            include $HOME/.config/sway/*
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
