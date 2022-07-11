{ ... }:

let
  hostname = "mirage";
in {
  imports = [
    ../all.nix
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = hostname;
  };

  users = {
    mutableUsers = false;
    users.venikx = {
      isNormalUser = true;
      password = "v3nikx";
      extraGroups = [ "wheel" ];
    };
  };
}
