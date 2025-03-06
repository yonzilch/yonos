{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    nil
    nixd
  ];
  programs.zed-editor = {
    enable = true;
    extensions = [
      "Catpucchin"
      "Docker Compose"
      "HTML"
      "nix"
      "nu"
      "toml"
      "wakatime"
    ];

    ## everything inside of these brackets are Zed options.
    userSettings = {
      features = {
        copilot = false;
        inline_completion_provider = "none";
      };
      assistant = {
        enabled = true;
        version = "2";
        default_model = {
          provider = "google";
          model = "gemini-2.0-flash";
        };
      };

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
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
        env = {
          TERM = "alacritty";
        };
        font_family = ".SystemUIFont";
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

      vim_mode = false;
      ## tell zed to use direnv and direnv can use a flake.nix enviroment.
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      show_whitespaces = "all";
    };
  };
}
