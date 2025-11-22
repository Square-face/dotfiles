{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        catppuccin-grub
    ];

    boot.loader.timeout = 0;
    boot.loader.grub = {
        enable = true;
        useOSProber = true;
        memtest86.enable = true;
        efiSupport = true;
        device = "nodev";
        theme = "${pkgs.catppuccin-grub}";
        splashImage = null;
    };
    boot.loader.efi.canTouchEfiVariables = true;
}
