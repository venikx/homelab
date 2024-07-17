{ config, lib, ... }:

{
  services.loki = {
    configuration = {
      server.http_listen_port = 9101;
      auth_enabled = false;

      common = {
        ring = {
          instance_addr = "127.0.0.1";
          kvstore = { store = "inmemory"; };

        };
        replication_factor = 1;
        path_prefix = "/tmp/loki";
      };

      schema_config = {
        configs = [{
          from = "2024-04-01";
          store = "tsdb";
          object_store = "filesystem";
          schema = "v13";
          index = {
            prefix = "index_";
            period = "24h";
          };
        }];
      };

      storage_config = {
        filesystem = { directory = "/var/lib/loki/chunks"; };
      };
    };
  };

  # NOTE(Kevin): By default use promtail on the instance which runs the
  # loki service to enable self monitoring the logs
  services.promtail.enable = lib.mkDefault config.services.loki.enable;

  services.grafana.provision.enable = true;
  services.grafana.provision.datasources.settings.datasources = [{
    name = "Loki";
    type = "loki";
    access = "proxy";
    url = "http://127.0.0.1:${
        toString config.services.loki.configuration.server.http_listen_port
      }";
  }];

  networking.firewall.allowedTCPPorts = lib.mkIf config.services.loki.enable
    [ config.services.loki.configuration.server.http_listen_port ];
}
