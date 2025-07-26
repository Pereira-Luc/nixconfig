{
  programs.nixvim = {
    enable = true;
    # Import all your configuration modules here
    imports = [ 
      ./bufferline.nix
      ./plugins/cmp.nix
      ./plugins/lsp/main.nix
      ./plugins/lsp/lint.nix
      ./plugins/nvimtree.nix
      ./plugins/treesitter.nix
      ./plugins/telescope.nix
      ./plugins/other.nix
      ./plugins/custom.nix
      

      # Extras
      ./plugins/extrapkgs.nix
      ./plugins/indetBlankline.nix

      # Mappings
      ./mappings/mappings.nix

      #options
      ./options.nix

      # Foemating
      ./plugins/lsp/format.nix
    ];

    colorschemes.dracula.enable = true;

    plugins = {
      lualine.enable = true;
    };  
  };
}
