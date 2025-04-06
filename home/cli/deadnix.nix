{pkgs, ...}: {
  home.packages = with pkgs; [
    deadnix
  ];
}
