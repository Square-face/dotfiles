{pkgs, ...}: {
    boot.tmp.cleanOnBoot = true;
    networking.networkmanager.enable = true;


    documentation.dev.enable = true;
    environment.systemPackages = with pkgs; [
        man-pages
        man-pages-posix
    ];


    
    programs.zsh = {
        enable = true;
        autosuggestions = {
            enable = true;
        };
    };


    systemd.services.nix-daemon.serviceConfig = {
        CPUWeight=80;
    };
    nix.settings = {
        trusted-users = [ "sq8" ];
        use-xdg-base-directories = true;
        auto-optimise-store = true;
        experimental-features = [
            "nix-command"
            "flakes"
        ];
    };
} 
