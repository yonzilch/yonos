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

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6ct
  ];

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  stylix = {
    autoEnable = false;
    targets = {
      swaync.enable = true;
    };
  };
}
