_: {
  programs.nixvim = {
    plugins.nvim-autopairs = {
      enable = true;
    };
    extraConfigLua = ''
      require('cmp').event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
    '';
  };
}
