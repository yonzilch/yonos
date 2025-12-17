{
  hostname,
  lib,
  ...
}:
with lib; let
  inherit (import ../../hosts/${hostname}/env.nix) DNS-Method;
in {
  environment.etc."resolv.conf" = mkIf (DNS-Method == "unbound") {
    mode = "0644";
    text = ''
      # Managed by unbound
      nameserver 127.0.0.1
      nameserver ::1
    '';
  };

  networking = {
    dhcpcd.extraConfig = "nohook resolv.conf";
    firewall.enable = false;
    hostName = hostname;
    nameservers = mkIf (DNS-Method == "unbound") [
      "127.0.0.1"
      "::1"
    ];
    networkmanager = {
      dns =
        if DNS-Method == "unbound"
        then "none"
        else "default";
      enable = true;
    };
    resolvconf.enable = DNS-Method != "unbound";
  };

  services.unbound = mkIf (DNS-Method == "unbound") {
    enable = true;
    settings = {
      server = {
        do-ip4 = true;
        do-ip6 = true;
        do-tcp = true;
        do-udp = true;
        hide-identity = true;
        hide-version = true;
        interface = [
          "127.0.0.1"
          "::1"
        ];
        num-threads = 2;
        prefetch = true;
        qname-minimisation = true;
        use-syslog = true;
        verbosity = 1;
      };
      forward-zone = [
        {
          forward-addr = [
            # CloudFlare servers
            "1.1.1.1@853#cloudflare-dns.com"
            "1.0.0.1@853#cloudflare-dns.com"
            "2606:4700:4700::1111@853#cloudflare-dns.com"
            "2606:4700:4700::1001@853#cloudflare-dns.com"

            # dns.sb servers
            "185.222.222.222@853#dot.sb"
            "45.11.45.11@853#dot.sb"
            "2a09::@853#dot.sb"
            "2a11::@853#dot.sb"

            # Quad9 servers
            "9.9.9.9@853#dns.quad9.net"
            "149.112.112.112@853#dns.quad9.net"
            "2620:fe::fe@853#dns.quad9.net"
            "2620:fe::9@853#dns.quad9.net"
          ];
          forward-tls-upstream = true;
          name = ".";
        }
      ];
    };
  };
}
