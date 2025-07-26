{ config, pkgs, inputs, ... }:

{
  imports = [
    #../../modules/home-manager/terminal/zsh.nix
    ../../modules/home-manager/default.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zerix";
  home.homeDirectory = "/home/zerix";

  nixpkgs.config.allowUnfree = true;

  # environment variables 

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.vscode

    # Steam stuff
    pkgs.steam

    # hyprland packages
    pkgs.kitty
    pkgs.waybar
    pkgs.wofi
    pkgs.tmux
    pkgs.btop
    pkgs.plex-desktop
    pkgs.kdePackages.dolphin
    pkgs.cifs-utils
    pkgs.plex-mpv-shim
    pkgs.jellyfin-media-player
    pkgs.jellyfin-mpv-shim
    pkgs.mpv
    pkgs.lsof 
    pkgs.unzip
    # wine stuff
    pkgs.wine64
    pkgs.winetricks
    pkgs.discord
    pkgs.obsidian
    #pkgs.wineWowPackages.waylandFull

    # nodejs stuff
    pkgs.nodejs
    pkgs.yarn
    pkgs.postman

    # Backup Stuff
    pkgs.duplicati

    # Python stuff
    #pkgs.conda
    #pkgs.micromamba
    (pkgs.python3.withPackages (ppkgs: [
      ppkgs.numpy
      ppkgs.pyautogui
      ppkgs.pynput
      ppkgs.pygame
      ppkgs.pip
      ppkgs.jupyter
      ppkgs.ipykernel
      ppkgs.pandas
      ppkgs.matplotlib
      ppkgs.scipy
      ppkgs.scikit-learn
      ppkgs.scikit-image
      ppkgs.sympy
      ppkgs.seaborn
      #ppkgs.tensorflow
      #ppkgs.keras
      ppkgs.nibabel

      # For Slurmify
      ppkgs.fastapi
      ppkgs.streamlit
      ppkgs.uvicorn
    ]))
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
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  # Backup Stuff
 

  #  home.file.".local/bin/conda" = {
  #   executable = true;
  #   text = ''
  #     #!/bin/sh
  #     # This script executes micromamba, passing along all arguments.
  #     exec ${pkgs.micromamba}/bin/micromamba "$@"
  #   '';
  # };

  # # 3. Add the script's directory to your PATH
  # home.sessionPath = [
  #   "$HOME/.local/bin"
  # ];
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zerix/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
	
  programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
  };
  programs.bat.enable = true;



  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu-next";
      target-colorspace-hint = "";
      gpu-api = "vulkan";
      gpu-context = "waylandvk";

      ao = "alsa";
      audio-device = "alsa/hdmi:CARD=NVidia,DEV=0";
      audio-spdif = "ac3,eac3,dts,dts-hd,truehd";
    };
  };

  services.plex-mpv-shim = {
    enable = false;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
