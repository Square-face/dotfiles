{ config, pkgs, lib, ... }:

{
    imports = [
        ./nvim.nix
        ./unfree.nix
        ./tmux.nix
        ./kitty.nix
        ./git.nix
        ./i3/default.nix
    ];

    home.packages = with pkgs; [
        clang-tools
        gcc
        grc

        direnv
        eza
        bat
        htop
        gh
        fastfetch
        ripgrep

        feh
        mpv
        file

        flameshot
    ];

}
