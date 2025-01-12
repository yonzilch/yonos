{ pkgs, ...}:
{
  home.packages = with pkgs; [
    hyprlandPlugins.hy3
  ];
}
