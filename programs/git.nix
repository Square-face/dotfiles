{ config, pkgs, lib, ... }:

{
    programs.git = {
        enable = true;
        extraConfig = {
            user = {
                name = "Square-face";
                email = "linus.michelsson@gmail.com";
            };
            core = {
                editor = "nvim";
            };
            "credential \"https://github.com\"" = {
                helper = "!/${pkgs.gh}/bin/gh auth git-credential";
            };
            "credential \"https://gist.github.com\"" = {
                helper = "!/${pkgs.gh}/bin/gh auth git-credential";
            };
        };
    };
}
