{ pkgs, lib, ... }:

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

        ## Virtualization
        ../../modules/virtualization/libvrt.nix
        ../../modules/virtualization/podman.nix

        ## Programs
        ../../modules/graphical/obs.nix
        ../../modules/graphical/steam.nix

        # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    boot.kernelPackages = pkgs.linuxPackages_zen;

    networking = {
        hostName = "thiccpad";
        firewall.enable = false;
        useDHCP = false;
        interfaces.wlp0s20f3.useDHCP = true;
        interfaces.enp0s31f6.useDHCP = true;
    };

    system.stateVersion = "24.11"; # No Touch!
    hardware.graphics.enable = true;
    hardware.bluetooth.enable = true;

    networking.wireguard.enable = true;

    services.logind.settings.Login.HandleLidSwitchExternalPower = "lock";
    services.logind.settings.Login.HandlePowerKey = "hibernate";
    services.logind.settings.Login.HandlePowerKeyLongPress = "poweroff";
    services.power-profiles-daemon.enable = false;
    services.tlp = {
        enable = true;
        settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 60;

            #Optional helps save long term battery health
            START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
            STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

        };
    };
}
