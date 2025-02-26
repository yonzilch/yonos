{ pkgs, ... }:
{
  programs.nixvim = {
    opts = {
    number = true;
    mouse = "a";
    showmode = false;
    clipboard = {
      providers = {
        wl-copy = {
          enable = true;
          package = pkgs.wl-clipboard-rs;
        };
      };
      register = "unnamedplus";
    };
    breakindent = true;
    undofile = true;
    ignorecase = true;
    smartcase = true;
    signcolumn = "yes";
    updatetime = 250;
    timeoutlen = 300;
    splitright = true;
    splitbelow = true;
    list = true;
    listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
    inccommand = "split";
    cursorline = true;
    scrolloff = 10;
    hlsearch = true;
    };
  };
}
