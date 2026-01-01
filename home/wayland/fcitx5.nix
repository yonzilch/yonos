{pkgs, ...}: {
  home.file.".local/share/fcitx5/rime" = {
    force = true;
    recursive = true;
    source = pkgs.fetchFromGitHub {
      hash = "sha256-GyiOlTr1Nw2ANTE7/fdyrPQkvRFWOyal3oAcDvsqF5A=";
      owner = "iDvel";
      repo = "rime-ice";
      tag = "2025.12.08";
    };
  };

  i18n.inputMethod = {
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-rime
        libsForQt5.fcitx5-qt
      ];
      waylandFrontend = true;
    };
    type = "fcitx5";
  };
}
