{ config, lib, ... }:

{
  config = lib.mkIf config.services.grafana.enable {
    services.grafana = {
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3000;
          domain = "192.168.1.100";
        };
      };

      provision = {
        enable = true;
        datasources.settings.datasources = [{
          name = "Loki";
          type = "loki";
          access = "proxy";
          url = "http://127.0.0.1:${
              toString
              config.services.loki.configuration.server.http_listen_port
            }";
        }];
      };
    };

    services.nginx = {
      enable = true;
      virtualHosts."_" = {
        locations."/" = {
          proxyPass =
            "http://${config.services.grafana.settings.server.http_addr}:${
              toString config.services.grafana.settings.server.http_port
            }";
          recommendedProxySettings = true;
          proxyWebsockets = true;
        };
      };
    };

    networking.firewall.allowedTCPPorts =
      [ config.services.grafana.settings.server.http_port ];
  };
}
