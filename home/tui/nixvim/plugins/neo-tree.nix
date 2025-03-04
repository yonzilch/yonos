_: {
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;

      filesystem = {
        window = {
          mappings = {
            "<C-\\>" = "close_window";
          };
        };
      };
    };

    keymaps = [
      {
        key = "<C-\\>";
        action = "<cmd>Neotree reveal<cr>";
        options = {
          desc = "NeoTree reveal";
        };
      }
    ];
  };
}
