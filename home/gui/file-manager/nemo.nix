{pkgs, ...}: {
  home.packages = with pkgs; [
    nemo
  ];
}
