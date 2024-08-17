{ pkgs, lib, ... }:

{
    imports = [
        ./polybar.nix
    ];
    xsession.enable = true;
    xsession.windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
            defaultWorkspace = "workspace 2 output \"DP-3\"";
            modifier = "Mod4";
            terminal = "kitty";
            gaps = {
                inner = 10;
                outer = 5;
            };
            colors = {
                focused = {
                    background = "#3b4261";
                    border = "#3b4261";
                    childBorder = "#3b4261";
                    indicator = "#3b4261";
                    text = "#d8dee9";
                };
                unfocused = {
                    background = "#16161e";
                    border = "#2e3440";
                    childBorder = "#2e3440";
                    indicator = "#2e3440";
                    text = "#d8dee9";
                };

                focusedInactive = {
                    background = "#2e3440";
                    border = "#2e3440";
                    childBorder = "#2e3440";
                    indicator = "#2e3440";
                    text = "#7aa2f7";
                };
            };

            bars = [
                {command = "polybar top &";}
                {command = "polybar bottom &";}
                {command = "polybar bottom2 &";}
            ];

            startup = [
                {command = "autorandr -c";}
                {command = "feh ~/.config/home-manager/assets/city.png";}
            ];

            keybindings = let
                mod = "Mod4";
            in lib.mkOptionDefault {
                "${mod}+Shift+S" = "exec flameshot gui";
            };
        };
    };
}
