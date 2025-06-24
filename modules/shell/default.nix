{ ... }:
{
  imports = [
    ./tmux.nix
    ./gpg.nix
    ./zsh.nix
  ];

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };
}
