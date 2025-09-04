{pkgs, config, ...}: {

    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        terminal = "${pkgs.kitty}/bin/kitty";

        theme = let
            inherit (config.lib.formats.rasi) mkLiteral;
        in {
            "*" = {
                background-color = mkLiteral "#11111b";
                text-color = mkLiteral "#cdd6f4";
            };

            textbox-prompt-colon = {
                margin = mkLiteral "0px 0.3000em 0.0000em 0.0000em";
                expand = mkLiteral "false";
                str = ":";
                text-color = mkLiteral "inherit";
            };

            prompt = {
                content = "shize";
            };
            entry = {
                placeholder = "Search";
            };

            inputbar = {
                children = [
                    "prompt"
                    "entry"
                    "case-indicator"
                  ];
            };

            element = {
              orientation = "horizontal";
              children = [
                "element-icon"
                "element-text"
              ];
            };
            element-icon = {
              size = mkLiteral "2em";
            };
            element-text = {
              size = mkLiteral "1.5em";
            };
        };
    };
}
