{ pkgs, ... }:
{
  imports = [
  ./eza.nix
    ./tmux.nix
    ./gpg.nix
    ./zsh.nix
  ];

  xdg = {
    enable = true;
    portal = {
      enable = true;
      config.sway.default = [
        "wlr"
        "gtk"
      ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}
