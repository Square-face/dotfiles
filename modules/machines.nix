{ pkgs, ... }:
{
  options = { };
  config = {
    nix.distributedBuilds = true;
    nix.settings.builders-use-substitutes = true;

    nix.buildMachines = [
      {
        hostName = "192.168.1.212";
        sshUser = "remotebuild";
        sshKey = "/root/.ssh/remotebuild";
        system = pkgs.stdenv.hostPlatform.system;
        maxJobs = 44;
        supportedFeatures = [
          "nixos-test"
          "big-parallel"
          "kvm"
        ];
      }
    ];
  };
}
