{ pkgs, ... }:
{
  services = {
    stubby = {
      enable = true;
      settings = pkgs.stubby.passthru.settingsExample // {
        resolution_type = "GETDNS_RESOLUTION_STUB";
        dns_transport_list = ["GETDNS_TRANSPORT_TLS"];
        tls_authentication = "GETDNS_AUTHENTICATION_REQUIRED";
        tls_query_padding_blocksize = 256;
        edns_client_subnet_private = 1;
        idle_timeout = 10000;
        listen_addresses = ["127.0.0.1" "0::1"];
        round_robin_upstreams = 1;
        upstream_recursive_servers = [
          {
            address_data = "185.222.222.222";
            tls_auth_name = "dot.sb";
          }
          {
            address_data = "45.11.45.11";
            tls_auth_name = "dot.sb";
          }
          {
            address_data = "2a09::";
            tls_auth_name = "dot.sb";
          }
          {
            address_data = "2a11::";
            tls_auth_name = "dot.sb";
          }
          {
            address_data = "9.9.9.9";
            tls_auth_name = "dns.quad9.net";
          }
          {
            address_data = "149.112.112.112";
            tls_auth_name = "dns.quad9.net";
          }
          {
            address_data = "2620:fe::fe";
            tls_auth_name = "dns.quad9.net";
          }
          {
            address_data = "2620:fe::9";
            tls_auth_name = "dns.quad9.net";
          }
        ];
      };
    };
  };
}
