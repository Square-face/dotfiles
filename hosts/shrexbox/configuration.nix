{ pkgs, ... }:

{
  imports = [
    # Load linux profile
    ../../profiles/linux.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.timeout = 10;
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    memtest86.enable = true;
    efiSupport = true;
    # efiInstallAsRemovable = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Clear tmp on boot
  boot.tmp.cleanOnBoot = true;

  # Desktop Environment.
  programs.sway.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.displayManager.startx.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.nix-ld.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  # Sound
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Virtualization
  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  # Networking
  networking.hostName = "shrexbox";

  networking.firewall.enable = false;

  networking.useDHCP = false;
  networking.interfaces.enp14s0.useDHCP = true;

  networking.hosts = {
    "192.168.196.173" = [ "aapo" ];
    "192.168.196.53" = [ "john" ];
    "10.10.10.1" = [ "frank" ];
    "10.10.10.2" = [ "sperm-1" ];
    "10.10.10.3" = [
      "entry"
      "cluster-endpoint"
    ];
    "192.168.196.162" = [ "shitbox" ];
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.10.10.101/24" ];
      privateKeyFile = "/opt/wireguard/private.key";

      peers = [
        {
          publicKey = "J1F+7yaCc7iues5fqxT9XFxxzg1WfoiyWb0hKDhHghg=";
          allowedIPs = [ "10.10.10.0/24" ];
          endpoint = "193.234.117.50:41194";
          # persistentKeepalive = 25;
        }
      ];

    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

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
  services.xserver.xkb = {
    layout = "se";
    variant = "nodeadkeys";
  };

  system.stateVersion = "24.11"; # No Touch!
}
