{ pkgs, ... }:
{
  system.stateVersion = 4;

  users.users.sq8 = {
    shell = pkgs.zsh;
    description = "Linus Michelsson";
  };
}
