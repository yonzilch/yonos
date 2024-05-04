{ pkgs, config, username, ... }:

let
  inherit (import ../../options.nix)
    browser wallpaperDir wallpaperGit flakeDir;
in
{
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    pkgs._64gram
    anyrun
    anytype
    atuin
    autorestic
    betterbird
    clipcat
    copyq
    element-desktop
    firefox-devedition
    floorp
    font-awesome
    ghostwriter
    gimp
    gnome.file-roller
    gopass
    helix
    imv
    joplin-desktop
    keepassxc
    lapce
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
    vscodium
    wayshot
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
