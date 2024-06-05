{
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings.sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
        {name = "luasnip";}
      ];

      settings.mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = ''
          cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif check_backspace() then
                fallback()
              else
                fallback()
              end
            end
          ,
          { "i", "s" }
        )
        '';
      };
    };
  };
}