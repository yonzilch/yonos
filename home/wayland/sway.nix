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
      systemd.user.targets.sway-session = {
        Target = {
          After = "graphical-session-pre.target";
          BindsTo = "graphical-session.target";
          DefaultDependencies = false;
          Wants = "graphical-session-pre.target";
        };
        Unit = {
          Description = "sway compositor session";
          Documentation = "man:systemd.special(7)";
        };
      };
    }
