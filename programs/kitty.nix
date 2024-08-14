
{ config, pkgs, lib, ... }:

{
    programs.kitty = {
        enable = true;
        settings = {
            font_family = "Fira Code Nerd Font";
            background_opacity = "0.8";
            background_blur = "10";
            enable_audio_bell = "no";
        };
    };
}
