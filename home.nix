{ config, pkgs, ... }:

{
    home.username = "sq8";
    home.homeDirectory = "/home/sq8";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.

    # programs that require configuration
    programs = {
        neovim = {
            enable = true;
            defaultEditor = true;
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
    };

    # User specific packages that don't need any configuration
    home.packages = with pkgs; [
        clang-tools
        gcc
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
}
