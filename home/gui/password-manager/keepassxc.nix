{pkgs, ...}: {
  home.packages = with pkgs; [
    git-credential-keepassxc
    keepassxc
  ];
}
