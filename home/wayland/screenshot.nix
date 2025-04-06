{pkgs, ...}: {
  home.packages = with pkgs; [
    grim
    jq
    slurp
    swappy
  ];
}
