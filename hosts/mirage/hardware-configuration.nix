{ config, pkgs, lib, ... }:

{
  imports = ["${fetchTarball "https://github.com/domenkozar/nixos-hardware/archive/rpi4.tar.gz" }/raspberry-pi/4"];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
}
