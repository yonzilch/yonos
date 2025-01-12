{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wleave
  ];
}
