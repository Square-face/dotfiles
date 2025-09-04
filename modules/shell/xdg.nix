{ pkgs, ... }:
{
    xdg = {
        enable = true;
        portal = {
                enable = true;
                config.sway.default = [
                "wlr"
                "gtk"
                ];
                config.sway = {
                    "org.freedesktop.impl.portal.ScreenCast" = [
                        "wlr"
                    ];
                    "org.freedesktop.impl.portal.Screenshot" = [
                        "wlr"
                    ];
                    "org.freedesktop.impl.portal.Inhibit" = [
                        "none"
                    ];
                };
                extraPortals = with pkgs; [
                    xdg-desktop-portal-wlr
                    xdg-desktop-portal-gtk
                ];
        };
    };
}
