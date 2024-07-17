{ config, lib, ... }:

{
  services.promtail = {
    configuration = {
      server = {
        http_listen_port = 9102;
        grpc_listen_port = 0;
      };
      positions = { filename = "/tmp/positions.yaml"; };
      clients = [{
        url = "http://10.0.0.2:${
            toString config.services.loki.configuration.server.http_listen_port
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
}
