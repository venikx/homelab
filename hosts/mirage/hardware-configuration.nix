{ config, pkgs, lib, ... }:

{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  system.stateVersion = "22.05";
}
