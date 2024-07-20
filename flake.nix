{
  description = "Homelab";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, nixos-hardware, flake-utils, sops-nix }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        sopsPkgs = sops-nix.packages."${pkgs.system}";
      in {
        devShells.secrets = pkgs.mkShell {
          packages = with pkgs;
            with sopsPkgs; [
              ssh-to-age
              sops-import-keys-hook
              sops-init-gpg-key
              sops
              git-crypt
            ];
        };
      })) // {
        nixosConfigurations = let
          buildSecrets =
            builtins.fromJSON (builtins.readFile "${self}/secrets/build.json");
        in {
          mirage = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              ./hosts/mirage
              nixos-hardware.nixosModules.raspberry-pi-4
              sops-nix.nixosModules.sops
              ./nixosModules
            ];
            specialArgs = { inherit buildSecrets; };
          };

          chakra = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              [ ./hosts/chakra sops-nix.nixosModules.sops ./nixosModules ];
          };
        };
      };
}
