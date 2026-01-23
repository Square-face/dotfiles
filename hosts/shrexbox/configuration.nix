{ lib, pkgs, ... }:

{
    imports = [
        ../../modules/default.nix

        # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];


    networking = {
        hostName = "shrexbox";
        firewall.enable = false;
        useDHCP = false;
        dhcpcd.enable = false;
    };

    networking.interfaces.enp14s0 = {
        wakeOnLan.enable = true;
        ipv4.addresses = [{
            address = "192.168.8.218";
            prefixLength = 24;
        }];
    };

    networking.defaultGateway = {
        address = "192.168.8.1";
        interface = "enp14s0";
    };

    networking.nameservers = ["1.1.1.1" "8.8.8.8" "192.168.8.1"];

    networking.wireguard.enable = true;

    # Enable Hibernation
    swapDevices = [{
        device = "/swapfile";
        size = 64 * 1024;
    }];

    boot.kernelParams = ["resume_offset=67440640"];
    boot.resumeDevice = "/dev/disk/by-uuid/e871e0c4-ed32-41a7-87cf-5cf90bd27e8c";

    hardware.new-lg4ff.enable = true;
    hardware.graphics.enable = true;

    networking.wireless.enable = false;

    system.stateVersion = "24.11"; # No Touch!
}
