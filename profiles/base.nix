{ pkgs, ... }:

{

  # Automatic background cleanup
  nix.gc.automatic = true;
  nix.optimise.automatic = true;
  nix.gc.randomizedDelaySec = "45min";
  nix.optimise.randomizedDelaySec = "45min";

  nix.settings = {
    trusted-users = [ "sq8" ];
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
