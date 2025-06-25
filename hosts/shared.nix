{
  lib, pkgs,
  ...
}:

{

  # Zerotier
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "zerotierone"
    ];
  services.zerotierone.enable = true;
  services.zerotierone.joinNetworks = [ "272f5eae163890e5" ];

  nix.settings = {
    use-xdg-base-directories = true;
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];

  };
}
