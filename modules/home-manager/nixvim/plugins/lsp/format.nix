{
  plugins = {
    lsp-format = {
      enable = true;

      lspServersToEnable = [
        "nixd"
        "tsserver"
      ];
    };
  };
}
