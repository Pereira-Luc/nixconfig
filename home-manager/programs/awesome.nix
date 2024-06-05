{ config, pkgs, ... }:


# This is not used config is inside of configuration.nix
{
  services.xserver = {
    enable = true;

    displayManager.defaultSession = "awesome";
    windowManager.awesome = {
      enable = true;
      package = pkgs.awesomeGit;
      luaModules = with pkgs.luaPackages; [ luarocks luadbi-mysql ];
    };
  };

  #services.picom.enable = true;
}