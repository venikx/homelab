{ config, pkgs, lib, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    coreutils
    pciutils
    git
    neovim
    wget
    ranger
  ];

  services.openssh.enable = true;
}
