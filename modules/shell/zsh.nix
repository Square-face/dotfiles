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

      # ls = "eza";
      # la = "eza -a";
      # ll = "eza -l";
      # lt = "eza -T";
      # l = "eza -la";

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
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    autocd = true;
  };
}
