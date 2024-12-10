{ config, lib, pkgs, ... }:

{
  users.groups.media = { gid = 8675309; };

  services.calibre-web = {
    group = "media";
    listen = {
      ip = "0.0.0.0";
      port = 8083;
    };
    options = {
      calibreLibrary = "/mnt/nas/entertainment/literature";
      enableBookUploading = true;
      enableBookConversion = true;
    };
    openFirewall = true;
  };

  services.nginx = lib.mkIf config.services.calibre-web.enable {
    enable = true;
    virtualHosts."_" = {
      locations."/calibre" = {
        proxyPass = "http://0.0.0.0:8083";
        recommendedProxySettings = true;
        extraConfig = ''
          proxy_set_header X-Script-Name /calibre;
        '';

      };
    };
  };
}
