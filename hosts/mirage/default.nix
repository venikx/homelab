{ pkgs, ... }:

let
  hostname = "mirage";
in {
  imports = [
    ../all.nix
    ./hardware-configuration.nix
    ../../containers/ctest
    ../../containers/homer
    ../../containers/filebrowser
    ../../containers/ttrss
  ];

  networking = {
    hostName = hostname;
    firewall = {
      allowedTCPPortRanges = [{ from = 8000; to = 8100; }];
      # NOTE(Kevin): See: https://github.com/NixOS/nixpkgs/issues/72580
      extraCommands = "iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE";
    };

    nat = {
      enable = true;
      internalInterfaces = [ "ve-*" ];
      externalInterface = "wlan0";
    };

    networkmanager.enable = true;
    useDHCP = false;
    interfaces.wlan0.useDHCP = true;
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
