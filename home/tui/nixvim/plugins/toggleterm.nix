_: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>wincmd h<cr>";
        key = "<C-M-H";
        mode = "t";
        options.desc = "Go to Left window";
      }
      {
        action = "<cmd>wincmd j<cr>";
        key = "<C-M-J";
        mode = "t";
        options.desc = "Go to Down window";
      }
      {
        action = "<cmd>wincmd k<cr>";
        key = "<C-M-K>";
        mode = "t";
        options.desc = "Go to Up window";
      }
      {
        action = "<cmd>wincmd l<cr>";
        key = "<C-M-L>";
        mode = "t";
        options.desc = "Go to Right window";
      }
      {
        action = "<cmd>wincmd h<cr>";
        key = "<C-Left>";
        mode = "t";
        options.desc = "Go to Left window";
      }
      {
        action = "<cmd>wincmd j<cr>";
        key = "<C-Down>";
        mode = "t";
        options.desc = "Go to Down window";
      }
      {
        action = "<cmd>wincmd k<cr>";
        key = "<C-Up>";
        mode = "t";
        options.desc = "Go to Up window";
      }
      {
        action = "<cmd>wincmd l<cr>";
        key = "<C-Right>";
        mode = "t";
        options.desc = "Go to Right window";
      }
      {
        action = "<cmd>TermNew<cr>";
        key = "<C-M-t>";
        mode = [
          "n"
          "t"
        ];
        options.desc = "New Terminal";
      }
      {
        action = "<cmd>close<cr>";
        key = "<C-M-w>";
        mode = "t";
        options.desc = "Close Current Terminal";
      }
      {
        action.__raw = ''
          function()
            if not _gitui_term then
              local Terminal = require('toggleterm.terminal').Terminal
              _gitui_term = Terminal:new({
                cmd = "gitui",
                display_name = "gitui",
                close_on_exit = true,
                direction = "float",
                dir = "git_dir",
                hidden = true,
                float_opts = {
                  border = "single",
                  height = function() return math.floor(vim.o.lines * 0.9) end,
                  width = function() return math.floor(vim.o.columns * 0.9) end,
                  winblend = 20,
                  title_pos = "center",
                },
                on_open = function(term)
                  vim.cmd("startinsert!")
                  vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
                end,
                on_close = function(term)
                  vim.cmd("startinsert!")
                end,
                on_exit = function()
                  _gitui_term = nil
                end,
              })
            end
            _gitui_term:toggle()
          end
        '';
        key = "<C-M-g>";
        mode = [
          "n"
          "t"
        ];
        options.desc = "Toggle gitui";
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
        open_mapping = "[[<C-M-/>]]";
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
