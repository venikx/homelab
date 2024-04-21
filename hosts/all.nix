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

  networking.firewall.enable = true;
  services.openssh.enable = true;
}
