{pkgs, ...}: {
  fonts.fontconfig = {
    defaultFonts = {
      emoji = ["Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font Mono"];
      sansSerif = ["Sarasa Gothic SC"];
      serif = ["Sarasa Gothic SC"];
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
    qt6ct
  ];

  qt = {
    enable = true;
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
      sway.enable = false;
      waybar.enable = false;
      yazi.enable = false;
      zed.enable = false;
    };
  };
}
