{ pkgs, lib, ... }:

let
  # Get home.nix directory
  hmDir = builtins.toString ./../files;
in
{
  imports = [ ./base.nix ];
  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    psmisc

    # sway
    wayland
    xwayland
  ];

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
      ../modules/dev
      ../modules/shell
      ../ui.nix
    ];

  };

  # Smart card daemon
  services.pcscd.enable = true;
  services.zerotierone.enable = true;

}
