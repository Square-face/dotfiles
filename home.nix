{ config, pkgs, lib, ... }:


{
    nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
        "spotify"
    ];

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

        tmux = {
            enable = true;
            mouse = false;
            baseIndex = 1;
            plugins = with pkgs; [
                tmuxPlugins.sensible
                tmuxPlugins.cpu
                {
                    plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
                        pluginName = "nova";
                        version = "unstable-2023-01-06";
                        src = pkgs.fetchFromGitHub {
                            owner = "o0th";
                            repo = "tmux-nova";
                            rev = "1.1.0";
                            sha256 = "1A7pnMMOwp1K7+WAAKbTqrMpm/wcorui6TQDHm8Xzd8=";
                        };
                    };
                    extraConfig = ''
                        set -g @nova-nerdfonts true
                        set -g @nova-nerdfonts-left 
                        set -g @nova-nerdfonts-right 

                        set -g @nova-pane-active-border-style "#44475a"
                        set -g @nova-pane-border-style "#282a36" 
                        set -g @nova-status-style-bg "#16161e"
                        set -g @nova-status-style-fg "#d8dee9"
                        set -g @nova-status-style-active-bg "#3b4261"
                        set -g @nova-status-style-active-fg "#7aa2f7"
                        set -g @nova-status-style-double-bg "#2d3540"

                        set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

                        set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
                        set -g @nova-segment-mode-colors "#7aa2f7 #2e3440"

                        set -g @nova-segment-whoami "#(whoami)@#h"
                        set -g @nova-segment-whoami-colors "#7aa2f7 #2e3440"

                        set -g @nova-rows 0
                        set -g @nova-segments-0-left "mode"
                        set -g @nova-segments-0-right "whoami"

                        set -g status-right '[#(TZ="Europe/Stockholm" date +"%%Y-%%m-%%d %%H:%%M")]'
                    '';
                }
            ];
            extraConfig = ''
                # Smart pane switching with awareness of Vim splits.
                # See: https://github.com/christoomey/vim-tmux-navigator
                
                # decide whether we're in a Vim process
                is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
                    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

                bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
                bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
                bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
                bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

                bind-key -n M-Left send-keys M-b
                bind-key -n M-Right send-keys M-f

                tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

                if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
                    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
                if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
                    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

                bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

                bind-key -T copy-mode-vi 'C-h' select-pane -L
                bind-key -T copy-mode-vi 'C-j' select-pane -D
                bind-key -T copy-mode-vi 'C-k' select-pane -U
                bind-key -T copy-mode-vi 'C-l' select-pane -R
                bind-key -T copy-mode-vi 'C-\' select-pane -l
                bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+
            '';
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

                fill.symbol = " ";

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

    # User specific packages that don't use home.nix for configuration
    home.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" ]; })

        clang-tools
        gcc
        grc

        neovim
        eza
        bat

        spotify
    ];

    # Config files
    home.file = {
        ".config/nvim" = {
            source = ./nvim;
            recursive = true;
        };

    };

    home.shellAliases = {
        c   = "clear";

        ls  = "eza";
        l   = "eza -a";
        la  = "eza -l -a";
        ll  = "eza -l";

        v   = "nvim";
        vi  = "nvim";
        vim = "nvim";

        winboot = "nix-shell -p efibootmgr --run 'sudo efibootmgr -n 1'; reboot";
    };

    home.sessionVariables = {
        EDITOR = "neovim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}
