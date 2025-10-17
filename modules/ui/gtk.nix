{pkgs, ...}: {
    home.packages = with pkgs; [

        # Fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        font-awesome
        source-han-sans
        source-han-sans-japanese
        source-han-serif-japanese
        nerd-fonts.fira-code

        bibata-cursors
        papirus-icon-theme
        magnetic-catppuccin-gtk
    ];


    fonts = {
        fontconfig = {
            enable = true;
            defaultFonts = {
                serif = [
                "Noto Serif"
                "Source Han Serif"
                ];
                sansSerif = [
                "Noto Sans"
                "Source Han Sans"
                ];
            };
        };
    };

    home.pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.pkgs.bibata-cursors;
    };

    home.file.".config/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-theme-name=Catppuccin-GTK-Dark
        gtk-icon-theme-name=Papirus-Dark
        gtk-cursor-theme-name=Bibata-Modern-Classic
        gtk-font-name=Sans 10
    '';

    home.file.".config/gtk-4.0/settings.ini".text = ''
        [Settings]
        gtk-theme-name=Catppuccin-GTK-Dark
        gtk-icon-theme-name=Papirus-Dark
        gtk-cursor-theme-name=Bibata-Modern-Classic
    '';
}
