{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    libvirt
    lm_sensors
    libnotify
    meson
    ninja
    playerctl
    pkg-config
    wl-clipboard-rs
    zenith
  ];
}
