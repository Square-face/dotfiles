{ pkgs, lib, ... }:

{
    imports = [
        ../../modules/default.nix
        ./hardware-configuration.nix
    ];

    ssh.enable = true;
    tlp.enable = true;
    
    audio.enable = true;
    audio.low-latency = false;

    podman.enable = true;
    libvirtd.enable = true;

    sq8.enabled = true;
    ultra.enabled = true;

    grub.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_zen;

    hardware.graphics.enable = true;
    hardware.bluetooth.enable = true;
    hardware.sensor.iio.enable = true;

    networking.wireguard.enable = true;

    services.logind.settings.Login.HandleLidSwitchExternalPower = "lock";
    services.logind.settings.Login.HandlePowerKey = "hibernate";
    services.logind.settings.Login.HandlePowerKeyLongPress = "poweroff";

    networking = {
        hostName = "flappy";
        firewall.enable = false;
        useDHCP = false;
        interfaces.wlp3s0.useDHCP = true;
    };

    system.stateVersion = "25.11"; # No Touch!
}
