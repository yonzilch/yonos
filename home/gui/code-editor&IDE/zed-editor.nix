{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    nixd
    zed-editor
  ];

  programs.zed-editor = {
    enable = true;
    # package = pkgs.zed-editor;

    userSettings = {
      auto_install_extensions = {
        catppuccin = true;
        catppucchin-icons = true;
        nix = true;
        tokyo-night = true;
      };
      auto_update = false;
      base_keymap = "VSCode";
      completions = {
        lsp_fetch_timeout_ms = 5000;
      };
      helix_mode = false;
      journal = {
        hour_format = "hour24";
      };
      icon_theme = {
        dark = "Catppuccin Mocha";
        light = "Catppuccin Mocha";
        mode = "system";
      };
      load_direnv = "shell_hook";
      lsp = {
      };
      project_panel = {
        dock = "left";
      };
      show_whitespaces = "all";
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        button = false;
        copy_on_select = false;
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        dock = "bottom";
        font_family = "JetBrainsMono Nerd Font";
        font_features = null;
        font_size = 16;
        line_height = "comfortable";
        shell = "system";
        toolbar = {
          breadcrumbs = false;
        };
        option_as_meta = false;
        working_directory = "current_project_directory";
      };
      theme = {
        dark = "Tokyo Night";
        light = "Catppuccin Mocha";
        mode = "system";
      };
      ui_font_family = "Sarasa Gothic SC";
      ui_font_size = 16.5;
      vim_mode = false;
    };
  };
}
