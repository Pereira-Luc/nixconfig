{
  config,
  pkgs,
  inputs,
  ...
}:
let
  neovimconfig = import ./configs/nixvim ;
  nvim = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
    inherit pkgs;
    module = neovimconfig;
  };
in 
{
  home.packages = with pkgs; [
    nvim
  ];
}