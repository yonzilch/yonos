{ pkgs, config, username, ... }:

let
  inherit (import ../../options.nix)
    browser wallpaperDir wallpaperGit flakeDir;
in
{
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    anytype
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
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix {
      inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit;
    })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
    (import ./../scripts/list-hypr-bindings.nix { inherit pkgs; })
  ];

  programs.gh.enable = true;
}
