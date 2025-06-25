{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      username = "sq8";
      mkHost =
        name: system:
        nixpkgs.lib.nixosSystem {
          system = "${system}";
          modules = [
            ./hosts/${name}/configuration.nix

            home-manager.nixosModules.home-manager
            {
              nixpkgs.hostPlatform = system;
              home-manager.users.${username} = import ./home.nix;
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        shrexbox = mkHost "shrexbox" "x86_64-linux";
      };
    };
}
