{
  lib,
  pkgs,
  ...
}:

{
  options = { };
  config = {
    environment.systemPackages = with pkgs; [
        xdg-utils
        uutils-coreutils-noprefix
        psmisc
        oversteer

        # Wine
        wineWowPackages.stable
        wineWowPackages.waylandFull
        winetricks
    ];

    programs.sway.enable = true;
    services.desktopManager.plasma6.enable = true;

    systemd.services.nix-daemon.serviceConfig = {
        CPUWeight=80;
    };

    users.users.sq8 = {
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "Linus Michelsson";
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPP9DFLLWEmyjcIJYXrPJEgV7Mk6eLwm60bPLJstiakl linus@sq8.dev"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN5D+pEdcsfKqDe54yG92GPpm8X9PP3H4M7idvgGrs2G linus@sq8.dev"
        ];
        extraGroups = [
            "networkmanager"
            "seat"
            "video"
            "audio"
            "libvirtd"
            "kvm"
            "wheel"
        ];
    };

    users.users.ultra = {
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "Casper Medin Jensen";
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIufvkDkpyHPWr8zjPtSFShNl25136YWMufD9/AtIjMv ultra@trallalero"
        ];
        extraGroups = [
            "networkmanager"
            "seat"
            "video"
            "audio"
            "libvirtd"
            "kvm"
            "wheel"
        ];
    };

    networking.networkmanager.enable = true;
    boot.tmp.cleanOnBoot = true;

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
        "spotify"
    ];
    security.polkit.enable = true;
    security.pam.services.swaylock = {};

    services.pcscd.enable = true;
    services.udisks2.enable = true;

    i18n = {
        defaultLocale = "en_GB.UTF-8";
        extraLocaleSettings = {
            LC_ADDRESS = "sv_SE.UTF-8";
            LC_IDENTIFICATION = "sv_SE.UTF-8";
            LC_MEASUREMENT = "sv_SE.UTF-8";
            LC_MONETARY = "sv_SE.UTF-8";
            LC_NAME = "sv_SE.UTF-8";
            LC_NUMERIC = "sv_SE.UTF-8";
            LC_PAPER = "sv_SE.UTF-8";
            LC_TELEPHONE = "sv_SE.UTF-8";
            LC_TIME = "sv_SE.UTF-8";
        };
    };

    time.timeZone = "Europe/Stockholm";
    console.keyMap = "sv-latin1";
  };
}
