{ lib, config, pkgs, ... }: {
    options = {
        sq8.enabled = lib.mkEnableOption "Enable SQ8 User";
        ultra.enabled = lib.mkEnableOption "Enable ULTRA User";
    };
    config = let
        sq8 = lib.mkIf config.sq8.enabled {
            users.users.sq8 = {
                isNormalUser = true;
                shell = pkgs.zsh;
                description = "Linus Michelsson";
                openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPP9DFLLWEmyjcIJYXrPJEgV7Mk6eLwm60bPLJstiakl linus@sq8.dev"
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN5D+pEdcsfKqDe54yG92GPpm8X9PP3H4M7idvgGrs2G linus@sq8.dev"
                ];
                extraGroups = [
                    "networkmanager"
                    "seat"
                    "video"
                    "audio"
                    "libvirtd"
                    "kvm"
                    "wheel"
                    "podman"
                ];
            };
        };

        ultra = lib.mkIf config.ultra.enabled {
            users.users.ultra = {
                isNormalUser = true;
                shell = pkgs.zsh;
                description = "Casper Medin Jensen";
                openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIufvkDkpyHPWr8zjPtSFShNl25136YWMufD9/AtIjMv ultra@trallalero"
                ];
                extraGroups = [
                    "networkmanager"
                    "seat"
                    "video"
                    "audio"
                    "libvirtd"
                    "kvm"
                    "wheel"
                    "podman"
                ];
            };
        };
    in lib.mkMerge [
  sq8
  ultra
];
}
