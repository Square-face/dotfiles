{lib, config, pkgs, ...}: {
    options = {
        podman.enable = lib.mkEnableOption "Enable Docker";
        libvirtd.enable = lib.mkEnableOption "Enable Libvirtd";
    };

    config = let
        cfg = config;
        podman = lib.mkIf cfg.podman.enable {
            virtualisation.podman = {
                enable = true;
                dockerCompat = true;
            };
        };
        libvirt = lib.mkIf cfg.libvirtd.enable {
          virtualisation.libvirtd = {
            enable = true;
            qemu = {
              package = pkgs.qemu;
              runAsRoot = true;
              swtpm.enable = true;
            };
          };
          virtualisation.spiceUSBRedirection.enable = true;
        };
    in lib.recursiveUpdate podman libvirt;
}
