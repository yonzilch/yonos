{pkgs, ...}: {
  home.packages = with pkgs; [
    swayosd
  ];
}
