{self,pkgs, ...}:
{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = coc-nvim;
      config = '' '';
    }
  ];
}
