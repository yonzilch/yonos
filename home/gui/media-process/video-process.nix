{pkgs, ...}: {
  home.packages = with pkgs; [
    aegisub
    handbrake
    mkvtoolnix
    mediainfo
    mediainfo-gui
  ];
}
