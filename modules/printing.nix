{ config, pkgs, lib, ... }: {
    options = {
        printing.enable = lib.mkEnableOption "Enable Printing";
        scanning.enable = lib.mkEnableOption "Enable Scanning";
    };
    config = let
        printing = lib.mkIf config.printing.enable {
            services.printing.enable = true;
        };

        scanning = lib.mkIf config.scanning.enable {
            hardware.sane.enable = true;
            hardware.sane.extraBackends = [ pkgs.sane-airscan ];
            
            services.saned.enable = true;

            services.udev.packages = [ pkgs.sane-airscan ];
            services.avahi.enable = true;
            services.avahi.nssmdns4 = true;

            environment.systemPackages = [pkgs.simple-scan];
        };
    in lib.mkMerge [printing scanning];
}
