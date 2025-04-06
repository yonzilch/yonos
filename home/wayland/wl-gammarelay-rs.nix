{pkgs, ...}: {
  home.packages = with pkgs; [
    wl-gammarelay-rs
  ];
}
