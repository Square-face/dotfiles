{ lib, ... }:

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
        # ../../modules/virtualization/libvrt.nix
        ../../modules/virtualization/docker.nix

        ## Programs
        ../../modules/graphical/obs.nix
        # ../../modules/graphical/steam.nix
    ];

    services.getty.autologinUser = lib.mkForce "sq8";

    system.stateVersion = "24.11"; # No Touch!
    # hardware.graphics.enable = true;
    # hardware.bluetooth.enable = true;

    services.hardware.openrgb.enable = true;
    networking.wireguard.enable = true;
}
