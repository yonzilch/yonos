{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      nixfmt-rs
      stylua
    ];

    plugins.conform-nvim = {
      enable = true;

      settings = {
        notify_on_error = false;
        notify_no_formatters = false;

        format_on_save = ''
          function(bufnr)
            -- Allow auto-formatting to be disabled globally or per buffer.
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            -- Do not fall back to LSP formatting for filetypes without a
            -- sufficiently standardized formatting style.
            local disable_lsp_fallback = {
              c = true,
              cpp = true,
            }

            local filetype = vim.bo[bufnr].filetype

            return {
              timeout_ms = 1000,
              lsp_format = disable_lsp_fallback[filetype]
                  and "never"
                or "fallback",
            }
          end
        '';

        formatters_by_ft = {
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
        };
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>f";

        action.__raw = ''
          function()
            require("conform").format({
              async = true,
              timeout_ms = 1000,
              lsp_format = "fallback",
            })
          end
        '';

        options = {
          desc = "[F]ormat buffer or selection";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>uf";

        action.__raw = ''
          function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat

            local status = vim.g.disable_autoformat
                and "disabled"
              or "enabled"

            vim.notify(
              "Global auto-formatting " .. status,
              vim.log.levels.INFO
            )
          end
        '';

        options = {
          desc = "Toggle global auto-formatting";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>uF";

        action.__raw = ''
          function()
            vim.b.disable_autoformat = not vim.b.disable_autoformat

            local status = vim.b.disable_autoformat
                and "disabled"
              or "enabled"

            vim.notify(
              "Buffer auto-formatting " .. status,
              vim.log.levels.INFO
            )
          end
        '';

        options = {
          desc = "Toggle buffer auto-formatting";
          silent = true;
        };
      }
    ];
  };
}
