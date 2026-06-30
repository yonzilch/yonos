_: {
  programs.nixvim = {
    opts = {
      breakindent = true;
      clipboard = "unnamedplus";
      cmdheight = 2;
      cursorline = true;
      encoding = "utf-8";
      expandtab = true;
      fileencoding = "utf-8";
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";
      hlsearch = true;
      ignorecase = true;
      inccommand = "split";
      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
      mouse = "a";
      number = true;
      pumheight = 0;
      scrolloff = 8;
      shiftwidth = 2;
      showmode = false;
      signcolumn = "yes";
      smartcase = true;
      softtabstop = 2;
      splitbelow = true;
      splitright = true;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 250;
      undofile = true;
      updatetime = 50;
    };
  };
}
