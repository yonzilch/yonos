{ pkgs, ...}:
{
  home.packages = with pkgs; [
    claws-mail
  ];
}
