{ pkgs, ...}:
{
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font Mono" ];
      sansSerif = [ "Sarasa Gothic SC" ];
      serif = [ "Sarasa Gothic SC" ];
    };
    enable = true;
  };

  gtk = {
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6ct
  ];

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  stylix = {
    autoEnable = false;
    targets = {
      gtk.enable = true;
      swaync.enable = true;
    };
  };
}
