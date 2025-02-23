_: {
  programs.nixvim = {
    plugins.none-ls = {
      enable = true;
      sources = {
        formatting.alejandra.enable = true;
      };
    };
  };
}
