{ lib, ... }:

{
  imports = [
    # Load linux profile
    ../../profiles/base.nix
    ../../profiles/linux.nix

    # Load NixOs modules
    ../../modules/bootloader/grub.nix
    ../../modules/machines.nix

    ## services
    ../../modules/services/ssh.nix
    ../../modules/services/wireguard.nix
    ../../modules/services/udev.nix

    ## Virtualization
    ../../modules/virtualization/libvrt.nix
    ../../modules/virtualization/docker.nix

    ## Programs
    # ../../modules/graphical/obs.nix
    ../../modules/graphical/steam.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.kernelParams = ["resume_offset=67440640"];
  boot.resumeDevice = "/dev/disk/by-uuid/e871e0c4-ed32-41a7-87cf-5cf90bd27e8c";
  powerManagement.enable = true;

  networking = {
    hostName = "shrexbox";
    firewall.enable = false;
    useDHCP = false;
    interfaces.enp14s0.useDHCP = true;
    hosts = {
      "10.10.10.1" = [ "cluster-endpoint" ];
    };
  };

  wg.shitcloud = {
    enable = true;
    localIP = "10.10.10.101";
  };

  system.stateVersion = "24.11"; # No Touch!
  hardware.graphics.enable = true;

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "a0cbf4b62a09e017" ];
  };

  services.power-profiles-daemon.enable = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "zerotierone"
      "steam"
      "steam-unwrapped"
    ];

    swapDevices = [{
        device = "/swapfile";
        size = 64 * 1024; # 16GB
    }];
}
