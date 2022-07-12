{
  description = "Homelab";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware }:
    let
      user = "venikx";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        mirage = lib.nixosSystem {
          system = "aarch64-linux";
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./hosts/mirage
            nixos-hardware.nixosModules.raspberry-pi-4
          ];
        };
      };
    };
}
