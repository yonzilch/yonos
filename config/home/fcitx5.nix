{ pkgs, config, lib, inputs, ... }:

    i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons =
    let
      config.packageOverrides = pkgs: {
        fcitx5-rime = pkgs.fcitx5-rime.override {rimeDataPkgs = [
          ./rime-data-flypy
        ];};
      };
    in
    with pkgs; [
        fcitx5-rime
        fcitx5-configtool
        fcitx5-chinese-addons
      ];
};
