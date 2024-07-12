{ config, lib, ... }:

{
  config = lib.mkIf config.services.nginx.enable {
    networking.firewall.allowedTCPPorts = [
      config.services.nginx.defaultHTTPListenPort
      config.services.nginx.defaultSSLListenPort
    ];
  };
}
