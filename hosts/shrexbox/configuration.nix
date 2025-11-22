{ lib, pkgs, ... }:

{
    imports = [
        # Load linux profile
        ../../profiles/base.nix
        ../../profiles/linux.nix

        # Load NixOs modules
        ../../modules/bootloader/grub.nix
        # ../../modules/machines.nix

        ## services
        ../../modules/services/ssh.nix
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


    networking = {
        hostName = "shrexbox";
        firewall.enable = false;
        useDHCP = false;
        dhcpcd.enable = false;
    };

    networking.interfaces.enp14s0 = {
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

    services.prometheus.exporters.node = {
        enable = true;
        port = 9000;
        disabledCollectors = ["xfs" "zfs" "bcache" "btrfs" "fibrechannel" "loadavg" "selinux" "infiniband" "mdadm" "ipvs" "edac" "conntrack" "hwmon" "rapl" ];
        enabledCollectors = ["processes"];
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "zerotierone"
        "steam"
        "steam-unwrapped"
    ];

    # Enable Hibernation
    swapDevices = [{
        device = "/swapfile";
        size = 64 * 1024; # 16GB
    }];

    boot.kernelParams = ["resume_offset=67440640"];
    boot.resumeDevice = "/dev/disk/by-uuid/e871e0c4-ed32-41a7-87cf-5cf90bd27e8c";

    services.udev.packages = with pkgs; [ oversteer ];
    services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c261", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 046d -p c261 -m 01 -r 01 -C 03 -M '0f00010142'"
      '';

    hardware.new-lg4ff.enable = true;
    hardware.graphics.enable = true;

    networking.wireless.enable = false;
    networking.wireless.userControlled.enable = false;
    # networking.networkmanager.wifi.enable = false;
    networking.networkmanager.wifi.backend = "iwd";
    networking.wireless.iwd.enable = lib.mkForce false;


    # fileSystems."/mnt/share" = {
    #     device = "10.0.1.241:/srv/nfs4/fren";
    #     fsType = "nfs4";
    #     options = ["rw" "sync" "noatime" "nofail" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
    # };

    system.stateVersion = "24.11"; # No Touch!

    networking = {
        interfaces = {
            enp14s0 = {
                wakeOnLan.enable = true;
            };
        };
        firewall = {
            allowedUDPPorts = [ 9 ];
        };
    };

}
