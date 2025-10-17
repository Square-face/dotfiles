{
  lib,
  pkgs,
  ...
}:
let
  wdisplays = pkgs.stdenv.mkDerivation (finalAttrs: {
    pname = "wdisplays";
    version = "1.1.1";

    nativeBuildInputs = with pkgs; [
      meson
      ninja
      pkg-config
      wrapGAppsHook3
      wayland-scanner
    ];

    buildInputs = with pkgs; [
      gtk3
      libepoxy
      wayland
    ];

    src = pkgs.fetchFromGitHub {
      owner = "artizirk";
      repo = "wdisplays";
      rev = "25211d7327c95748775f41017f78a92245f53c7e";
      sha256 = "sha256-q9aGDgt/KH+xnBB+9U0RP2GB4+VA/vYLYceUz1Grf3k=";
    };
  });
in
{
  home.packages = [
    wdisplays
  ];
}
