{ pkgs, lib, ... }:

{

  nix.optimise.automatic = true;
  nix.settings = {
    use-xdg-base-directories = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];

  };
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # Desktop Apps
    kitty
    vesktop
    firefox
    thunderbird
    element-desktop

    # Password Manager
    bitwarden

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

    # === DEV ===
    # LSPs
    nil

    neovim
    ripgrep
    fd

# fonts
    nerd-fonts.fira-code

  ];

  # Zerotier
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "zerotierone"
        "spotify"
    ];
}
