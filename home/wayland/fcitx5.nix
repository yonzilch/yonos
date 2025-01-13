{ pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
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
