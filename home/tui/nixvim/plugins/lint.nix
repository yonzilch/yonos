_: {
  programs.nixvim = {
    plugins.lint = {
      autoCmd = {
        callback.__raw = ''
          function()
            require('lint').try_lint()
          end
        '';
        group = "lint";
        event = [
          "BufEnter"
          "BufWritePost"
          "InsertLeave"
        ];
      };

      enable = true;

      lintersByFt = {
        nix = ["nix"];
        markdown = [
          "markdownlint"
        ];
      };
    };

    autoGroups = {
      lint = {
        clear = true;
      };
    };
  };
}
