{inputs, ...}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  programs.nixvim = {
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          background = {
            dark = "mocha";
            light = "macchiato";
          };
          flavour = "mocha";
          integrations = {
            cmp = true;
            fidget = true;
            lsp_trouble = true;
            mini.enabled = true;
            native_lsp = {
              enabled = true;
              inlay_hints = {
                background = true;
              };
              underlines = {
                errors = ["underline"];
                hints = ["underline"];
                information = ["underline"];
                warnings = ["underline"];
              };
              virtual_text = {
                errors = ["italic"];
                hints = ["italic"];
                information = ["italic"];
                ok = ["italic"];
                warnings = ["italic"];
              };
            };
            neotree = true;
            noice = true;
            notify = true;
            telescope.enabled = true;
            treesitter = true;
            treesitter_context = true;
            which_key = true;
          };
          transparent_background = true;
        };
      };
    };
    defaultEditor = true;
    enable = true;
    enableMan = false;
    globals = {
      have_nerd_font = true;
      mapleader = " ";
      maplocalleader = " ";
    };
    performance = {
      combinePlugins.enable = true;
    };
  };
}
