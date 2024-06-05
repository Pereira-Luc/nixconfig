{config, pkgs, ...}:
{
  # GitHub Configuration
  programs.git = {
    enable = true;
    userName = "Pereira-Luc";
    userEmail = "luc.pereira.cardoso@gmail.com";
    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
      br = "branch";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      l = "log --oneline --decorate --all --graph";
    };
  };

}