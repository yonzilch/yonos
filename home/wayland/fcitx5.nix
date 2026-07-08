{ pkgs, ... }: {
  home.file.".local/share/fcitx5/rime" = {
    force = true;
    recursive = true;
    source = pkgs.fetchFromGitHub {
      hash = "sha256-1yxbLuVcCqgHGS14AecbVL7AQFGC/wbFO7US3Onz/R0=";
      owner = "gaboolic";
      repo = "rime-frost";
      tag = "1.0.4";
    };
  };

  i18n.inputMethod = {
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-rime
        libsForQt5.fcitx5-qt
        qt6Packages.fcitx5-qt
      ];
      waylandFrontend = true;
    };
    type = "fcitx5";
  };
}
