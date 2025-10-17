{ pkgs, ... }:
{
    xdg = {
        enable = true;
        portal = {
                enable = true;
                config.sway.default = [
                    "gtk"
                    "wlr"
                ];
                config.sway = {
                    "org.freedesktop.impl.portal.ScreenCast" = [
                        "gtk"
                    ];
                    "org.freedesktop.impl.portal.Screenshot" = [
                        "gtk"
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
