{
  # Import all your configuration modules here
  imports = [ 
    ./bufferline.nix
    ./plugins/cmp.nix
    ./plugins/lsp/main.nix
    ./plugins/nvimtree.nix
    ./plugins/treesitter.nix
    ./plugins/telescope.nix

    # Mappings
    ./mappings/mappings.nix
  ];

  colorschemes.dracula.enable = true;

  plugins = {
    lualine.enable = true;
  };  

}
