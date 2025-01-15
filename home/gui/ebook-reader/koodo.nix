{ pkgs, ...}:
{
  home.packages = with pkgs; [
    koodo-reader
  ];
}
