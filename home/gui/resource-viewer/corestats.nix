{pkgs, ...}: {
  home.packages = with pkgs; [
    CuboCore.corestats
  ];
}
