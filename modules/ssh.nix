{ pkgs, lib, config, ... }: let
  cfg = config.ssh;
in {
    options.ssh = {
        enable = lib.mkEnableOption "OpenSSH service";
        x11forwarding = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable X11 Forwarding";
        };
    };

    config = let
        ssh = lib.mkIf cfg.enable {
            services.openssh.enable = lib.mkDefault true;
            services.openssh.banner = lib.mkDefault "Tagga fejden!\n";
        }; 

        x11 = lib.mkIf (cfg.enable && cfg.x11forwarding) {
            environment.systemPackages = with pkgs; [ xorg.xauth ];

            services.openssh.settings = {
                X11Forwarding = lib.mkDefault true;
                X11DisplayOffset = lib.mkDefault 10;
                X11UseLocalhost = lib.mkDefault true;
            };
        };
    in lib.recursiveUpdate ssh x11;
}
