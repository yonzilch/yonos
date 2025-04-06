{pkgs, ...}: {
  home.packages = with pkgs; [
    tesseract
  ];
}
