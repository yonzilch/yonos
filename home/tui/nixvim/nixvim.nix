{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    enableMan = false;

    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          background = {
            light = "macchiato";
            dark = "mocha";
          };
          flavour = "mocha";
          transparent_background = true;
          integrations = {
            cmp = true;
            flash = true;
            fidget = true;
            gitsigns = true;
            indent_blankline.enabled = true;
            lsp_trouble = true;
            mini.enabled = true;
            neotree = true;
            noice = true;
            notify = true;
            telescope.enabled = true;
            treesitter = true;
            treesitter_context = true;
            which_key = true;
            native_lsp = {
              enabled = true;
              inlay_hints = {
                background = true;
              };
              virtual_text = {
                errors = [ "italic" ];
                hints = [ "italic" ];
                information = [ "italic" ];
                warnings = [ "italic" ];
                ok = [ "italic" ];
              };
              underlines = {
                errors = [ "underline" ];
                hints = [ "underline" ];
                information = [ "underline" ];
                warnings = [ "underline" ];
              };
            };
          };
        };
      };
    };

    defaultEditor = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = false;
    };
  };
}
