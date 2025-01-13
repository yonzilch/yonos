{ pkgs, ...}:
{
  home.packages = with pkgs; [
    hypridle
  ];
}
