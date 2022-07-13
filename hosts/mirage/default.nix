{ pkgs, ... }:

let
  hostname = "mirage";
in {
  imports = [
    ../all.nix
    ./hardware-configuration.nix
    ../../containers/homer
  ];

  networking = {
    hostName = hostname;
    firewall = {
      allowedTCPPortRanges = [{ from = 8000; to = 8100; }];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = false;
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  users = {
    mutableUsers = false;
    users.venikx = {
      isNormalUser = true;
      password = "v3nikx";
      extraGroups = [ "wheel" "docker" ];
    };
  };
}
