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
    anytype
    atuin
    autorestic
    betterbird
    clipcat
    element-desktop
    firefox-devedition
    floorp
    font-awesome
    geeqie
    ghostwriter
    gimp
    gnome.file-roller
    gopass
    grim
    helix
    imv
    joplin-desktop
    keepassxc
    lapce
    libvirt
    neovide
    mindforger
    mpv
    mucommander
    obs-studio
    onlyoffice-bin_latest
    pavucontrol
    pot
    qalculate-gtk
    rio
    rofi-wayland
    rustup
    swww
    slurp
    swaynotificationcenter
    swayidle
    strawberry
    swaylock
    syncthing
    syncthingtray
    tree
    vscodium
    zola
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix {
      inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit;
    })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
    (import ./../scripts/list-hypr-bindings.nix { inherit pkgs; })
  ];

  programs.gh.enable = true;
}
