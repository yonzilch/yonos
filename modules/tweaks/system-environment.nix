{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    # archive
    p7zip
    unzipNLS
    xz
    zip
    zstd

    # core
    greetd.tuigreet
    just
    v4l-utils # For OBS virtual cam support

    # editor use in tty
    micro

    # networking tool
    curl
    socat

    # misc
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
    ninja
    pkg-config
    zenith
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
  };
}
