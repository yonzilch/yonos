{ pkgs, ... }: {
  home.file.".local/share/fcitx5/rime" = {
    force = true;
    recursive = true;
    source = pkgs.fetchFromGitHub {
      hash = "sha256-hRtA1cYAQm7M+dPSThedqKogr8YMkP9WQFEZw5pdCbU=";
      owner = "iDvel";
      repo = "rime-ice";
      tag = "2026.03.26";
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
