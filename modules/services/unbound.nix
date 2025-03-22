_: {
  services = {
    unbound = {
      enable = true;
      settings = {
        server = {
          interface = ["127.0.0.1" "::1"];
          verbosity = 1;
          use-syslog = "yes";
          do-ip4 = "yes";
          do-ip6 = "yes";
          do-udp = "yes";
          do-tcp = "yes";

          # Privacy-related settings
          qname-minimisation = "yes";
          hide-identity = "yes";
          hide-version = "yes";

          # Performance settings
          prefetch = "yes";
          num-threads = 2;
        };

        forward-zone = [
          {
            name = ".";
            forward-tls-upstream = "yes";
            # dot.sb servers
            forward-addr = [
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
          }
        ];

        # Remote control configuration (optional)
        remote-control = {
          control-enable = "yes";
          control-interface = "127.0.0.1";
        };
      };
    };
  };
}
