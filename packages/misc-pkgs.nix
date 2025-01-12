{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    grim
    libvirt
    lm_sensors
    libnotify
    meson
    ninja
    playerctl
    pkg-config
    slurp
    swappy
    tealdeer
    wl-clipboard-rs
    zenith
  ];
}
