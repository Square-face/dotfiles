{lib, pkgs, ...}:

{

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "spotify"
    ];

    home.packages = with pkgs; [
        spotifywm # spotify with propery window manager support
    ];

    # programs.steam = {
    #     enable = true;
    #     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    #     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    #     localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    # };
}
