{
  hostname,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) GPU-Nvidia WM;
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        wmCmd =
          if WM == "Hyprland"
          then "start-hyprland"
          else if WM == "niri"
          then "niri-session"
          else if WM == "sway" && GPU-Nvidia
          then "sway --unsupported-gpu"
          else WM;
      in {
        command = "${pkgs.tuigreet}/bin/tuigreet -c \"${wmCmd}\" -t --user-menu";
        user = "greeter";
      };
    };
    useTextGreeter = true;
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
