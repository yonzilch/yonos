{pkgs, ...}: {
  home.packages = with pkgs; [
    termscp
  ];
}
