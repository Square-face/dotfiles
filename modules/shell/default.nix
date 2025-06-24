{ ... }:
{
  imports = [
    ./git.nix
    ./tmux.nix
    ./gpg.nix
    ./zsh.nix
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

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
