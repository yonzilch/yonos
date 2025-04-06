{pkgs, ...}: {
  home.packages = with pkgs; [
    foliate
  ];
}
