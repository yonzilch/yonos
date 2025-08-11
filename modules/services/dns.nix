{
  hostname,
  lib,
  ...
}:
with lib; let
  inherit (import ../../hosts/${hostname}/env.nix) DNS-Method;
in {
  services = {
    unbound = {
      enable = true;
      settings = {
        server = {
          do-ip4 = true;
          do-ip6 = true;
          do-tcp = true;
          do-udp = true;
          hide-identity = true;
          hide-version = true;
          interface = ["127.0.0.1" "::1"];
          num-threads = 2;
          prefetch = true;
          qname-minimisation = true;
          use-syslog = true;
          verbosity = 1;
        };

        forward-zone =
          (optionals (DNS-Method == "DoT") [
            {
              forward-addr = [
                # dns.sb servers
                "185.222.222.222@853#dot.sb"
                "45.11.45.11@853#dot.sb"
                "2a09::@853#dot.sb"
                "2a11::@853#dot.sb"

                # quad9 servers
                "9.9.9.10@853#dns.quad9.net"
                "149.112.112.10@853#dns.quad9.net"
                "2620:fe::10@853#dns.quad9.net"
                "2620:fe::fe:10@853#dns.quad9.net"

                # cloudflare servers
                "1.1.1.1@853#cloudflare-dns.com"
                "1.0.0.1@853#cloudflare-dns.com"
                "2606:4700:4700::1111@853#cloudflare-dns.com"
                "2606:4700:4700::1001@853#cloudflare-dns.com"
              ];
              forward-tls-upstream = true;
              name = ".";
            }
          ])
          ++ (optionals (DNS-Method == "Plain") [
            {
              forward-addr = [
                # dns.sb servers
                "185.222.222.222"
                "45.11.45.11"
                "2a09::"
                "2a11::"

                # quad9 servers
                "9.9.9.9"
                "149.112.112.112"
                "2620:fe::fe"
                "2620:fe::9"

                # cloudflare servers
                "1.1.1.1"
                "1.0.0.1"
                "2606:4700:4700::1111"
                "2606:4700:4700::1001"
              ];
              name = ".";
            }
          ]);
      };
    };
  };
}
