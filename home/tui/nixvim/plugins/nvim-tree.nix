_: {
  programs.nixvim = {
    plugins.nvim-tree = {
      enable = true;
    };

    keymaps = [
      {
        key = "<C-\\>";
        action = "<cmd>NvimTreeToggle<cr>";
        options = {
          desc = "NvimTree Toggle";
        };
      }
    ];
  };
}
