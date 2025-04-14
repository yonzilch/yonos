{config, pkgs, ...}: {
  dconf.settings = {
    "org/Waytrogen/Waytrogen" = {
      "wallpaper-folder" = "${config.home.homeDirectory}/Pictures/Wallpapers";
    };
  };

  home.packages = with pkgs; [
    waytrogen
  ];
}
