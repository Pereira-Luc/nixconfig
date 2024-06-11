{config, pkgs, ...}:
{
  programs.tmux = {
    enable = true;

    plugins = with pkgs; [
        tmuxPlugins.dracula 
    ];

    extraConfig = ''
        set -g default-shell $SHELL
        set -g default-terminal "xterm-256color"

        set -g mouse on
        set -g history-limit 50000
        set -g display-time 4000
        set -g status-interval 5
        set -g focus-events on
        setw -g aggressive-resize on
        set -s escape-time 0 # needed so the escape key works properly in Vim

        # Fix colors
        set-option -sa terminal-overrides ",xterm*:Tc"

        # Indexing
        set -g renumber-windows on
        set -g pane-base-index 1
        set -g base-index      1

        # Prefix
        unbind C-b
        set -g prefix C-a
        bind C-a send-prefix

        # Clear history
        # bind -n C-l send-keys -R \; send-keys C-l \; clear-history

        # Reload
        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

        # New pane/window
        bind s split-window -h -c "#{pane_current_path}"
        bind v split-window -v -c "#{pane_current_path}"
        bind n new-window -c "#{pane_current_path}"

        # Kill pane/window
        bind w confirm-before "kill-window"
        bind q "kill-pane"

        # Change window 
        bind [ previous-window
        bind ] next-window

        # Swap windows 
        bind C-] swap-window -d -t +1
        bind C-[ swap-window -d -t -1

        # Change pane
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Vim keys -- TODO: test
        setw -g mode-keys vi
        bind -T copy-mode-vi v   send-keys -X begin-selection
        bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind -T copy-mode-vi y   send-keys -X copy-selection-and-cancel

        # Switch to marked pane
        bind \` switch-client -t '{marked}'

        # Resize panes
        bind -r C-h resize-pane -L 5
        bind -r C-j resize-pane -D 5
        bind -r C-k resize-pane -U 5
        bind -r C-l resize-pane -R 5

        # TODO: detaching + glueing
        # Join (glue) pane
        # bind g choose-window 'join-pane -s "%%" -h'
        # bind G choose-window 'join-pane -s "%%"'

        # Show all sessions
        bind a choose-tree -Zs
      '';
  };
}