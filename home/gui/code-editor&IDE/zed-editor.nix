{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "nix"
      "tokyo-night"
    ];

    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];

    userSettings = {
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

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];

          formatter = {
            external = {
              command = "${pkgs.nixfmt}/bin/nixfmt";
              arguments = [ ];
            };
          };

          format_on_save = "on";
          tab_size = 2;
        };
      };

      load_direnv = "shell_hook";

      lsp = {
        nixd = {
          binary = {
            path = "${pkgs.nixd}/bin/nixd";
          };

          initialization_options = {
            formatting = {
              command = [
                "${pkgs.nixfmt}/bin/nixfmt"
              ];
            };
          };
        };
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
        font_family = "JetBrainsMono Nerd Font Mono";
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
