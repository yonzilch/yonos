_: {
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
        forward-zone = [
          {
            forward-addr = [
              # dns.sb servers
              "185.222.222.222@853#dot.sb"
              "45.11.45.11@853#dot.sb"
              "2a09::@853#dot.sb"
              "2a11::@853#dot.sb"

              # quad9 servers
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
  };
}
