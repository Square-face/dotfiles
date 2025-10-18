{pkgs, config, ...}: {

    programs.rofi = let
            inherit (config.lib.formats.rasi) mkLiteral;
        in {
        enable = true;
        package = pkgs.rofi;
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
                background-color = mkLiteral "black / 60%";

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

                background-color = mkLiteral "white / 15%";
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

            listview = {
                enabled = mkLiteral "true";

                columns = mkLiteral "5";
                lines = mkLiteral "3";

                cycle = mkLiteral "true";
                dynamic = mkLiteral "true";
                scrollbar = mkLiteral "false";

                layout = mkLiteral "vertical";
                reverse = mkLiteral "false";

                fixed-height = mkLiteral "true";
                fixed-columns = mkLiteral "true";

                spacing = mkLiteral "0px";
                margin = mkLiteral "0px";
                padding = mkLiteral "0px";
                border = mkLiteral "0px solid";
                border-radius = mkLiteral "0px";
                background-color = mkLiteral "transparent";
                text-color = mkLiteral "#cdd6f4";
                cursor = "default"; 
            };

            scrollbar = {
                handle-width = mkLiteral "5px";
                handle-color = mkLiteral "#6c7086";
                border-radius = mkLiteral "0px";
                background-color = mkLiteral "#1e1e2e";
            };

            element = {
                enabled = mkLiteral "true";

                spacing = mkLiteral "15px";
                margin = mkLiteral "0px";
                padding = mkLiteral "20px 10px";

                border = mkLiteral "0px solid";
                border-radius = mkLiteral "10px";

                background-color = mkLiteral "transparent";
                text-color = mkLiteral "#cdd6f4";

                orientation = mkLiteral "vertical";
                cursor = mkLiteral "pointer"; 
            };

            "element normal.normal" = {
                background-color = mkLiteral "transparent";
                text-color = mkLiteral "#cdd6f4";
            };

            "element selected.normal" = {
                background-color = mkLiteral "white / 15%";
                text-color = mkLiteral "#cdd6f4";
            };

            element-icon = {
                background-color = mkLiteral "transparent";
                text-color = mkLiteral "inherit";

                size = mkLiteral "64px";
                cursor = mkLiteral "inherit"; 
            };

            element-text = {
                background-color = mkLiteral "transparent";
                text-color = mkLiteral "inherit";

                highlight = mkLiteral "inherit";
                cursor = mkLiteral "inherit"; 

                vertical-align = mkLiteral "0.5";
                horizontal-align = mkLiteral "0.5";
            };

            error-message = {
                padding = mkLiteral "15px";
                border = mkLiteral "2px solid";
                border-radius = mkLiteral "10px";
                border-color = mkLiteral "#9399b2";

                background-color = mkLiteral "black / 10%";
                text-color = mkLiteral "#cdd6f4";
            };

            textbox = {
                vertical-align = mkLiteral "0.5";
                horizontal-align = mkLiteral "0.0";
                highlight = mkLiteral "none";

                background-color = mkLiteral "transparent";
                text-color = mkLiteral "#cdd6f4";
            };
        };
    };
}
