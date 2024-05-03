{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./alacritty.nix
    ./bash.nix
    ./fcitx5.nix
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



