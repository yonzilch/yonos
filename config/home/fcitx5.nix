{ pkgs, config, lib, ... }:
{

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-configtool # needed enable rime using configtool after installed
      fcitx5-chinese-addons
      fcitx5-material-color # theme
      # fcitx5-mozc # japanese input method
      fcitx5-gtk # gtk im module
      fcitx5-rime # for flypy chinese input method
      libsForQt5.fcitx5-qt # qt im module
    ];
  };
}
