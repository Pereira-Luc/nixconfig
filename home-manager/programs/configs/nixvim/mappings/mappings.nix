{ 
  # Global Keybindings
  globals.mapleader = " "; # Set leader key to space
  keymaps = [
    {
      key = "<C-n>";
      action = "<CMD>NvimTreeToggle<CR>";
      options.desc = "Toggle NvimTree";
    }
    # Toggle relative line numbers
    {
      key = "<leader>rn";
      action = "<cmd>set rnu!<CR>";
      options.desc = "Toggle relative line numbers";
    }
    # Toggle line numbers
    {
      key = "<leader>n";
      action = "<cmd>set nu!<CR>";
      options.desc = "Toggle line numbers";
    }
  ];
}