{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./bash.nix
    ./browser-brave.nix
    ./browser-firefox.nix
    ./browser-firefox-dev.nix
    ./browser-floorp.nix
    ./editor-lapce.nix
    ./editor-helix.nix
    ./editor-vscodium.nix
    ./editor-zed.nix
    ./fcitx5.nix
    ./gtk-qt.nix
    ./hyprland.nix
    ./neofetch.nix
    ./neovim.nix
    ./note-anytype.nix
    ./note-appflowy.nix
    ./note-joplin.nix
    ./note-trilium.nix
    ./packages.nix
    ./shell-nushell.nix
    ./shell-zsh.nix
    ./starship.nix
    ./terminal-emulator-alacritty.nix
    ./terminal-emulator-kitty.nix
    ./terminal-emulator-rio.nix
    ./terminal-emulator-wezterm.nix
    ./waybar.nix
    ./wlogout.nix
    ./swaylock.nix
    ./swaync.nix
    # Place Home Files Like Pictures
    ./files.nix
  ];

}
