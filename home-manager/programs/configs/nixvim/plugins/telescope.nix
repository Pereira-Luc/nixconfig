{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>fw" = "live_grep";
      "<leader>ff" = "find_files";
    };

    extensions.fzf-native = { enable = true; };
  };
}