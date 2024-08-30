{ config, pkgs, lib, ... }:

{home = let
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
    packages = with pkgs; [ unstable.neovim ];

    file.".config/nvim".source = ../nvim;
    file.".config/nvim".recursive = true;

    sessionVariables.EDITOR = "neovim";

};}
