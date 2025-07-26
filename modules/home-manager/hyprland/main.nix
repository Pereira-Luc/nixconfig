{ config,
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    extraConfig = ''
      # KWallet auto-unlock integration:
      # This command completes the PAM handshake within the user session.
      # The path is interpolated by Nix at build time for robustness.
      exec-once = ${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init
    '';
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        #"NIXOS_OZONE_WL,1"
        #"XDG_CURRENT_DESKTOP,Hyprland"
        #"XDG_SESSION_TYPE,wayland"
        #"XDG_SESSION_DESKTOP,Hyprland"
        #"QT_QPA_PLATFORM,wayland"
        #"XDG_SCREENSHOTS_DIR,$HOME/screens"
        "QT_STYLE_OVERRIDE,Fusion"
      ];

      
      monitor = "DP-4,5120x1440@240,auto,1,bitdepth, 10";
      #monitor = "DP-4,5120x1440@240,auto,1,bitdepth, 10, cm, hdr, sdrbrightness, 1.1, sdrsaturation, 0.98";
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "$terminal -e sh -c 'ranger'";
      "$menu" = "wofi";
      "$render" = "{ cm_enabled = true }";

      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        
      ];

      general = {
        gaps_in = 15;
        gaps_out = 15;

        border_size = 5;

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 0.9;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = true;
        };
      };

      animations = {
        enabled = true;
      };

      input = {
        kb_layout = "us,ru,il";
        kb_options = "grp:caps_toggle";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_invert = false;
        workspace_swipe_forever	= true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
        orientation = "center";
        always_keep_position = true;
        slave_count_for_center_master = 0;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[t1]"

        "float,class:(mpv)|(imv)|(showmethekey-gtk)"
        "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
        "noborder,nofocus,class:(showmethekey-gtk)"

        "workspace 3,class:(obsidian)"
        "workspace 3,class:(zathura)"
        "workspace 4,class:(com.obsproject.Studio)"
        "workspace 5,class:(telegram)"
        "workspace 5,class:(vesktop)"
        "workspace 6,class:(teams-for-linux)"

        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
      ];

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
    };
  };
}
