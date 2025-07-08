{

  boot.loader.timeout = 10;
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    memtest86.enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
