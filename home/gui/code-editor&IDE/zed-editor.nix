{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixd
  ];
  programs.zed-editor = {
    enable = true;

    userSettings = {
      auto_install_extensions = {
        catpuccin = true;
        catpucchin-icons = true;
        nix = true;
      };
      features = {
        copilot = false;
        inline_completion_provider = "none";
      };
      assistant = {
        enabled = false;
        version = "2";
      };
      hour_format = "hour24";
      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
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
        toolbar = {
          breadcrumbs = false;
        };
        env = {
          TERM = "alacritty";
        };
        font_family = "JetBrainsMono Nerd Font";
        font_features = null;
        font_size = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };
      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
      theme = {
        dark = "Catppuccin Mocha";
        light = "Catppuccin Mocha";
        mode =  "system";
      };
      icon_theme = {
        dark = "Catppuccin Mocha";
        light = "Catppuccin Mocha";
        mode = "system";
      };
      vim_mode = false;
      ## tell zed to use direnv and direnv can use a flake.nix enviroment.
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      show_whitespaces = "all";
      package = pkgs.zed-editor-fhs;
    };
  };
}
