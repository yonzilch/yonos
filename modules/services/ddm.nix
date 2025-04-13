{
  hostname,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) WM;
in {
  services = {
    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = "greeter";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c ${WM} -t --user-menu";
        };
      };
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
