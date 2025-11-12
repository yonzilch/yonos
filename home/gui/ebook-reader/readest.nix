{pkgs, ...}: {
  home.packages = with pkgs; [
    readest
  ];
}
