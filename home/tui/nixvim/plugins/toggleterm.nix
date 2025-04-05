_: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>2ToggleTerm<cr>";
        key = "<C-g>";
        mode = "t";
        options.desc = "Open/Close Terminal 2";
      }
      {
        action = "<cmd>wincmd j<cr>";
        key = "<C-Down>";
        mode = "t";
        options.desc = "Go to Down window";
      }
      {
        action = "<cmd>wincmd h<cr>";
        key = "<C-Left>";
        mode = "t";
        options.desc = "Go to Left window";
      }
      {
        action = "<cmd>wincmd l<cr>";
        key = "<C-Right>";
        mode = "t";
        options.desc = "Go to Right window";
      }
      {
        action = "<cmd>wincmd k<cr>";
        key = "<C-Up>";
        mode = "t";
        options.desc = "Go to Up window";
      }
    ];
    plugins.toggleterm = {
      enable = true;
      settings = {
        close_on_exit = true;
        direction = "horizontal"; # 'vertical' | 'horizontal' | 'tab' | 'float'
        float_opts = {
          border = "single"; # 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          height = 20;
          width = 80;
          winblend = 0;
        };
        hide_numbers = true;
        insert_mappings = true;
        open_mapping = "[[<C-/>]]";
        persist_mode = true;
        shade_terminals = true;
        shell = "nu";
        size = ''
          function(term)
          if term.direction == "horizontal" then
          return 30
          elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
          end
          end
        '';
        start_in_insert = true;
        terminal_mappings = true;
      };
    };
  };
}
