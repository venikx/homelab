{
  description = "Homelab";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
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
          modules = [
            ./hosts/mirage
            nixos-hardware.nixosModules.raspberry-pi-4
            ./nixosModules
          ];
        };

        chakra = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/chakra ./nixosModules ];
        };
      };
    };
}
