{ pkgs, ... }:

{

  nix.optimise.automatic = true;
  nix.settings = {
    trusted-users = [ "sq8" ];
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
    k9s

    # === DEV ===
    # LSPs
    nil

    neovim
    ripgrep
    fd

    # fonts
    nerd-fonts.fira-code

    orca-slicer
  ];

}
