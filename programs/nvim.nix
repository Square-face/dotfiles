{ config, pkgs, lib, ... }:

{home = {

    packages = [ pkgs.neovim ];

    file.".config/nvim".source = ../nvim;
    file.".config/nvim".recursive = true;

    sessionVariables.EDITOR = "neovim";

};}
