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
    ];

  qt = {
    enable = true;
    style ={
      name = "kvantum";
    };
  };

  stylix.targets = {
    fuzzel.enable = false;
    hyprland.enable = false;
    nushell.enable = false;
    waybar.enable = false;
    zed.enable = false;
  };
}
