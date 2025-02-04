{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    expect
    file
    gcc
    ghc
    gnumake
    jq
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
