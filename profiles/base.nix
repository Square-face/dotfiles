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
    vesktop
    thunderbird
    element-desktop
    orca-slicer

    # Password Manager
    bitwarden

    # Utils
    fd
    file
    wget
    libqalculate
    ripgrep
    dig
    feh
    mpv
    nmap
    dust
    fastfetch

    # === DEV ===
    ## LSPs
    nil

    ## Kubernetes
    k9s
    kubectl
    kubernetes-helm

    neovim
  ];

}
