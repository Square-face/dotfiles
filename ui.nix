{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    hellwal
    waypaper

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    font-awesome
    source-han-sans
    source-han-sans-japanese
    source-han-serif-japanese
    nerd-fonts.fira-code

    magnetic-catppuccin-gtk
    papirus-icon-theme
    bibata-cursors
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
    KUBECONFIG = "${config.xdg.configHome}/kube";
    KUBECACHEDIR = "${config.xdg.cacheHome}/kube";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    WINEPREFIX = "${config.xdg.dataHome}/wineprefixes";
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Source Han Serif"
        ];
        sansSerif = [
          "Noto Sans"
          "Source Han Sans"
        ];
      };
    };
  };

  home.file.".config/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Catppuccin-GTK-Dark
    gtk-icon-theme-name=Papirus-Dark
    gtk-cursor-theme-name=Bibata-Modern-Classic
    gtk-font-name=Sans 10
  '';

  home.file.".config/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Catppuccin-GTK-Dark
    gtk-icon-theme-name=Papirus-Dark
    gtk-cursor-theme-name=Bibata-Modern-Classic
  '';

  programs.wofi.enable = true;
  programs.swaylock.enable = true;
  programs.swaylock.package = pkgs.swaylock-effects;

  services.swww.enable = true;
  services.dunst = {
    enable = true;

    settings = {
      global = {
        monitor = 1;
        font = "FiraCode 10";
        progress_bar_corner_radius = 5;
        corner_radius = 5;
        origin = "bottom-right";
        offset = "(30, 25)";
        separator_color = "#cdd6f4";
        frame_width = 0;
        dmenu = "/usr/bin/wofi --show dmenu -p dunst";
      };

      urgency_low = {
        frame_color = "#74c7ec";
        background = "#313244";
        foreground = "#cdd6f4";
        highlight = "#89b4fa, #a6e3a1";
      };

      urgency_normal = {
        frame_color = "#74c7ec";
        background = "#313244";
        foreground = "#cdd6f4";
        highlight = "#89b4fa, #a6e3a1";
      };

      urgency_critical = {
        background = "#eba0ac";
        foreground = "#cdd6f4";
        highlight = "#89b4fa, #a6e3a1";
      };

      # Filters are specified as sections
      "filter" = {
        appname = "Spotify";
        min_icon_size = 64;
        max_icon_size = 64;
        urgency = "low";
        history_ignore = true;
      };
    };
  };

  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "default";
        profile.outputs = [
          {
            criteria = "HDMI-A-1";
            scale = 1.0;
            position = "0,420";
          }
          {
            criteria = "DP-2";
            transform = "90";
            position = "2560,0";
          }
        ];
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    # package = pkgs.swayfx;
    xwayland = true;
    config = {
      modifier = "Mod4";
      menu = "${pkgs.wofi}/bin/wofi --show drun";
      terminal = "kitty";
      startup = [
        { command = "waypaper --restore"; }
      ];
      bars = [
        { command = "waybar"; }
      ];
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+shift+s" = "exec grim -g \"\$(slurp -d)\" -t png - | wl-copy -t image/png";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioPlay" = "exec playerctl play-pause";
        };
      workspaceOutputAssign = [
        {
          output = "HDMI-A-1";
          workspace = "1";
        }
        {
          output = "HDMI-A-1";
          workspace = "2";
        }
        {
          output = "HDMI-A-1";
          workspace = "3";
        }

        {
          output = "DP-2";
          workspace = "10";
        }
        {
          output = "DP-2";
          workspace = "9";
        }
      ];
      assigns = {
        "2" = [ { app_id = "firefox"; } ];
        "10" = [
          { class = "Spotify"; }
          { class = "vesktop"; }
          { class = "Element"; }
        ];
      };
      defaultWorkspace = "1";
      window.titlebar = false;
      gaps = {
        smartBorders = "off";
        outer = 3;
        inner = 5;
      };
    };
    extraConfig = ''
      input * {
          xkb_layout "se"
          xkb_options ctrl:nocaps
      }
    '';
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.pkgs.bibata-cursors;
  };

  programs.waybar.enable = true;
}
