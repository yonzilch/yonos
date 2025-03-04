{ pkgs, ...}:
{
  home.packages = with pkgs; [
    wakatime-cli
  ];
  programs.nixvim = {
    plugins.wakatime = {
      enable = true;
    };
  };
}
