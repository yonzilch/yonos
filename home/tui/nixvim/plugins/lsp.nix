_: {
  programs.nixvim = {
    autoGroups = {
      "kickstart-lsp-attach" = {
        clear = true;
      };
    };

    plugins = {
      cmp-nvim-lsp.enable = true;
      fidget.enable = true;

      lsp = {
        enable = true;

        keymaps = {
          diagnostic = {
            "<leader>q" = {
              action = "setloclist";
              desc = "Open diagnostic [Q]uickfix list";
            };
          };

          extra = [
            {
              mode = "n";
              key = "gd";
              action.__raw = "require('telescope.builtin').lsp_definitions";
              options = {
                desc = "LSP: [G]oto [D]efinition";
              };
            }
            {
              mode = "n";
              key = "gr";
              action.__raw = "require('telescope.builtin').lsp_references";
              options = {
                desc = "LSP: [G]oto [R]eferences";
              };
            }
            {
              mode = "n";
              key = "gI";
              action.__raw = "require('telescope.builtin').lsp_implementations";
              options = {
                desc = "LSP: [G]oto [I]mplementation";
              };
            }
            {
              mode = "n";
              key = "<leader>D";
              action.__raw = "require('telescope.builtin').lsp_type_definitions";
              options = {
                desc = "LSP: Type [D]efinition";
              };
            }
            {
              mode = "n";
              key = "<leader>ds";
              action.__raw = "require('telescope.builtin').lsp_document_symbols";
              options = {
                desc = "LSP: [D]ocument [S]ymbols";
              };
            }
            {
              mode = "n";
              key = "<leader>ws";
              action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
              options = {
                desc = "LSP: [W]orkspace [S]ymbols";
              };
            }
          ];

          lspBuf = {
            "<leader>rn" = {
              action = "rename";
              desc = "LSP: [R]e[n]ame";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "LSP: [C]ode [A]ction";
            };
            "gD" = {
              action = "declaration";
              desc = "LSP: [G]oto [D]eclaration";
            };
          };
        };

        servers = {
          # clangd = {
          # enable = true;
          # };
          # lua_ls = {
          #   enable = true;
          #   settings = {
          #     completion = {
          #       callSnippet = "Replace";
          #     };
          #   };
          # };
          # gopls = {
          # enable = true;
          # };
          # pyright = {
          # enable = true;
          # };
          # rust_analyzer = {
          # enable = true;
          # };
          # ...etc. See `https://nix-community.github.io/nixvim/plugins/lsp` for a list of pre-configured LSPs

          # Some languages (like typscript) have entire language plugins that can be useful:
          #    `https://nix-community.github.io/nixvim/plugins/typescript-tools/index.html?highlight=typescript-tools#pluginstypescript-toolspackage`

          # But for many setups the LSP (`ts_ls`) will work just fine
          ts_ls = {
            enable = true;
          };
        };
      };
    };
  };
}
