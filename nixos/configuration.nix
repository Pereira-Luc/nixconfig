# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.erosanix.nixosModules.protonvpn
    ];

  # Add Java
  programs.java = { enable = true; package = pkgs.openjdk; };
  
  # Setupf for Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };

    users = {
      zerix = import ../home-manager/home.nix;
    };
  };

  

  #################################### awesomeWM config ##############################################
  # Overlays are a way to override attributes of packages. This is often useful
  nixpkgs.overlays = [  
  (final: prev: {
      awesomeGit = prev.awesome.overrideAttrs (old:  {
        pname = "awesomeGit";
        src = prev.fetchFromGitHub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "d36e1324d17efd571cec252374a2ef5f1eeae4fd";
          hash = "sha256-zCxghNGk/GsSt2+9JK8eXRySn9pHXaFhrRU3OtFrDoA=";
        };
        patches = [];

        postPatch = ''
          patchShebangs tests/examples/_postprocess.lua
        '';
      });
    })

    (final: prev:{
      inputs.nixvim.url = "github:nicolas-goudry/nixvim-config";

      outputs = { nixvim, ... }: {
        overlays.additions = final: prev: {
          nixvim = nixvim.packages.${prev.system}.default;

          # Or use the lite version
          # nixvim = nixvim-config.packages.${_prev.system}.lite;
        };
      };
    })
  ];

  services.xserver.windowManager.awesome = {
   enable = true;
   package = pkgs.awesomeGit;
   luaModules = with pkgs.luaPackages; [ luarocks luadbi-mysql ];
  };

  services.picom = {
    enable = true;

    fade = true;
    fadeSteps = [0.03 0.03];
    fadeDelta = 4;

    activeOpacity = 1;
    inactiveOpacity = 0.95;

    opacityRules = [
      "95:class_g = 'Rofi'"
      "95:class_g = 'kitty'"
      "100:class_g = 'Code'"
      "95:class_g = 'Spotify'"
      "95:class_g = 'discord'"
      "95:class_g = 'Thunar'"
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
 
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #################################### awesomeWM config ##############################################
  #################################### HyperLand config ##############################################
   # programs.hyprland = {
   #   enable = false;
   #   xwayland.enable = true;
   # };

   # environment.sessionVariables = {
   #   WLR_NO_HARDWARE_CURSORS = "1";
   #   NIXOS_OZONE_WL = "1";
   # };

  #xdg.portal.enable = true;
  # xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk ];
   # services.pipewire = {
   #    enable = true;
   #    alsa.enable = true;
   #    alsa.support32Bit = true;
   #    pulse.enable = true;
   #    jack.enable = true;
   # };
  ################################### HyperLand config ###############################################

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Luxembourg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  


  # Nvidia Stuff
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia-container-toolkit.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  nixpkgs.config.cudaSupport = true;
  
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Gaming Stuff
  programs.steam.enable = true;
  programs.steam.gamescopeSession = {
     enable = true;
     args = [ "-W 2560" "-H 1440" "-r 240" "" ];
  };
  

  # Enable the Deepin Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.deepin.enable = true;

  services.displayManager.sddm.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
      

   extraConfig.pipewire.adjust-sample-rate = {
       "context.properties" = {
         "default.clock.rate" = 48000;
         "defautlt.allowed-rates" = [ 192000 48000 44100 ];
         #"defautlt.allowed-rates" = [ 192000 ];
         #"default.clock.quantum" = 32;
         #"default.clock.min-quantum" = 32;
         #"default.clock.max-quantum" = 32;
       };
     };
  };

  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zerix = {
    isNormalUser = true;
    description = "ZERIX";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "zerix" ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    brave
    alacritty
    home-manager
    vscode
    neofetch
    rofi
    gnome.gnome-keyring
    polkit_gnome
    syncthing
    ripgrep
    pavucontrol
    xorg.xbacklight
    openvpn
    openresolv
    update-resolv-conf
    xclip
    mangohud
    unigine-heaven
    gamescope-wsi
    zed-editor
    easyeffects
    gimp
    inkscape
    micromamba

    jetbrains.pycharm-professional

    wireguard-tools
    nvtopPackages.nvidia
    xdg-desktop-portal-gtk

    vlc

    #cachix

    gnome.mutter
    btop
    stress-ng

    #nodePackages.canvas
    nodePackages.typescript

    # Requirment for FlatPak
    # For HyperLand
     # waybar
     # dunst
     # libnotify
     # rofi-wayland
    ryujinx

    #cudaPackages.cuda_nvcc


    ## For GPU passthrough
    virt-manager
    busybox
    procps gnumake util-linux m4 gperf unzip
    cudaPackages.cudatoolkit
    cudaPackages.cudatoolkit-legacy-runfile
    #binutils
  
    #linuxPackages.nvidia_x12
    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 
    ncurses5 stdenv.cc binutils
    nix-ld 

    patchelf
    addOpenGLRunpath
  ];

virtualisation.libvirtd = {
  enable = true;
  qemuOvmf = true;
  qemuRunAsRoot = false;
  onBoot = "ignore";
  onShutdown = "shutdown";
};
programs.virt-manager.enable = true;

  ############################### VPN STUFF ####################################
  
  
  ##############################################################################


  services.flatpak.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  # NeoVim Settings
  environment.variables.EDITOR = "nvim";
  
  environment.variables = {
    CUDA_PATH = "${pkgs.cudatoolkit}";
    CPLUS_INCLUDE_PATH = "${pkgs.cudatoolkit}/include";
    #LIBRARY_PATH = "${pkgs.cudatoolkit}/lib";
    #EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    #EXTRA_CCFLAGS="-I/usr/include";
    #LD_LIBRARY_PATH="${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib";
    #LD_LIBRARY_PATH = "${pkgs.linuxPackages.nvidia_x11}/lib:/run/opengl-driver/lib:${pkgs.cudatoolkit}/lib:${pkgs.ncurses5}/lib";
    #LD_LIBRARY_PATH = lib.mkDefault "/nix/store/ys7psw9r5964i4zs6cn7rmmkk6572wmd-pipewire-1.2.5-jack/lib:${pkgs.linuxPackages.nvidia_x11}/lib:/run/opengl-driver/lib:${pkgs.cudatoolkit}/lib:${pkgs.ncurses5}/lib";
  };

  programs.thunar.enable = true;

  programs.xfconf.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.gvfs.enable = true;
  services.tumbler.enable = true;


  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages

  ];


  networking.firewall.enable = true;

  networking.firewall.allowedUDPPorts = [80 443];
  networking.firewall.allowedTCPPorts = [80 443];

  system.stateVersion = "24.05"; # Did you read the comment?
}
