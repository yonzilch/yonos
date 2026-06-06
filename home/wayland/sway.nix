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
    mkIf (WM == "sway") {
      home.packages = with pkgs; [
        sway
        xprop
      ];
      systemd.user.targets.sway-session = {
        Unit = {
          After = "graphical-session-pre.target graphical-session.target";
          BindsTo = "graphical-session.target";
          Conflicts = "shutdown.target";
          DefaultDependencies = false;
          Description = "${WM} compositor session";
          Documentation = "man:systemd.special(7)";
          Wants = "graphical-session-pre.target";
        };
      };
      xdg = {
        configFile."sway/config".text = concatStrings [
          ''
            ${OutputSettings}
            exec_always xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE ${ScaleLevel}
            include $HOME/.config/sway/*
          ''
        ];
        portal = {
          config.common.default = ["gtk"];
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-wlr
          ];
        };
      };
    }
