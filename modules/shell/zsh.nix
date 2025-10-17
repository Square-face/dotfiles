{ config, pkgs, ... }:
{
  # Prompt
  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      v = "${pkgs.neovim}/bin/nvim";

      g = "git";

      wget = "wget --hsts-file=\"\$XDG_CACHE_HOME/wget-hsts\"";

      tmpcd = "cd $(mktemp -d)";
      tmpv = "${pkgs.neovim}/bin/nvim $(mktemp -d)";
    };
    initContent = ''
      nixz() {
          nix-shell -p "$@" --run zsh
      }
    '';
    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      ignoreAllDups = true;

    };
    historySubstringSearch.enable = true;
    autocd = true;
  };
}
