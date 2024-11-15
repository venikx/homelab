{ config, pkgs, lib, ... }:

{
  services.qemuGuest.enable = true;

  boot = {
    loader.grub.device = "/dev/vda";
    tmp.cleanOnBoot = true;
    initrd.availableKernelModules =
      [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
  };

  fileSystems = let nasIP = "172.19.20.250";
  in {
    "/" = {
      device = "/dev/disk/by-uuid/70bbe5fd-9fcd-43b8-a44f-e974bb641db5";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/mnt/nas/documents" = {
      device = "${nasIP}:/mnt/tank/documents";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
    "/mnt/nas/images" = {
      device = "${nasIP}:/mnt/tank/images";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
    "/mnt/nas/entertainment" = {
      device = "${nasIP}:/mnt/tank/entertainment";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
  };

  system.stateVersion = "24.05";
}
