{ pkgs, ... }:

let
  hostname = "mirage";
in {
  imports = [
    ../all.nix
    ./hardware-configuration.nix
    ../../containers/homer
    ../../containers/filebrowser
  ];

  networking = {
    hostName = hostname;
    firewall = {
      allowedTCPPortRanges = [{ from = 8000; to = 8100; }];
    };
  };

  virtualisation = {
    oci-containers = {
      backend = "podman";
    };

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
      password = "v3nikx"; # remember to change this
      extraGroups = [ "wheel" "docker" ];
    };
  };
}
