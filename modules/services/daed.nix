{
  hostname,
  lib,
  ...
}:
with lib; let
  inherit (import ../../hosts/${hostname}/env.nix) Transparent-Proxy;
in {
  config = mkIf Transparent-Proxy {
    services.daed = {
      enable = true;
    };
  };
}
