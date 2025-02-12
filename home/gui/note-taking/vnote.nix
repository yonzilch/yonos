{ pkgs, ...}:
{
  home.packages = with pkgs; [
    vnote
  ];
}
