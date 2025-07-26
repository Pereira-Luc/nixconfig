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
    {
      key = "<C-s>";
      action = "<cmd>w<CR>";
      options.desc = "Save file";
    }
    {
      key = "<C-q>";
      action = "<cmd>q<CR>";
      options.desc = "Quit file";
    }
    {
      mode = "n";
      key = "<leader>/";
      action = "gcc";
      options.desc = "Toggle Comments";
      options.remap = true;
    }
    {
      mode = "v";
      key = "<leader>/";
      action = "gc";
      options.desc = "Toggle Comments";
      options.remap = true;
    }
  ];
}
