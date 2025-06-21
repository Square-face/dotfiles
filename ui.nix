{ config, pkgs, lib, ... }:

{
    imports = [
        <catppuccin/modules/home-manager>
    ];

    home.packages = with pkgs; [
            hellwal
            waypaper

            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji
            font-awesome
            source-han-sans
            source-han-sans-japanese
            source-han-serif-japanese
            pkgs.nerd-fonts.fira-code
    ];

    home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "sway";
    };

    fonts = {
        fontconfig= {enable = true;
        defaultFonts = {
            serif = [ "Noto Serif" "Source Han Serif" ];
            sansSerif = [ "Noto Sans" "Source Han Sans" ];
        };
        };
    };
      
    # catppuccin.flavor = "mocha";
    # catppuccin.sway.enable = true;
    # catppuccin.gtk = {
    #     enable = true;
    #     flavor = "mocha";
    #     accent = "sapphire";
    #     size = "standard";
    #     tweaks = [ "normal" ];
    # };

    gtk = {
        enable = true;

        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

        theme = {
            name = "Catppuccin-GTK-Dark";
            package= pkgs.magnetic-catppuccin-gtk;
        };

        iconTheme = {
            name = "Papirus-Dark"; # Optional, change as desired
            package = pkgs.papirus-icon-theme;
        };

        cursorTheme = {
            name = "Bibata-Modern-Classic"; # Optional, change as desired
            package = pkgs.bibata-cursors;
        };
    };    

    programs.wofi.enable = true;
    programs.swaylock.enable = true;
    programs.swaylock.package = pkgs.swaylock-effects;

    services.swww.enable = true;
    services.dunst.enable = true;

    services.kanshi = {
        enable = true;
        settings = [
            {
            profile.name = "default";
            profile.outputs = [
                {
                    criteria = "HDMI-A-1";
                    scale = 1.0;
                    position = "0,420";
                }
                {
                    criteria = "DP-2";
                    transform = "90";
                    position = "2560,0";
                }
            ];
            }
        ];
    };

    wayland.windowManager.sway = {
        enable = true;
        config = rec {
            modifier = "Mod4";
            menu = "${pkgs.wofi}/bin/wofi --show drun";
            terminal = "kitty"; 
            startup = [
                {command = "kitty";}
            ];
            bars = [
                {command = "waybar";}
            ];
            keybindings = let
            modifier = config.wayland.windowManager.sway.config.modifier;
            in lib.mkOptionDefault {
                "${modifier}+shift+s" = "exec grim -g \"\$(slurp -d)\" -t png - | wl-copy -t image/png";
            };
            workspaceOutputAssign = [
                {output = "HDMI-A-1"; workspace = "1";}
                {output = "HDMI-A-1"; workspace = "2";}
                {output = "HDMI-A-1"; workspace = "3";}

                {output = "DP-2"; workspace = "0";}
                {output = "DP-2"; workspace = "9";}
            ];
            defaultWorkspace = "1";
            window.titlebar = false;
            gaps = {
                smartBorders = "off";
                outer = 3;
                inner = 5;
            };
        };
        extraConfig = ''
            input * {
                xkb_layout "se"
                xkb_options ctrl:nocaps
            }
        '';
    };

    home.pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.pkgs.bibata-cursors;
    };

    programs.waybar.enable = true;
}
