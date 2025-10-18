{pkgs, ...}: {
    services.dunst = {
        enable = true;

        settings = {
            global = {
                monitor = 1;
                font = "FiraCode 10";
                progress_bar_corner_radius = 5;
                corner_radius = 5;
                origin = "bottom-right";
                offset = "(30, 25)";
                separator_color = "#cdd6f4";
                frame_width = 0;
                dmenu = "${pkgs.rofi}/bin/rofi --show dmenu -p dunst";
            };

            urgency_low = {
                frame_color = "#74c7ec";
                background = "#313244";
                foreground = "#cdd6f4";
                highlight = "#89b4fa, #a6e3a1";
            };

            urgency_normal = {
                frame_color = "#74c7ec";
                background = "#313244";
                foreground = "#cdd6f4";
                highlight = "#89b4fa, #a6e3a1";
            };

            urgency_critical = {
                background = "#eba0ac";
                foreground = "#cdd6f4";
                highlight = "#89b4fa, #a6e3a1";
            };

            # Filters are specified as sections
            "filter" = {
                appname = "Spotify";
                min_icon_size = 64;
                max_icon_size = 64;
                urgency = "low";
                history_ignore = true;
            };
        };
    };
}
