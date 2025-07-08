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

  # Clear tmp on boot
  boot.tmp.cleanOnBoot = true;

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

  # Sound
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  # Smart card daemon
  services.pcscd.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Keymap
  console.keyMap = "sv-latin1";
}
