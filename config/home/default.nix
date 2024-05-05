{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./alacritty.nix
    ./bash.nix
    ./browser-brave.nix
    ./browser-floorp.nix
    ./browser-firefox-dev.nix
    ./gtk-qt.nix
    ./hyprland.nix
    ./neofetch.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix
    ./waybar.nix
    ./wlogout.nix
    ./swaylock.nix
    ./swaync.nix
    # Place Home Files Like Pictures
    ./files.nix
  ];

}



