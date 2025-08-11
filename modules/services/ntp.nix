{
  hostname,
  lib,
  ...
}:
with lib; let
  inherit (import ../../hosts/${hostname}/env.nix) TimeSync-Method;
in {
  services.ntpd-rs = {
    enable = true;
    settings = {
      source =
        (optionals (TimeSync-Method == "NTS") [
          {
            address = "ntppool1.time.nl";
            mode = "nts";
          }
          {
            address = "ntppool2.time.nl";
            mode = "nts";
          }
          {
            address = "nts.netnod.se";
            mode = "nts";
          }
        ])
        ++ (optionals (TimeSync-Method == "Plain") [
          {
            address = "ntp.time.nl";
            mode = "server";
          }
          {
            address = "ntp.netnod.se";
            mode = "server";
          }
          {
            address = "time.cloudflare.com";
            mode = "server";
          }
        ]);
    };
    useNetworkingTimeServers = false;
  };
}
