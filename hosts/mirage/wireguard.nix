{ config, buildSecrets, ... }:

{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.0.0.2/24" "fdc9:281f:04d7:9ee9::2/64" ];
      dns = [ "10.0.0.1" "fdc9:281f:04d7:9ee9::1" ];
      privateKeyFile = "/private/wireguard_key";
      listenPort = 39985;

      peers = [{
        publicKey = "VwfW/NgWOp/sK62WZSSWJbWwkJg0EUHroKVzMjFXeRQ=";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        # NOTE(Kevin): Using git-crypt to hide the ip, as it's not super crucial to
        # not be exposed at runtime + sops-nix would need to be an evaluated valued
        endpoint = "${buildSecrets.ips.chakra}:51820";
        persistentKeepalive = 25;
      }];
    };
  };

  networking.firewall = {
    allowedUDPPorts = [ config.networking.wg-quick.interfaces.wg0.listenPort ];
  };
}
