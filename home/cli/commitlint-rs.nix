{ pkgs, ...}:
{
  home.packages = with pkgs; [
    commitlint-rs
  ];
}
