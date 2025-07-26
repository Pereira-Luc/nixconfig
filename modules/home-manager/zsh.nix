{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        flakeDir = "~/.config/nixos/";
      in {
        sw = "nh os switch";
        upd = "nh os switch --update";
        hms = "nh home switch";
	
	      nixreload = "sudo nixos-rebuild switch --flake ~/.config/nixos/#mainNixos";
      	nixupdate = "cd ~/.config/nixos/ && sudo nix flake update";

        pkgs = "nvim ${flakeDir}/nixos/packages.nix";

        r = "ranger";
        v = "nvim";
        se = "sudoedit";
        microfetch = "microfetch && echo";

        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";

        ".." = "cd ..";
        c = "clear";
        ls = "exa --icons --long --group-directories-first";
        l = "exa --icons --long --group-directories-first --tree";
        cd = "z";
      };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initContent = ''
      
      export QT_STYLE_OVERRIDE=Fusion
    '';
  };
}
