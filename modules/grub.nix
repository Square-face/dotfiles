{pkgs, lib, config, ...}: {
    options = {
        grub.enable = lib.mkEnableOption "Enable Grub";
    };

    config = lib.mkIf config.grub.enable {
        environment.systemPackages = with pkgs; [
            catppuccin-grub
        ];

        boot.loader.timeout = 5;
        boot.loader.grub = {
            enable = lib.mkDefault true;
            useOSProber = lib.mkDefault true;
            memtest86.enable = lib.mkDefault true;
            efiSupport = lib.mkDefault true;
            device = "nodev";
            theme = "${pkgs.catppuccin-grub}";
        };
        boot.loader.efi.canTouchEfiVariables = true;
    };
}
