{ lib, pkgs, config, ... }: {

  imports = [ ../all.nix ./hardware-configuration.nix ];

  networking = { hostName = "vm-prod-media-01"; };

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";

  #services.prometheus.exporters.node.enable = true;
  #services.promtail.enable = true;

  #services.syncthing.enable = true;
  #services.calibre-web.enable = true;
  #modules.services.immich.enable = true;

}
