{
  config,
  pkgs,
  lib,
  ...
}:

let
  writeScript = pkgs.writeShellScriptBin "sway-outputs" ''
    #! /usr/bin/env bash
    set -e
    outputs=( $(swaymsg -t get_outputs | ${pkgs.jq}/bin/jq -r 'sort_by(.rect.x) | .[].name') )
    primary=''${outputs[1]}
    secondary=''${outputs[2]:-''${outputs[1]}}
    swaymsg "
      set \$primary \"$primary\";
      set \$secondary \"$secondary\";
      workspace 1 output \$primary;
      workspace 2 output \$primary;
      workspace 3 output \$primary;
      workspace 9 output \$secondary;
      workspace 10 output \$secondary;
      workspace 1
      "
  '';
in
{
  home.packages = with pkgs; [
    writeScript
    jq
    hellwal
    brightnessctl

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

  home.file."${config.xdg.configHome}/swaylock/config".text = ''
    show-failed-attempts
    ignore-empty-password
    screenshots
    clock
    indicator-idle-visible
    indicator-radius=100
    indicator-thickness=7
    ring-color=11111b
    key-hl-color=89dceb
    text-color=cdd6f4
    line-color=f5e0dc00
    inside-color=181825ff
    separator-color=ff000000
    fade-in=0.5
    effect-scale=1
    effect-blur=7x3
    effect-scale=1
    effect-vignette=0.5:0.5
  '';

  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;
  programs.rofi = {
    terminal = "${pkgs.kitty}/bin/kitty";
    theme =
      let
        # Use `mkLiteral` for string-like values that should show without
        # quotes, e.g.:
        # {
        #   foo = "abc"; => foo: "abc";
        #   bar = mkLiteral "abc"; => bar: abc;
        # };
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          background-color = mkLiteral "#11111b";
          text-color = mkLiteral "#cdd6f4";
        };

        textbox-prompt-colon = {
          margin = mkLiteral "0px 0.3000em 0.0000em 0.0000em";
          expand = mkLiteral "false";
          str = ":";
          text-color = mkLiteral "inherit";
        };

        prompt = {
          content = "shize";
        };
        entry = {
          placeholder = "Search";
        };

        inputbar = {
          children = [
            "prompt"
            "entry"
            "case-indicator"
          ];
        };

        element = {
          orientation = "horizontal";
          children = [
            "element-icon"
            "element-text"
          ];
        };
        element-icon = {
          size = mkLiteral "2em";
        };
        element-text = {
          size = mkLiteral "1.5em";
        };
      };
  };

  programs.swaylock.enable = true;
  programs.swaylock.package = pkgs.swaylock-effects;

  services.swayidle =
    let
      # Lock command
      lock = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
      # TODO: modify "display" function based on your window manager
      # Sway
      display = status: "swaymsg 'output * power ${status}'";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 240; # in seconds
          command = "${pkgs.brightnessctl}/bin/brightnessctl set 50%-";
          resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl set +50%";
        }
        {
          timeout = 300;
          command = lock;
        }
        {
          timeout = 600;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 900;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          # adding duplicated entries for the same event may not work
          command = (display "off") + "; " + lock;
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = (display "off") + "; " + lock;
        }
        {
          event = "unlock";
          command = display "on";
        }
      ];
    };

  services.way-displays.enable = true;
  services.way-displays.settings = {
    SCALING = false;
    VRR_OFF = [ "0x07C9" ];
  };

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
        dmenu = "${pkgs.rofi-wayland}/bin/rofi --show dmenu -p dunst";
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

  wayland.windowManager.sway = {
    enable = true;
    # package = pkgs.swayfx;
    xwayland = true;
    config = {
      modifier = "Mod4";
      menu = "${pkgs.rofi-wayland}/bin/rofi -show drun";
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
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
          "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
        };
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

      input = {

        "*" = {
          pointer_accel = "-0.3";
          xkb_layout = "se";
          xkb_options = "ctrl:nocaps";
        };
      };
    };
    # extraConfig = ''
    #   exec_always ${writeScript}/bin/sway-outputs
    # '';
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.pkgs.bibata-cursors;
  };

  programs.waybar.enable = true;
}
