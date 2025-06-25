{
  pkgs,
  lib,
  config,
  ...
}:

let
  username = "sq8";

  # Get home.nix directory
  hmDir = builtins.toString ./.;
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [
    ./modules
    ./ui.nix
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];

  home.sessionVariables =
    let
      xdg = {
        config = config.home.sessionVariables.XDG_CONFIG_HOME;
        data = config.home.sessionVariables.XDG_DATA_HOME;
        state = config.home.sessionVariables.XDG_STATE_HOME;
      };
    in
    {
      PYTHON_HISTORY = "${xdg.state}/python/history";
      DOCKER_CONFIG = "${xdg.config}/docker";
      RUSTUP_HOME = "${xdg.data}/rustup";
      CARGO_HOME = "${xdg.data}/cargo";
      WAKATIME_HOME = "${xdg.data}/wakatime";
    };

  home.packages = with pkgs; [
    # Desktop Apps
    kitty
    vesktop
    firefox
    thunderbird
    playerctl
    spotifywm # spotify with proper window manager support

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
    ".config/starship.toml".source = "${hmDir}/files/starship.toml";
    ".config/kitty/kitty.conf".source = "${hmDir}/files/kitty.conf";

    ".config/waybar/config.jsonc".source = "${hmDir}/files/waybar.jsonc";
    ".config/waybar/lock.sh".source = "${hmDir}/files/lock.sh";
    ".config/waybar/style.css".source = "${hmDir}/files/waybar.css";

    ".config/wofi/config".source = "${hmDir}/files/wofi.conf";
    ".config/wofi/style.css".source = "${hmDir}/files/wofi.css";
  };

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
  home.stateVersion = "25.05"; # DON'T CHANGE WITHOUT READING NIXOS DOCS
}
