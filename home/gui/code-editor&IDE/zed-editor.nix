{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    nixd
    zed-editor
  ];

  # programs.zed-editor = {
    # enable = true;
    # package = pkgs.zed-editor-fhs;

    # userSettings = {
    #   assistant = {
    #     enabled = false;
    #     version = "2";
    #   };
    #   auto_install_extensions = {
    #     catppuccin = true;
    #     catppucchin-icons = true;
    #     nix = true;
    #   };
    #   auto_update = false;
    #   base_keymap = "VSCode";
    #   features = {
    #     copilot = false;
    #     inline_completion_provider = "none";
    #   };
    #   hour_format = "hour24";
    #   icon_theme = {
    #     dark = "Catppuccin Mocha";
    #     light = "Catppuccin Mocha";
    #     mode = "system";
    #   };
    #   load_direnv = "shell_hook";
    #   lsp = {
    #     nix = {
    #       binary = {
    #         path_lookup = true;
    #       };
    #     };
    #   };
    #   show_whitespaces = "all";
    #   terminal = {
    #     alternate_scroll = "off";
    #     blinking = "off";
    #     button = false;
    #     copy_on_select = false;
    #     detect_venv = {
    #       on = {
    #         directories = [
    #           ".env"
    #           "env"
    #           ".venv"
    #           "venv"
    #         ];
    #         activate_script = "default";
    #       };
    #     };
    #     dock = "bottom";
    #     font_family = "JetBrainsMono Nerd Font";
    #     font_features = null;
    #     font_size = null;
    #     line_height = "comfortable";
    #     shell = "system";
    #     toolbar = {
    #       breadcrumbs = false;
    #     };
    #     option_as_meta = false;
    #     toolbar = {
    #       title = true;
    #     };
    #     working_directory = "current_project_directory";
    #   };
    #   theme = {
    #     dark = "Catppuccin Mocha";
    #     light = "Catppuccin Mocha";
    #     mode =  "system";
    #   };
    #   vim_mode = false;
    # };
  # };
}
