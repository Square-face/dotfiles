{ pkgs, lib, ... }:

{
    nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
        "spotify"
        "discord"
    ];

    home.packages = with pkgs; [
        spotify
        vesktop
        (pkgs.discord.override {
            # remove any overrides that you don't want
            withOpenASAR = true;
            withVencord = true;
        })
    ];
}
