{ config, lib, ... }:

{
  config = lib.mkIf config.services.loki.enable {
    services.loki = {
      configuration = {
        server.http_listen_port = 3100;
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

    services.promtail = {
      enable = true;

      configuration = {
        server = {
          http_listen_port = 9101;
          grpc_listen_port = 0;
        };
        positions = { filename = "/tmp/positions.yaml"; };
        clients = [{
          url = "http://127.0.0.1:${
              toString
              config.services.loki.configuration.server.http_listen_port
            }/loki/api/v1/push";
        }];
        scrape_configs = [{
          job_name = "journal";
          journal = {
            max_age = "12h";
            labels = {
              job = "systemd-journal";
              host = config.networking.hostName;
            };
          };
          relabel_configs = [{
            source_labels = [ "__journal__systemd_unit" ];
            target_label = "unit";
          }];
        }];
      };
    };

    networking.firewall.allowedTCPPorts = [
      config.services.promtail.configuration.server.http_listen_port
      config.services.loki.configuration.server.http_listen_port
    ];
  };
}
