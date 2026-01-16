{ pkgs, ... }: {
    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
    };

    environmetn.systemPackages = [pkgs.distrobox];
}
