{...}: {
    networking.hostName = "airhead";
    networking.computerName = "airhead";

    imports = [
    ../../profiles/mac.nix
    ];
}
