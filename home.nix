{ pkgs, ... }:

let
    # Assuming home.nix and starship.toml are in the same directory
    hmDir = builtins.toString ./.;
in
{
    imports = if builtins.pathExists ./secrets.nix then
      [
        ./shell.nix
        ./unfree.nix
        ./ui.nix
        ./secrets.nix
      ]
    else
      throw "secrets.nix is missing. Please read the README on how to create it";

    home.packages = with pkgs; [
        # Desktop Apps
        kitty
        vesktop
        firefox
        thunderbird

        # LSPs
        nil

        # Utils
        fd
        file
        wget
        ripgrep
        ripgrep-all
        libqalculate
        dig
        nmap
        dust
        fastfetch

        grim
        slurp
        wl-clipboard-rs

        element-desktop

        # Virtualization tools
        virt-manager
        qemu

        # games
        prismlauncher
    ];

    # Configuration files in plaintext
    home.file = {
        ".config/starship.toml".source    = "${hmDir}/files/starship.toml";
        ".config/kitty/kitty.conf".source = "${hmDir}/files/kitty.conf";

        ".config/waybar/config.jsonc".source = "${hmDir}/files/waybar.jsonc";
        ".config/waybar/lock.sh".source      = "${hmDir}/files/lock.sh";
        ".config/waybar/style.css".source    = "${hmDir}/files/waybar.css";

        ".config/wofi/config".source    = "${hmDir}/files/wofi.conf";
        ".config/wofi/style.css".source = "${hmDir}/files/wofi.css";
    };

    programs.home-manager.enable = true; # Let Home Manager install and manage itself.
    home.stateVersion = "25.05"; # DON'T CHANGE WITHOUT READING NIXOS DOCS
}
