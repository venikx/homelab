{ config, lib, ... }:

{
  config = lib.mkIf config.services.grafana.enable {
    services.grafana.settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        domain = "192.168.1.101";
      };
    };

    services.nginx = {
      enable = true;
      virtualHosts."_" = {
        locations."/" = { proxyPass = "http://localhost:3000"; };
      };
    };

    networking.firewall.allowedTCPPorts =
      [ config.services.grafana.settings.server.http_port ];
  };
}
