{ pkgs, ... }: {
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font Mono" ];
      sansSerif = [ "Sarasa Gothic SC" ];
      # Intentional: map serif to Sarasa Gothic SC because I prefer a unified
      # sans/gothic visual style and do not want serif CJK fallback in UI/browser.
      serif = [ "Sarasa Gothic SC" ];
    };
    enable = true;
  };

  gtk = {
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  stylix = {
    autoEnable = true;
    targets = {
      fcitx5.enable = false;
      floorp.enable = false;
      hyprland.enable = false;
      kde.enable = false;
      mpv.enable = false;
      nixvim.enable = false;
      # Qt/Kvantum is themed manually via qt5ct/qt6ct.
      # Disable Stylix Qt to avoid conflicts.
      qt.enable = false;
      sway.enable = false;
      waybar.enable = false;
      yazi.enable = false;
      zed.enable = false;
    };
  };
}
