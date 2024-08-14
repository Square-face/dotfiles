{ config, pkgs, lib, ... }:


{
    imports = [
        ./fonts.nix
        ./shell.nix
        ./programs/default.nix
    ];

    home.username = "sq8";
    home.homeDirectory = "/home/sq8";

    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}
