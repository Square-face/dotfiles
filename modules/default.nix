{...}: {
    imports = [
        ./ssh.nix
        ./audio.nix
        ./virtualisation.nix
        ./tlp.nix
        ./grub.nix
        ./locale.nix
        ./system.nix
        ./services.nix
	./users.nix
    ];
}
