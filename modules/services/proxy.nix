{
  hostname,
  lib,
  ...
}: let
  inherit (import ../../hosts/${hostname}/env.nix) Proxy-Provider;
in
  with lib; {
    programs.throne = mkIf (Proxy-Provider == "throne") {
      enable = true;
      tunMode.enable = true;
    };
    services.daed = mkIf (Proxy-Provider == "daed") {
      enable = true;
    };
  }
