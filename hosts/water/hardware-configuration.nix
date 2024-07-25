{ config, pkgs, lib, ... }:

{
  services.qemuGuest.enable = true;

  boot = {
    loader.grub.device = "/dev/vda";
    tmp.cleanOnBoot = true;
    initrd.availableKernelModules =
      [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/70bbe5fd-9fcd-43b8-a44f-e974bb641db5";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/mnt/nas/images" = {
      device = "192.168.1.182:/mnt/tank/images";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
    "/mnt/nas/entertainment" = {
      device = "192.168.1.182:/mnt/tank/entertainment";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
  };

  system.stateVersion = "24.05";
}
