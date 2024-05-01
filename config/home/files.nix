{ pkgs, config, ... }:

{
  # Place Files Inside Home Directory
  home.file.".base16-themes".source = ./files/base16-themes;
  home.file.".config/ascii-fastfetch".source = ./files/ascii-fastfetch;
  home.file.".config/nushell/config.nu".source = ./files/config.nu;
  home.file.".config/nushell/env.nu".source = ./files/env.nu;
  home.file.".config/rofi/rofi.jpg".source = ./files/rofi.jpg;
  home.file.".config/starship.toml".source = ./files/starship.toml;
  home.file.".config/swaylock-bg.jpg".source = ./files/media/swaylock-bg.jpg;
  home.file.".emoji".source = ./files/emoji;
  home.file.".face".source = ./files/face.jpg; # For GDM
  home.file.".face.icon".source = ./files/face.jpg; # For SDDM
  home.file.".local/share/atuin/init.nu".source = ./files/init.nu;

  home.file.".config/obs-studio" = {
    source = ./files/obs-studio;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ./files/wlogout;
    recursive = true;
  };
  home.file.".local/share/fonts" = {
    source = ./files/fonts;
    recursive = true;
  };
}
