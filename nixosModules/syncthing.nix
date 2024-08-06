{ config, lib, pkgs, ... }:

{
  services.syncthing = {
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "kevin-iphone" = {
          id =
            "ELIRVGI-W7IUR4D-HRK25JP-HML6LPG-QEH76SY-BTAL4Q6-YO66RTD-SOP37AL";
        };
        "air-nixos" = {
          id =
            "WK7RS2C-362VDSU-6AADX3Q-AFTADBL-PNY3KJO-ALQ6HYO-S6MQMOU-6MSYYAR";
        };
        "earth-nixos" = {
          id =
            "QUIA5TB-Q62NJOZ-NXNZPLY-6YXHXEJ-W5A6YMS-LTY2PXH-AZE5YHQ-22SHBQL";
        };
      };
      folders = {
        "org" = {
          path = "/mnt/nas/documents/99-org/gtd";
          versioning = {
            type = "simple";
            params.keep = "10";
          };
          devices = [ "kevin-iphone" "air-nixos" "earth-nixos" ];
        };
      };
    };
  };
}
