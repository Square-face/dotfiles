{ pkgs, ... }:
{
  imports = [
    ./base.nix
  ];
  system.stateVersion = 5;

  users.users.sq8 = {
    home = "/Users/sq8";
    shell = pkgs.zsh;
    description = "Linus Michelsson";
  };

  home-manager.users.sq8 = {
    imports = [
      ./home.nix
      ../modules/shell/gpg.nix
      ../modules/shell/eza.nix
      ../modules/shell/zsh.nix
      ../modules/shell/tmux.nix
      ../modules/dev
    ];
  };
}
