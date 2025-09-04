{pkgs, config, ...}: {

    programs.rofi = let
            inherit (config.lib.formats.rasi) mkLiteral;
        in {
        enable = true;
        package = pkgs.rofi-wayland;
        terminal = "${pkgs.kitty}/bin/kitty";

        extraConfig = {
            show-icons = mkLiteral "true";
            display-drun= " ";
            drun-display-format= "{name}";
        };

        theme = {
            window = {
                enabled = mkLiteral "true";
                location = mkLiteral "center";
                anchor = mkLiteral "center";

                border-radius = mkLiteral "12px";

                transparency = "real";
                background-color = mkLiteral "black / 10%";

                margin = mkLiteral "0px";
                padding = mkLiteral "0px";
            };

            mainbox = {
                enabled = mkLiteral "true";
                background-color = mkLiteral "transparent";

                spacing = mkLiteral "20px";
                margin = mkLiteral "0px";
                padding = mkLiteral "20px";
                children = ["inputbar" "listview"];
            };

            inputbar = {
                enabled = mkLiteral "true";

                spacing = mkLiteral "10px";
                margin = mkLiteral "0px";
                padding = mkLiteral "15px";

                border = mkLiteral "0px solid";
                border-radius = mkLiteral "10px";

                background-color = mkLiteral "white / 5%";
                text-color = mkLiteral "#cdd6f4";
                children = ["prompt" "entry"];
            };

            prompt = {
                enabled = mkLiteral "true";
                background-color = mkLiteral "transparent";
                text-color = mkLiteral "inherit";
            };

            text-prompt-colon = {
                enabled = mkLiteral "true";
                expand = mkLiteral "false";

                str = "::";

                background-color = mkLiteral "transparent";
                text-color = mkLiteral "inherit";
            };


            entry = {
                enabled = mkLiteral "true";

                cursor = mkLiteral "text";
                placeholder = "Search";
                placeholder-color = mkLiteral "inherit";

                background-color = mkLiteral "transparent";
                text-color = mkLiteral "inherit";
            };
        };
    };
}
