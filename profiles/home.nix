{ pkgs, lib, config, ... }:

let
  # Get home.nix directory
  hmDir = builtins.toString ./../files;
in
{
  home.stateVersion = "25.05"; # DON'T CHANGE WITHOUT READING NIXOS DOCS

  # Configuration files in plaintext
  home.file = {
    ".config/waybar/config.jsonc".source = "${hmDir}/waybar.jsonc";
    ".config/waybar/lock.sh".source = "${hmDir}/lock.sh";
    ".config/waybar/style.css".source = "${hmDir}/waybar.css";

    ".config/wofi/config".source = "${hmDir}/wofi.conf";
    ".config/wofi/style.css".source = "${hmDir}/wofi.css";
  };
}
