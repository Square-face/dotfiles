{ pkgs, ... }:
{
    options = { };
    config = {
        environment.systemPackages = with pkgs; [ xorg.xauth waypipe ];
        services.openssh.enable = true;
        services.openssh.settings = {
            X11Forwarding = true;
            X11DisplayOffset = 10; # optional, default offset
            X11UseLocalhost = true; # recommended for security
        };
    };
}
