{
  hostname,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) GPU-Nvidia WM;
in {
  services = {
    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          user = "greeter";
          command =
            if WM == "niri"
            then "${pkgs.tuigreet}/bin/tuigreet -c niri-session -t --user-menu"
            else if WM == "sway" && GPU-Nvidia
            then "${pkgs.tuigreet}/bin/tuigreet -c \"sway --unsupported-gpu\" -t --user-menu"
            else "${pkgs.tuigreet}/bin/tuigreet -c ${WM} -t --user-menu";
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
