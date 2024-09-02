
{ config, pkgs, lib, ... }:

{
    programs.kitty = {
        enable = true;
        settings = {
            font_family = "Fira Code Nerd Font";
            background_tint = "0.9";
            background_color = "#000000";
            background_blur = "10";
            background_image = "~/.config/home-manager/assets/tokyonight.png";
            background_image_layout = "cscaled";
            enable_audio_bell = "no";
        };
    };
}
