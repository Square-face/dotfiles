{ pkgs, lib, ... }:

{

  nix.settings = {
    use-xdg-base-directories = true;
    auto-optimise-store = true;
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
    bitwarden-cli

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
  ];

  # Zerotier
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "zerotierone"
        "spotify"
    ];
  services.zerotierone.enable = true;

  # Smart card daemon
  services.pcscd.enable = true;
}
