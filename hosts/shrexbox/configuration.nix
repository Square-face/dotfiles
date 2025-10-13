{ lib, pkgs, ... }:

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
        ../../modules/services/udev.nix
        ../../modules/services/cockpit.nix

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
    };

    services.prometheus.exporters.node = {
        enable = true;
        port = 9000;
        enabledCollectors = ["processes"];
    };

    networking.wg-quick.interfaces.wg0.configFile = "/etc/wireguard/wg0.conf";
    networking.wg-quick.interfaces.wg1.configFile = "/etc/wireguard/wg1.conf";

    services.power-profiles-daemon.enable = true;
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "zerotierone"
        "steam"
        "steam-unwrapped"
    ];

    swapDevices = [{
        device = "/swapfile";
        size = 64 * 1024; # 16GB
    }];

    services.udev.packages = with pkgs; [ oversteer ];
    services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c261", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 046d -p c261 -m 01 -r 01 -C 03 -M '0f00010142'"
      '';

    hardware.new-lg4ff.enable = true;
    hardware.graphics.enable = true;


    # fileSystems."/mnt/share" = {
    #     device = "10.0.1.241:/srv/nfs4/fren";
    #     fsType = "nfs4";
    #     options = ["rw" "sync" "noatime" "nofail" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
    # };

    system.stateVersion = "24.11"; # No Touch!
}
