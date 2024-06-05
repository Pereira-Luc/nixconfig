  
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

    ## Custom ZSH Theme Configuration
  };
}