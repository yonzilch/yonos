{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    file
    gcc
    ghc
    gnumake
    libvirt
    lm_sensors
    libnotify
    meson
    nemo
    ninja
    playerctl
    pkg-config
    wl-clipboard-rs
    zenith
  ];
}
