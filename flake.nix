{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, nix-darwin, home-manager, ... }:
    let
      username = "sq8";

      mkLinuxHost =
        name: system:
        nixpkgs.lib.nixosSystem {
          system = "${system}";
          modules = [
            ./hosts/${name}/configuration.nix
            ./profiles/linux.nix

            home-manager.nixosModules.home-manager
            {
              nixpkgs.hostPlatform = system;
            }
          ];
        };
      mkMacOsHost =
        name: system:
        nix-darwin.lib.darwinSystem {
          system = "${system}";
          modules = [
            ./hosts/${name}/configuration.nix
            ./profiles/mac.nix

            home-manager.darwinModules.home-manager

            {
              nixpkgs.hostPlatform = system;
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        shrexbox = mkLinuxHost "shrexbox" "x86_64-linux";
      };
      darwinConfigurations = {
        airhead = mkMacOsHost "airhead" "aarch64-darwin";
      };
    };
}
