  
  { config, pkgs, ... }:

{
  # zsh Configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      nixreload = "sudo nixos-rebuild switch --flake ~/.config/nixconfig/#mainNixos";
      nixupdate = "cd ~/.config/nixconfig/ & sudo nix flake update";
      wb = "python /home/zerix/Documents/Dev/webpConverter/webpConverter.py";
      cat = "bat";
      cd = "z";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "simple";
    };
    initExtra = ''
      if [ -z "$TMUX" ]; then
        exec tmux 
      fi
    '';
  };
}
