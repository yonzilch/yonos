{ pkgs, config, username, ... }:

let
  inherit (import ../../options.nix)
    wallpaperDir wallpaperGit flakeDir;
in
{
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs._64gram
    anyrun
    anytype
    atuin
    autorestic
    betterbird
    cinnamon.nemo-with-extensions
    clipcat
    copyq
    element-desktop
    font-awesome
    ghostwriter
    gimp
    gopass
    grim
    imv
    joplin-desktop
    keepassxc
    libvirt
    nekoray
    neovide
    mindforger
    mpv
    mucommander
    obs-studio
    onlyoffice-bin_latest
    pavucontrol
    pot
    prs
    restic
    qalculate-gtk
    qtpass
    qt5ct
    rio
    ripasso-cursive
    rustup
    satty
    shotwell
    swww
    slurp
    swaynotificationcenter
    swayidle
    strawberry
    swaylock
    syncthing
    syncthingtray
    tree
    virtualboxKvm
    xarchiver
    yazi
    zola
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix {
      inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit;
    })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/screenshot.nix { inherit pkgs; })
  ];

  programs.gh.enable = true;
}
