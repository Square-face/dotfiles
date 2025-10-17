{ pkgs, config, lib, ... }: {
    home.username = "sq8";
    home.homeDirectory = "/home/sq8";

    # Packages installed for the user
    home.packages = with pkgs; [
        grim
        slurp
        wl-clipboard-rs

        playerctl
        spotifywm
        evince
        usbutils
        nemo-with-extensions
        prismlauncher
    ];

    home.sessionVariables = {
        RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
        CARGO_HOME = "${config.xdg.dataHome}/cargo";
        DOCKER_CONFIG = "${config.xdg.configHome}/docker";
        WINEPREFIX = "${config.xdg.dataHome}/wineprefixes";
    };

    services.udiskie = {
        enable = true;
        settings = {
            # workaround for
            # https://github.com/nix-community/home-manager/issues/632
            program_options = {
                # replace with your favorite file manager
                file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
            };
        };
    };

    services.spotifyd.enable = true;
    services.spotifyd.settings = {
        global = {
            device_name = "SpotMaD";
            device_type = "computer";
            disable_discovery = true;
        };
    };
    systemd.user.services.spotifyd = {
        Install.WantedBy = lib.mkForce [ "graphical-session.target" ];
    };

    # Home Manager modules to include (these should be proper HM modules)
    imports = [
        ../modules/shell/gpg.nix
        ../modules/shell/eza.nix
        ../modules/shell/zsh.nix
        ../modules/shell/tmux.nix
        ../modules/shell/xdg.nix
        ../modules/shell/zoxide.nix

        ../modules/dev/git.nix
        ../modules/dev/neovim.nix
        ../modules/graphical/firefox.nix
        ../modules/graphical/virt-manager.nix
        ../modules/graphical/kitty.nix
        ../modules/graphical/waypaper.nix

        ../modules/ui/gtk.nix
        ../modules/ui/sway.nix
        ../modules/ui/dunst.nix
        ../modules/ui/rofi.nix
        ../modules/ui/kanshi.nix
    ];

    # Optional: Set Home Manager state version (prevents breakage on updates)
    home.stateVersion = "24.11";

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "spotify"
    ];
}
