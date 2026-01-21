{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      nixos-generators,
      ...
    }:
    let
      mkLinuxHost =
        name: system:
        nixpkgs.lib.nixosSystem {
          system = "${system}";

          modules = [
            ./hosts/${name}/configuration.nix

            {
              nixpkgs.hostPlatform = system;
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        shrexbox = mkLinuxHost "shrexbox" "x86_64-linux";
        thiccpad = mkLinuxHost "thiccpad" "x86_64-linux";
        flappy   = mkLinuxHost "flappy" "x86_64-linux";
      };

      packages.x86_64-linux.liveIso = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "iso";

          modules = [
            ./hosts/iso/configuration.nix
          ];
        };
    };
}
