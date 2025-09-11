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

    ## Virtualization
    # ../../modules/virtualization/libvrt.nix
    # ../../modules/virtualization/docker.nix

    ## Programs
    ../../modules/graphical/obs.nix
    ../../modules/graphical/steam.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.wg-quick.interfaces.wg0.configFile = "/etc/wireguard/wg0.conf";

  networking = {
    hostName = "thiccpad";
    firewall.enable = false;
    useDHCP = false;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  system.stateVersion = "24.11"; # No Touch!
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  services.logind.lidSwitchExternalPower = "lock";
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";
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
      CPU_MAX_PERF_ON_BAT = 40;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
}
