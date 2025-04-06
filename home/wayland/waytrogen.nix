{pkgs, ...}: {
  home.packages = with pkgs; [
    waytrogen
  ];
}
