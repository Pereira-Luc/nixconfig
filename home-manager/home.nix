{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./programs/urxvt.nix
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/kitty.nix
    inputs.nixvim.homeManagerModules.nixvim
    ./programs/nixvim.nix
    ./programs/tmux.nix
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
  home.stateVersion = "24.05"; # Please read the comment before changing.

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
    pkgs.zip
    pkgs.github-desktop
    pkgs.plex-media-player
    pkgs.nodejs_22
    pkgs.okular
    pkgs.libreoffice
    pkgs.flameshot
    pkgs.obsidian
    pkgs.binutils
    pkgs.alsa-utils

    pkgs.google-chrome
    #pkgs.ryujinx

    pkgs.libgcc
    pkgs.gcc
    pkgs.gnumake
    pkgs.jetbrains.webstorm
    pkgs.protonvpn-gui

    (pkgs.python311.withPackages (ppkgs: [
      ppkgs.numpy
      ppkgs.pyautogui
      ppkgs.pynput
      ppkgs.pygame
      ppkgs.pip
      ppkgs.jupyter
      ppkgs.ipykernel
    ]))

    ## Stuff for gpu passthrough VM
    pkgs.qemu_kvm

    ## Stuff for cpp
    pkgs.clang-tools
    pkgs.gcc
    pkgs.libcxx

    #pkgs.cudatoolkit
    #pkgs.haskellPackages.cuda



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


## for gpu pass 
dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};

  home.sessionVariables = {
    EDITOR = "nvim";
  };


  programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
  };
  programs.bat.enable = true;

  gtk.enable = true;

  # Set the theme to Dracula
  gtk.theme.package = pkgs.dracula-theme;
  gtk.theme.name = "Dracula";

  # Set the icon theme to Dracula
  gtk.iconTheme.package = pkgs.dracula-icon-theme;
  gtk.iconTheme.name = "Dracula";

  # Set the cursor theme to breeze
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  # Enable the GNOME keyring daemon.
  services.gnome-keyring.enable = true;

  
  ## To search for a package, use the following link:
  # https://search.nixos.org/

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
