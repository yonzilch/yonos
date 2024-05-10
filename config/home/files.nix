{ pkgs, config, ... }:

{
  # Place Files Inside Home Directory
  home.file.".base16-themes".source = ./files/base16-themes;
  home.file.".config/ascii-fastfetch".source = ./files/ascii-fastfetch;
  home.file.".config/starship.toml".source = ./files/starship.toml;
  home.file.".config/swaylock-bg.jpg".source = ./files/swaylock/swaylock-bg.jpg;
  home.file.".emoji".source = ./files/emoji;
  home.file.".face".source = ./files/face.jpg; # For GDM
  home.file.".face.icon".source = ./files/face.jpg; # For SDDM
  home.file.".local/share/atuin/init.nu".source = ./files/atuin/init.nu;

  home.file.".config/anyrun" = {
    source = ./files/anyrun;
    recursive = true;
  };
  home.file.".config/anytype" = {
    source = ./files/anytype;
    recursive = true;
  };
  home.file.".config/copyq" = {
    source = ./files/copyq;
    recursive = true;
  };
  home.file.".config/fcitx5" = {
    source = ./files/fcitx5/.config/fcitx5;
    recursive = true;
  };
  home.file.".config/nushell" = {
    source = ./files/nushell;
    recursive = true;
  };
  home.file.".config/obs-studio" = {
    source = ./files/obs-studio;
    recursive = true;
  };
  home.file.".config/strawberry" = {
    source = ./files/strawberry;
    recursive = true;
  };
  home.file.".config/qt5ct" = {
    source = ./files/qt5ct;
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
  home.file.".local/share/fcitx5" = {
    source = ./files/fcitx5/.local/fcitx5;
    recursive = true;
  };
}
