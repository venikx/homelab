{ config, lib, pkgs, ... }:

{
  users.groups.media = { };

  services.calibre-web = {
    group = "media";
    listen = {
      ip = "127.0.0.1";
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
        proxyPass = "http://127.0.0.1:8083";
        recommendedProxySettings = true;
        extraConfig = ''
          proxy_set_header X-Script-Name /calibre;
        '';

      };
    };
  };
}
