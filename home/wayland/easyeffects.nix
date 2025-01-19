{ pkgs, ...}:
{
  home.packages = with pkgs; [
    easyeffects
  ];
  services.easyeffects.enable = true;
}
