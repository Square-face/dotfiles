{ pkgs, ... }:

{
  imports = [
    # Load linux profile
    ../../profiles/linux.nix

    # Load NixOs modules
    ../../modules/bootloader/grub.nix
    ../../modules/virtualization/libvrt.nix
    ../../modules/virtualization/docker.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  programs.nix-ld.enable = true;

  # Networking
  networking.hostName = "shrexbox";

  networking.firewall.enable = false;

  networking.useDHCP = false;
  networking.interfaces.enp14s0.useDHCP = true;

  networking.hosts = {
    "192.168.196.53" = [ "john" ];
    "10.10.10.1" = [ "frank" ];
    "10.10.10.2" = [ "sperm-1" ];
    "10.10.10.3" = [
      "entry"
      "cluster-endpoint"
    ];
    "192.168.196.162" = [ "shitbox" ];
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.10.10.101/24" ];
      privateKeyFile = "/opt/wireguard/private.key";

      peers = [
        {
          publicKey = "J1F+7yaCc7iues5fqxT9XFxxzg1WfoiyWb0hKDhHghg=";
          allowedIPs = [ "10.10.10.0/24" ];
          endpoint = "193.234.117.50:41194";
        }
      ];
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  system.stateVersion = "24.11"; # No Touch!
}
