{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./bash.nix
    ./browser-brave.nix
    ./browser-floorp.nix
    ./browser-firefox-dev.nix
    ./editor-vscodium.nix
    ./fcitx5.nix
    ./gtk-qt.nix
    ./hyprland.nix
    ./neofetch.nix
    ./neovim.nix
    ./packages.nix
    ./starship.nix
    ./terminal-emulator-alacritty.nix
    ./terminal-emulator-rio.nix
    ./waybar.nix
    ./wlogout.nix
    ./swaylock.nix
    ./swaync.nix
    # Place Home Files Like Pictures
    ./files.nix
  ];

}



