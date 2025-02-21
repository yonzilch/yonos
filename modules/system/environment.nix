{ hostname, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix) ScaleLevel;
in
{
  environment = {
    sessionVariables = {
      EDITOR = "micro";
      TERMINAL = "alacritty";
      _JAVA_AWT_WM_NONREPARENTING = 1;
      AWT_TOOLKIT = "MToolkit";
      CLUTTER_BACKEND = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      GDK_BACKEND = "wayland";
      GDK_SCALE = "${ScaleLevel}";
      GTK_USE_PORTAL = 1;
      MOZ_ENABLE_WAYLAND = 1;
      NIXOS_OZONE_WL = 1;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      QT_QPA_PLATFORM = "wayland";
      SDL_HINT_VIDEODRIVER = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";

      QT_IM_MODULE = "fcitx";
      SDL_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
    systemPackages = with pkgs; [
      # archive
      p7zip
      gnutar
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
      sarasa-gothic
      zenith
    ];
  };

  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    git = {
      enable = true;
      package = pkgs.gitMinimal;
    };
    ssh.startAgent = true;
  };
}
