{
  lib,
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

}
