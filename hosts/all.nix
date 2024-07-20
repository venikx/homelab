{ config, pkgs, lib, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils
    pciutils
    git
    neovim
    wget
    curl
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets."ips/mirage" = { };
    secrets."ips/chakra" = { };
  };

  networking.firewall.enable = true;
  services.openssh = {
    hostKeys = [{
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
    ports = [ 69 ];
    enable = true;
  };
}
