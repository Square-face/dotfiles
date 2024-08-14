
{ config, pkgs, lib, ... }:

{
    programs.tmux = {
        enable = true;
        mouse = false;
        baseIndex = 1;
        plugins = with pkgs; [
            tmuxPlugins.sensible
            tmuxPlugins.cpu
            {
                plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
                    pluginName = "nova";
                    version = "unstable-2023-01-06";
                    src = pkgs.fetchFromGitHub {
                        owner = "o0th";
                        repo = "tmux-nova";
                        rev = "1.1.0";
                        sha256 = "1A7pnMMOwp1K7+WAAKbTqrMpm/wcorui6TQDHm8Xzd8=";
                    };
                };
                extraConfig = ''
                    set -g @nova-nerdfonts true
                    set -g @nova-nerdfonts-left 
                    set -g @nova-nerdfonts-right 

                    set -g @nova-pane-active-border-style "#44475a"
                    set -g @nova-pane-border-style "#282a36" 
                    set -g @nova-status-style-bg "#16161e"
                    set -g @nova-status-style-fg "#d8dee9"
                    set -g @nova-status-style-active-bg "#3b4261"
                    set -g @nova-status-style-active-fg "#7aa2f7"
                    set -g @nova-status-style-double-bg "#2d3540"

                    set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

                    set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
                    set -g @nova-segment-mode-colors "#7aa2f7 #2e3440"

                    set -g @nova-segment-whoami "#(whoami)@#h"
                    set -g @nova-segment-whoami-colors "#7aa2f7 #2e3440"

                    set -g @nova-rows 0
                    set -g @nova-segments-0-left "mode"
                    set -g @nova-segments-0-right "whoami"

                    set -g status-right '[#(TZ="Europe/Stockholm" date +"%%Y-%%m-%%d %%H:%%M")]'
                '';
            }
        ];
        extraConfig = ''
            # Smart pane switching with awareness of Vim splits.
            # See: https://github.com/christoomey/vim-tmux-navigator
            
            # decide whether we're in a Vim process
            is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
                | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

            bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
            bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
            bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
            bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

            bind-key -n M-Left send-keys M-b
            bind-key -n M-Right send-keys M-f

            tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

            if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
                "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
            if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
                "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

            bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

            bind-key -T copy-mode-vi 'C-h' select-pane -L
            bind-key -T copy-mode-vi 'C-j' select-pane -D
            bind-key -T copy-mode-vi 'C-k' select-pane -U
            bind-key -T copy-mode-vi 'C-l' select-pane -R
            bind-key -T copy-mode-vi 'C-\' select-pane -l
            bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+
        '';
    };
}
