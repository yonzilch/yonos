{ pkgs, ...}:
{
  home.packages = with pkgs; [
    ghostwriter
  ];
}
