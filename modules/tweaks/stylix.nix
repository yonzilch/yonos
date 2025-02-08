{ config, pkgs, ... }:
{
  stylix = {
    enable = true;
# catppuccin-mocha base16Scheme
#      base16Scheme = {
#        base00 = "1e1e2e"; # base
#        base01 = "181825"; # mantle
#        base02 = "313244"; # surface0
#        base03 = "45475a"; # surface1
#        base04 = "585b70"; # surface2
#        base05 = "cdd6f4"; # text
#        base06 = "f5e0dc"; # rosewater
#        base07 = "b4befe"; # lavender
#        base08 = "f38ba8"; # red
#        base09 = "fab387"; # peach
#        base0A = "f9e2af"; # yellow
#        base0B = "a6e3a1"; # green
#        base0C = "94e2d5"; # teal
#        base0D = "89b4fa"; # blue
#        base0E = "cba6f7"; # mauve
#        base0F = "f2cdcd"; # flamingo
#      };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font Mono";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      sansSerif = {
        name = "Sarasa Gothic SC";
        package = pkgs.sarasa-gothic;
      };
      serif = config.stylix.fonts.sansSerif;
      sizes = {
        applications = 16;
        desktop = 14;
        popups = 12;
        terminal = 12;
      };
    };
    image = ../../dotfiles/.local/share/wallpapers/Black-Snow-Flake.jpg;
    polarity = "dark";
  };
}
