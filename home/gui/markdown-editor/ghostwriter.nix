{ pkgs, ...}:
{
  home.packages = with pkgs; [
    kdePackages.ghostwriter
  ];
}
