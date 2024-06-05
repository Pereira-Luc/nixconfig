{config, pkgs, ...}:
{
  # Kitty terminal emulator
  programs.kitty = {
    enable = true;
    theme = "Dracula";
    font.name = "FiraCodeNerdFont";
    font.size = 12;
  };
}