{ config, lib, ... }:

{
  config = lib.mkIf config.services.tailscale.enable {
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
