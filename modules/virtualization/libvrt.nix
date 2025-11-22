{ pkgs, ... }:
{

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
}
