{ config, hostname, lib, pkgs, ... }:
{
  networking = {
    firewall.enable = false;
    hostName = hostname;
      networkmanager = {
        dns = "systemd-resolved";
        enable = true;
      };
    timeServers = [
      "nts.netnod.se"
      "nts.time.nl"
    ];
  };
  services.resolved = {
    dnsovertls = "true";
    domains = [
      "dot.sb"
      "dns10.quad9.net"
    ];
    enable = true;
  };
}
