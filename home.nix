{
  pkgs,
  lib,
  config,
  ...
}:

let
  username = "sq8";
in
{
  imports = [
    ./modules
    ./ui.nix
  ];

  home.sessionVariables =
    let
      xdg = {
        config = config.home.sessionVariables.XDG_CONFIG_HOME;
        data = config.home.sessionVariables.XDG_DATA_HOME;
        state = config.home.sessionVariables.XDG_STATE_HOME;
      };
    in
    {
      PYTHON_HISTORY = "${xdg.state}/python/history";
      DOCKER_CONFIG = "${xdg.config}/docker";
      RUSTUP_HOME = "${xdg.data}/rustup";
      CARGO_HOME = "${xdg.data}/cargo";
      WAKATIME_HOME = "${xdg.data}/wakatime";
    };

  home.packages = with pkgs; [

    # Virtualization tools
    virt-manager
    qemu

    # games
    prismlauncher
  ];

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
}
