{pkgs, ...}: {
  home.packages = with pkgs; [
    xarchiver
  ];
}
