{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        elixirls.enable = true;
        gleam.enable = true;
        gopls.enable = true;
        kotlin_language_server.enable = true;
        nixd.enable = true;
	#prolog-ls.enable = true;
        ruff.enable = true;
        ts_ls.enable = true;
      };
      keymaps.lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };
    lsp-lines = {
      enable = true;
      #currentLine = false;
    };
    rustaceanvim.enable = true;
  };
}
