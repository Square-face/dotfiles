{
  pkgs,
  lib,
  ...
}:

let
  hmDir = ../files;
in
{
  home.username = "sq8";
  home.homeDirectory = "/home/sq8";

  # Packages installed for the user
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard-rs

    playerctl
    spotifywm
  ];

  # Configuration files managed via Home Manager
  home.file = {
    ".config/waybar/config.jsonc".source = "${hmDir}/waybar.jsonc";
    ".config/waybar/lock.sh".source = "${hmDir}/lock.sh";
    ".config/waybar/style.css".source = "${hmDir}/waybar.css";

    ".config/wofi/config".source = "${hmDir}/wofi.conf";
    ".config/wofi/style.css".source = "${hmDir}/wofi.css";
  };

  # Home Manager modules to include (these should be proper HM modules)
  imports = [
    ../modules/shell/gpg.nix
    ../modules/shell/eza.nix
    ../modules/shell/zsh.nix
    ../modules/shell/tmux.nix
    ../modules/shell/xdg.nix
    ../modules/shell/zoxide.nix

    ../modules/dev/git.nix
    ../modules/dev/neovim.nix
    ../modules/graphical/firefox.nix
    ../modules/graphical/virt-manager.nix

    ../ui.nix
  ];

  # Optional: Set Home Manager state version (prevents breakage on updates)
  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];
}
