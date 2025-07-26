# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx.enable = true;

  networking.hostName = "Burner"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.duplicati = {
   enable = true;
   # It's best to run this as your own user.
   # This user needs read access to the files you want to back up.
   user = "zerix";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Luxembourg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
 
  # NVIDIA STUFF
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.hardware.openrgb.enable = true;
  services.udisks2.enable = true;

  # nixpkgs.overlays = [
  #   (final: prev: {
  #    mpv-unwrapped = prev.mpv-unwrapped.override {
  #   libplacebo = final.libplacebo-mpv;
  #   };
  #   libplacebo-mpv =
  #     let
  #       version = "7.349.0";
  #     in
  #     prev.libplacebo.overrideAttrs (old: {
  #       inherit version;
  #       src = prev.fetchFromGitLab {
  #         domain = "code.videolan.org";
  #         owner = "videolan";
  #         repo = "libplacebo";
  #         rev = "v${version}";
  #         hash = "sha256-mIjQvc7SRjE1Orb2BkHK+K1TcRQvzj2oUOCUT4DzIuA=";
  #       };
  #     });
  #   })
  # ];


  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #withUWSM = true;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true; # Enable XWayland support
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    QT_STYLE_OVERRIDE = "Fusion"; # This fixes plex\
    GBM_BACKEND="nvidia-drm";
    MOZ_ENABLE_WAYLAND=1;
    __GLX_VENDOR_LIBRARY_NAME="nvidia";
    DXVK_HDR=1;
    ENABLE_HDR_WSI=1;
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    WLR_BACKEND="vulkan";
    LIBVA_DRIVER_NAME="nvidia";
    NVD_BACKEND="direct";
  };

  # enable flat pack 
  services.flatpak.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {

      # Modesetting is required.
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;

      
    };
    graphics = {
      #driSupport = true;
      #driSupport32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };    

  


  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zerix = {
    isNormalUser = true;
    description = "zerix";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Init HomeManager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };

    users = {
      zerix = import ./home.nix;
    };
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

  chaotic.hdr.enable = true;

  # STUFF for plex
  #xdg.portal.enable = true;
  #xdg.portal.xdgOpenUsePortal = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    brave
    git
    pciutils   
    #vulkan-loader
    vulkanPackages_latest.vulkan-loader
    vulkan-validation-layers
    #vulkan-tools 
    vulkanPackages_latest.vulkan-tools
    #mesa_git
    vulkanPackages_latest.vulkan-validation-layers
    vulkan-hdr-layer-kwin6
    #egl-wayland 
    fastfetch
    pavucontrol
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    cloc


    code-cursor-fhs
    vlc
    libva-utils
    libliftoff
    libdrm_git

    alsa-utils

    # Keyring stuff
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
  ];

  # Keyring stuff
  services.dbus.enable = true;

  security.pam.services.login.kwallet = {
    enable = true;
    # Explicitly specify the package providing the PAM module.
    package = pkgs.kdePackages.kwallet-pam;
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ 
  #     pkgs.xdg-desktop-portal-gtk
  #     pkgs.kdePackages.xdg-desktop-portal-kde 
  #     #pkgs.xdg-desktop-portal-hyprland
  #     ];
  #   xdgOpenUsePortal = true;
  # };

  xdg.portal = {
      config = {
        hyprland.default = [ "hyprland" "gtk" "gnome" "termfilechooser" ];
        hyprland."org.freedesktop.portal.FileChooser" = [ "termfilechooser" ];
        hyprland."org.freedesktop.portal.OpenURI" = [ "termfilechooser" ];
      };

      extraPortals = with pkgs; [
        #hyprlandPackages.xdg-desktop-portal-hyprland
        xdg-desktop-portal-termfilechooser
      ];
    };


    

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
   enable = true;
   allowedTCPPorts = [ 8000 ];  # Add more ports here if needed, e.g., [ 22 8000 ] for SSH too
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
