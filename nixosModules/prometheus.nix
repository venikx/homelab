{ config, lib, ... }:

{
  config = lib.mkIf config.services.prometheus.enable {
    services.prometheus = {
      port = 9001;

      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = 9002;
        };
      };

      scrapeConfigs = [{
        job_name = "nodes";
        static_configs = [{
          targets = [
            "127.0.0.1:${
              toString config.services.prometheus.exporters.node.port
            }"
          ];
        }];
      }];

    };

    networking.firewall.allowedTCPPorts = [ config.services.prometheus.port ];
  };
}
