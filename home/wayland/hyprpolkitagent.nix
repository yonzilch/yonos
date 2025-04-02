{ pkgs, ... }:
{
  # services.hyprpolkitagent.enable = true;
  systemd.user.services.hyprpolkitagent = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Unit = {
      After = "graphical-session.target";
      Description = "Hyprland PolicyKit Agent";
      Wants = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
      Type = "simple";
    };
  };
}
