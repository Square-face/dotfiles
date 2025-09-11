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
    ];

    users.users.sq8 = {
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "Linus Michelsson";
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPP9DFLLWEmyjcIJYXrPJEgV7Mk6eLwm60bPLJstiakl linus@sq8.dev"
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

    home-manager.users.sq8 = import ./home.nix;

    fileSystems."/mnt/share" = {
        device = "10.0.1.241:/srv/nfs4/fren";
        fsType = "nfs4";
        options = ["rw" "sync" "noatime" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
        "spotify"
    ];

    # Sound
    services.pulseaudio.enable = false;
    services.pipewire = {
        enable = true;
        audio.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
    };

    security.rtkit.enable = true;
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
    nixpkgs.config.permittedInsecurePackages = [
        "libsoup-2.74.3" # Required to install OrcaSlicer
    ];
  };
}
