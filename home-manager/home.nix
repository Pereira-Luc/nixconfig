{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./programs/urxvt.nix
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/kitty.nix
    inputs.nixvim.homeManagerModules.nixvim
    ./programs/nixvim.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zerix";
  home.homeDirectory = "/home/zerix";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

   nixpkgs.config.allowUnfree = true;


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.nerdfonts # For Nerd Fonts
    pkgs.nitrogen
    pkgs.dconf # required for gtk
    pkgs.tlaplusToolbox
    pkgs.discord
    pkgs.zoxide
    pkgs.tmux
    pkgs.bat
    pkgs.unzip
    pkgs.github-desktop
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.nixvim = { # this doesn't work
    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
      termguicolors = true;
    };
  };

  programs.zoxide = {
     enable = true;
     enableZshIntegration = true;
  };
  programs.bat.enable = true;

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


  gtk.enable = true;

  # Set the theme to Dracula
  gtk.theme.package = pkgs.dracula-theme;
  gtk.theme.name = "Dracula";

  # Set the icon theme to Dracula
  gtk.iconTheme.package = pkgs.dracula-icon-theme;
  gtk.iconTheme.name = "Dracula";

  # Set the cursor theme to breeze
  gtk.cursorTheme.package = pkgs.breeze-hacked-cursor-theme;
  gtk.cursorTheme.name = "breeze-hacked";



  # Enable the GNOME keyring daemon.
  services.gnome-keyring.enable = true;

  
  ## To search for a package, use the following link:
  # https://search.nixos.org/

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
