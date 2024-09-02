{ pkgs, lib, ... }:

{
    programs.fish = {
        enable = true;

        plugins = [ # Fish plugins
            { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
            { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
        ];

        # Dissable the greeting that shows up upon entring a shell
        interactiveShellInit = ''set fish_greeting'';
    };

    programs.starship = {
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

    home.shellAliases = {
        c   = "clear";

        # Replace ls with eza
        ls  = "eza";
        l   = "eza -a";
        la  = "eza -l -a";
        ll  = "eza -l";

        # Neovim shortcuts
        v   = "nvim";
        vi  = "nvim";
        vim = "nvim";

        # Tmux shortcuts
        t   = "tmux";
        ta  = "tmux attach";

        # git shortcuts
        g   = "git";
        gs  = "git status";
        gd  = "git diff";
        gdc = "git diff --cached";
        gpl = "git pull";
        gpu = "git push";

        gl  = "git log";
        glg = "git log --graph --oneline --all";

        gc  = "git commit";
        gcm = "git commit -m";
        gca = "git commit --amend --no-edit"; # amend to previous commit without launching an editor to edit the commit message
        gce = "git commit --amend"; # amend to previous commit and allow the commit message to be edited

        gC  = "git checkout";
        gCb = "git checkout -b";

        gb  = "git branch";

        ga  = "git add";
        gaa = "git add .";
        gai = "git add -i ";

        gr  = "git rebase";
        gri = "git rebase -i";

        # Tell bios to select windows for the next boot
        # Reboot
        winboot = "nix-shell -p efibootmgr --run 'sudo efibootmgr -n 1'; reboot";
    };
}
