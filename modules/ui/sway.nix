{pkgs, config, lib, ...}: let

  hmDir = ../../files;

in {
    programs.swaylock.enable = true;
    programs.swaylock.package = pkgs.swaylock-effects;

    home.packages = with pkgs; [
        brightnessctl
    ];

    home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "sway";
    };

    home.file."${config.xdg.configHome}/swaylock/config".text = ''
        show-failed-attempts
        ignore-empty-password
        screenshots
        clock
        indicator-idle-visible
        indicator-radius=100
        indicator-thickness=7
        ring-color=11111b
        key-hl-color=89dceb
        text-color=cdd6f4
        line-color=f5e0dc00
        inside-color=181825ff
        separator-color=ff000000
        fade-in=0.5
        effect-scale=1
        effect-blur=7x3
        effect-scale=1
        effect-vignette=0.5:0.5
    '';

    services.swayidle = let
        # Lock command
        lock = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
        display = status: "swaymsg 'output * power ${status}'";
    in {
        enable = true;
        timeouts = [
            {
                timeout = 240; # in seconds
                command = "${pkgs.brightnessctl}/bin/brightnessctl set 50%-";
                resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl set +50%";
            }
            {
                timeout = 300;
                command = lock;
            }
            {
                timeout = 600;
                command = display "off";
                resumeCommand = display "on";
            }
            {
                timeout = 900;
                command = "${pkgs.systemd}/bin/systemctl hybrid-sleep";
            }
        ];
        events = [
            {
                event = "before-sleep";
                # adding duplicated entries for the same event may not work
                command = (display "off") + "; " + lock;
            }
            {
                event = "after-resume";
                command = display "on";
            }
            {
                event = "lock";
                command = (display "off") + "; " + lock;
            }
            {
                event = "unlock";
                command = display "on";
            }
        ];
    };

    wayland.windowManager.sway = {
        enable = true;
        # package = pkgs.swayfx;
        xwayland = true;

            extraConfig = ''
            bindgesture swipe:left workspace prev
            bindgesture swipe:right workspace next
            '';
        config = {
            modifier = "Mod4";
            menu = "${pkgs.rofi-wayland}/bin/rofi -show drun";
            terminal = "kitty";
            startup = [
                { command = "waypaper --restore"; }
            ];
            bars = [
                { command = "${pkgs.waybar}/bin/waybar"; }
            ];
            keybindings = let
                modifier = config.wayland.windowManager.sway.config.modifier;
            in lib.mkOptionDefault {
                "${modifier}+shift+s" = "exec grim -g \"\$(slurp -d)\" -t png - | wl-copy -t image/png";
                "XF86AudioNext" = "exec playerctl next";
                "XF86AudioPrev" = "exec playerctl previous";
                "XF86AudioPlay" = "exec playerctl play-pause";
                "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
                "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
                "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
                "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
                "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
                "${modifier}+ctrl+up" = "move workspace to output up";
                "${modifier}+ctrl+down" = "move workspace to output down";
                "${modifier}+ctrl+left" = "move workspace to output left";
                "${modifier}+ctrl+right" = "move workspace to output right";
            };
            assigns = {
                "2" = [ { app_id = "firefox"; } ];
                "10" = [
                    { class = "Spotify"; }
                    { class = "vesktop"; }
                    { class = "Element"; }
                ];
            };
            defaultWorkspace = "1";
            window.titlebar = false;
            gaps = {
                smartBorders = "off";
                outer = 3;
                inner = 5;
            };

            input = {
                "*" = {
                    pointer_accel = "-0.3";
                    xkb_layout = "se";
                    xkb_options = "ctrl:nocaps";
                };
            };
        };
    };

    services.swww.enable = true;
    programs.waybar.enable = true;

    # Configuration files managed via Home Manager
    home.file = {
        ".config/waybar/config.jsonc".source = "${hmDir}/waybar.jsonc";
        ".config/waybar/style.css".source = "${hmDir}/waybar.css";
    };
}
