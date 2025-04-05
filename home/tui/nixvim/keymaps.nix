_: {
  programs.nixvim = {
    extraConfigLua = ''
      function ToggleLineNumber()
      if vim.wo.number then
      vim.wo.number = false
      else
      vim.wo.number = true
      vim.wo.relativenumber = false
      end
      end

      function ToggleRelativeLineNumber()
      if vim.wo.relativenumber then
      vim.wo.relativenumber = false
      else
      vim.wo.relativenumber = true
      vim.wo.number = false
      end
      end

      function ToggleWrap()
      vim.wo.wrap = not vim.wo.wrap
      end

      if vim.lsp.inlay_hint then
      vim.keymap.set('n', '<leader>uh', function()
      vim.lsp.inlay_hint(0, nil)
      end, { desc = 'Toggle Inlay Hints' })
      end
    '';
    keymaps = [
      {
        action = "<cmd> norm! ggVG<cr>";
        key = "<C-a>";
        mode = "i";
        options.desc = "Select all lines in buffer";
      }
      {
        action = "<C-W>c";
        key = "<leader>wd";
        mode = "n";
        options = {
          desc = "Delete window";
          silent = true;
        };
      }
      {
        action = "<C-W>s";
        key = "<leader>-";
        mode = "n";
        options = {
          desc = "Split window below";
          silent = true;
        };
      }
      {
        action = "<C-W>v";
        key = "<leader>|";
        mode = "n";
        options = {
          desc = "Split window right";
          silent = true;
        };
      }
      {
        action = "<cmd>m .+1<cr>==";
        key = "<A-Down>";
        mode = "n";
        options.desc = "Move line down";
      }
      {
        action = "<cmd>m .-2<cr>==";
        key = "<A-Up>";
        mode = "n";
        options.desc = "Move line up";
      }
      {
        action = "<cmd>quitall<cr><esc>";
        key = "<leader>qq";
        mode = "n";
        options = {
          desc = "Quit all";
          silent = true;
        };
      }
      {
        action = "<cmd>w<cr><esc>";
        key = "<C-s>";
        mode = "n";
        options = {
          desc = "Save file";
          silent = true;
        };
      }
      {
        action = "<C-w>j";
        key = "<C-Down>";
        mode = "n";
        options.desc = "Move To Window Down";
      }
      {
        action = "<C-w>h";
        key = "<C-Left>";
        mode = "n";
        options.desc = "Move To Window Left";
      }
      {
        action = "<C-w>l";
        key = "<C-Right>";
        mode = "n";
        options.desc = "Move To Window Right";
      }
      {
        action = "<C-w>k";
        key = "<C-Up>";
        mode = "n";
        options.desc = "Move To Window Up";
      }
      {
        action = "\"_d";
        key = "<leader>D";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Delete to void register";
      }
      {
        action = "<cmd>noh<cr><esc>";
        key = "<esc>";
        mode = [
          "n"
          "i"
        ];
        options = {
          desc = "Escape and clear hlsearch";
          silent = true;
        };
      }
      {
        action = ":lua ToggleLineNumber()<cr>";
        key = "<leader>ul";
        mode = "n";
        options = {
          desc = "Toggle Line Numbers";
          silent = true;
        };
      }
      {
        action = ":lua ToggleRelativeLineNumber()<cr>";
        key = "<leader>uL";
        mode = "n";
        options = {
          desc = "Toggle Relative Line Numbers";
          silent = true;
        };
      }
      {
        action = ":lua ToggleWrap()<cr>";
        key = "<leader>uw";
        mode = "n";
        options = {
          desc = "Toggle Line Wrap";
          silent = true;
        };
      }
      {
        action = "\"+y";
        key = "<leader>y";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Copy to system clipboard";
      }
      {
        action = ":m '>+1<cr>gv=gv";
        key = "<A-Down>";
        mode = "v";
        options.desc = "Move line Down";
      }
      {
        action = ":m '<-2<cr>gv=gv";
        key = "<A-Up>";
        mode = "v";
        options.desc = "Move line up";
      }
      {
        action = "<gv";
        key = "<";
        mode = "v";
      }
      {
        action = ">gv";
        key = ">";
        mode = "v";
      }
      {
        action = "\"_dP";
        key = "p";
        mode = "x";
        options.desc = "Deletes to void register and paste over";
      }
      {
        action = "mzJ`z";
        key = "J";
        mode = "n";
        options.desc = "Allow cursor to stay in the same place after appending to current line ";
      }
      {
        action = "Nzzzv";
        key = "N";
        mode = "n";
        options.desc = "Allow search terms to stay in the middle";
      }
      {
        action = "nzzzv";
        key = "n";
        mode = "n";
        options.desc = "Allow search terms to stay in the middle";
      }
    ];
  };
}
