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
    micro
    v4l-utils # For OBS virtual cam support

    # networking tool
    curl
    socat
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
  };
}
