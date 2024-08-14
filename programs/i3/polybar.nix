{ pkgs, ... }:

{
    services.polybar.enable = true;
    services.polybar.script = "polybar top &";
    services.polybar.package = pkgs.polybar.override {
        i3Support = true;
        alsaSupport = true;
        iwSupport = true;
        githubSupport = true;
    };
    services.polybar.settings = let
        colors = {
            bg-transparent = "%{B#00000000}";
            bg-dark   = "%{B#161616}";
            bg-normal = "%{B#3b4261}";
            bg-bright = "%{B#7aa2f7}";

            fg-transparent = "%{F#00000000}";
            fg-white  = "%{F#ffffff}";
            fg-dark   = "%{F#161616}";
            fg-normal = "%{F#3b4261}";
            fg-bright = "%{F#7aa2f7}";
        };

        glyphs = {
            top-right-full = "%{T2}%{T-}";
            top-left-full  = "%{T2}%{T-}";
            bot-left-full  = "%{T2}%{T-}";
            bot-right-full = "%{T2}%{T-}";

            left-part  = "%{F#ffffff}%{T2}%{T-}";
            right-part = "%{F#ffffff}%{T2}%{T-}";
        };
    in {


        "global/wm" = {
            margin-top = "0";
            margin-bottom = "0";
            padding-top = "0";
            padding-bottom = "0";
        };

        "bar/base" = {
            monitor = "HDMI-1";

            width = "100%";
            height = "17";
            radius = 0;

            underline-size = "0";
            border-size = "0";
            module-margin-left = 0;
            module-margin-right = 0;
            
            padding = 0;
            margin = 0;
            border = 0;

            background = "#161616";

            font-0 = "Fira Code Nerd Font:size=10";
            font-1 = "Fira Code Nerd Font:size=20";

        };

        "bar/top" = {
            "inherit" = "bar/base";
            offset-y = 2;

            modules-left = "window";
            modules-center = "";
            modules-right = "date";
        };

        "bar/bottom" = {
            "inherit" = "bar/base";

            bottom = true;

            modules-left = "i3";
            modules-center = "";
            modules-right = "network";
        };

        "module/i3" = {
            type = "internal/i3";
            index-sort = true;

            format = "<label-state>";

            label-focused = "${colors.bg-normal}${colors.fg-dark}${glyphs.bot-left-full}${colors.fg-bright}${colors.bg-normal} %index% ${colors.fg-dark}${glyphs.top-right-full}";
            label-unfocused = "${colors.bg-dark}${colors.fg-dark}${glyphs.bot-left-full}${colors.fg-bright} %index% ${colors.fg-dark}${glyphs.top-right-full}";
            label-visible = "${colors.bg-dark}${colors.fg-dark}${glyphs.bot-left-full}${colors.fg-white} %index% ${colors.fg-dark}${glyphs.top-right-full}";
            label-urgent = "${colors.bg-dark}${colors.fg-dark}${glyphs.bot-left-full}${colors.fg-bright} %index% ${colors.fg-dark}${glyphs.top-right-full}";
        };

        "module/date" = {
            type = "internal/date";
            internal = 5;
            date = "%d/%m/%y";
            time = "%H:%M";
            label = " ${colors.fg-bright}%time% ${glyphs.right-part} ${colors.fg-bright}%date% ";

            format-background = "#3b4261";
            format-foreground = "#7aa2f7";

            format-prefix = glyphs.top-right-full;
            format-prefix-background = "#161616";
            format-prefix-foreground = "#3b4261";
        };

        "module/network" = {
            type = "internal/network";
            interface-type = "wired";
            speed-unit = "";
            format-connected = "<label-connected>";
            format-connected-prefix = glyphs.bot-right-full;
            format-connected-prefix-background = "#161616";
            format-connected-prefix-foreground = "#3b4261";

            format-connected-background = "#3b4261";
            label-connected = " ${colors.fg-bright}󰕒 %upspeed% ${glyphs.left-part}${colors.fg-bright}󰇚 %downspeed% (B/s) ";
        };

        "module/window" = {
            type = "internal/xwindow";
            format = "<label>";
            format-background = "#3b4261";
            format-foreground = "#7aa2f7";

            format-suffix = glyphs.top-left-full;
            format-suffix-background = "#161616";
            format-suffix-foreground = "#3b4261";

            label = " ${colors.fg-bright}%class% ${glyphs.left-part} ${colors.fg-bright}%title% ";
            label-maxlen = "100";
        };
    };
}
