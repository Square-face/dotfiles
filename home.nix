{ config, pkgs, lib, ... }:

{
    home.username = "sq8";
    home.homeDirectory = "/home/sq8";

    fonts.fontconfig.enable = true;

    # programs that require configuration
    programs = {
        fish = {
            enable = true;
            interactiveShellInit = ''
                set fish_greeting
            '';
            plugins = [
                { name = "grc"; src = pkgs.fishPlugins.grc.src; }
                { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
                { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
            ];
        };
        git = {
            enable = true;
            extraConfig = {
                user = {
                    name = "Square-face";
                    email = "linus.michelsson@gmail.com";
                };
                core = {
                    editor = "nvim";
                };
                "credential \"https://github.com\"" = {
                    helper = "!/run/current-system/sw/bin/gh auth git-credential";
                };
                "credential \"https://gist.github.com\"" = {
                    helper = "!/run/current-system/sw/bin/gh auth git-credential";
                };
            };
        };
        kitty = {
            enable = true;
            settings = {
                font_family = "Fira Code Nerd Font";
                background_opacity = "0.8";
                background_blur = "10";
                enable_audio_bell = "no";
            };
        };

        starship = {
            enable = true;
            settings = {
                add_newline = false;
                right_format = "$time $battery";

                format = lib.concatStrings [
                    "(\n"
                    "$rust"
                    "[ ](fg:#5294aa bg:#006699)"
                    "$git_branch"
                    "[](fg:#006699)"
                    ")"
                    "$fill$character"
                    "$cmd_duration"
                    "\n"
                    "($directory)[ ](fg:#5294aa)"
                ];

                fill = {
                    symbol = " ";
                };

                character = {
                    success_symbol = "[  ](green)";
                    error_symbol = "[  ](red)";
                };

                git_branch = {
                    style = "fg:#ffffff bg:#006699 bold";
                    format = "[  ](fg:#f34f29  bg:#006699)[$branch ]($style)";
                };

                directory = {
                    style = "fg:#e3e5e5 bg:#5294aa";
                    format = "[ $path ]($style)";
                    truncation_length = 2;
                    truncation_symbol = "󰇘/";
                };

                battery = {
                    full_symbol = "󰁹 ";
                    charging_symbol = "󰢜 ";
                    discharging_symbol = "󰁺 ";
                    format = "[$symbol$percentage]($style)";
                };

                rust = {
                    style = "";
                    symbol = "🦀";
                    version_format = "\${raw}";
                    format = "[ $symbol $version](bg:#006699 bold)";
                };

                cmd_duration = {
                    show_notifications = true;
                    min_time = 2000;
                    format = "took [$duration ]($style)";
                };

                time = {
                    style = "fg:#7F8080";
                    format = "[$time]($style)";
                    disabled = false;
                };
            };
        };
    };

    # User specific packages that don't need any configuration
    home.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" ]; })

        clang-tools
        gcc
        grc

        neovim
        eza
        bat
    ];

    # Config files
    home.file = {
        ".config/nvim" = {
            source = ./nvim;
            recursive = true;
        };

    };

    home.sessionVariables = {
        EDITOR = "neovim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}
