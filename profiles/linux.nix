{
  pkgs,
  lib,
  firefox-addons,
  ...
}:

let
  # Get home.nix directory
  hmDir = builtins.toString ./../files;
in
{
  imports = [ ./base.nix ];
  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    psmisc
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  users.users.sq8 = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Linus Michelsson";
    extraGroups = [
      "networkmanager"
      "seat"
      "video"
      "audio"
      "libvirtd"
      "kvm"
      "wheel"
    ];
  };

  networking.networkmanager.enable = true;

  # Enable SSH
  services.openssh.enable = true;

  home-manager.extraSpecialArgs = {
    inherit firefox-addons;
  };
  home-manager.users.sq8 = {
    home.username = "sq8";
    home.homeDirectory = "/home/sq8";

    home.packages = with pkgs; [
      grim
      slurp
      wl-clipboard-rs

      playerctl
      spotifywm # spotify with proper window manager support
    ];

    # Configuration files in plaintext
    home.file = {
      ".config/waybar/config.jsonc".source = "${hmDir}/waybar.jsonc";
      ".config/waybar/lock.sh".source = "${hmDir}/lock.sh";
      ".config/waybar/style.css".source = "${hmDir}/waybar.css";

      ".config/wofi/config".source = "${hmDir}/wofi.conf";
      ".config/wofi/style.css".source = "${hmDir}/wofi.css";
    };

    imports = [
      ./home.nix
      ../modules/shell/gpg.nix
      ../modules/shell/eza.nix
      ../modules/shell/zsh.nix
      ../modules/shell/tmux.nix
      ../modules/shell/xdg.nix
      ../modules/dev
      ../modules/applications/firefox.nix
      ../modules/graphical/virt-manager.nix
      ../ui.nix
    ];

  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "spotify"
    ];

  # Smart card daemon
  services.pcscd.enable = true;
}
