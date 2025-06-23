{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git-credential-oauth
  ];

  xdg = {
    enable = true;
    portal = {
      enable = true;
      config.sway.default = [
        "wlr"
        "gtk"
      ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  programs.starship.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "SPACE";
    baseIndex = 1;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha' # latte, frappe, macchiato or mocha
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_text " #W"
          set -g @catppuccin_window_current_style "rounded"
          set -g @catppuccin_window_current_text " #W"

          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:#H}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
        '';
      }
    ];
    extraConfig = ''
      set -g status-interval 0
      set -s escape-time 0
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      v = "${pkgs.neovim}/bin/nvim";

      ls = "eza";
      la = "eza -a";
      ll = "eza -l";
      lt = "eza -T";
      l = "eza -la";

      g = "git";

      wget = "wget --hsts-file=\"\$XDG_CACHE_HOME/wget-hsts\"";

      tmpcd = "cd $(mktemp -d)";
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

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };

  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    settings = {
      use-agent = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-tty;
  };

  programs.git = {
    enable = true;
    aliases = {
      pu = "push";
      pl = "pull";
      plr = "pull --rebase";

      ra = "rebase --abort";

      s = "status";

      d = "diff";
      dc = "diff --cached";

      aa = "add .";

      cm = "commit -m"; # Commit with Message
      ca = "commit --amend --no-edit"; # Commit Amend
      ce = "commit --amend"; # Commit amend with Edit

      lg = "log --graph --all --oneline";
      lf = "log --graph --all --pretty=format:'%C(auto)%h%Creset %C(dim white)%an%Creset %G? %s %C(dim white)- %ar%Creset'";
    };
    extraConfig = {
      gpg.program = "${pkgs.gnupg}/bin/gpg";
      init.defaultBranch = "main";
    };
  };
}
