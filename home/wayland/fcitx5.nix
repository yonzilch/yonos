{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-catppuccin
        fcitx5-material-color
        fcitx5-gtk
        fcitx5-rime
        libsForQt5.fcitx5-qt
      ];
    };
  };
}
