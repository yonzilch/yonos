{ config, pkgs, ... }:
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = let
        browser = ["brave-browser.desktop"];
        editor = ["nvim.desktop"];
        filemanager = ["nemo.desktop"];
      in {
        "application/json" = browser;
        "application/pdf" = browser;
        "application/rdf+xml" = browser;
        "application/rss+xml" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "application/xml" = browser;
        "application/xhtml+xml" = browser;
        "application/xhtml_xml" = browser;
        "application/x-wine-extension-ini" = editor;

        "text/html" = browser;
        "text/xml" = browser;
        "text/plain" = editor;

        "x-scheme-handler/about" = filemanager;
        "x-scheme-handler/ftp" = filemanager;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/unknown" = browser;

        "x-scheme-handler/tg" = ["io.github.kukuruzka165.materialgram.desktop "];

        "audio/*" = ["mpv.desktop"];
        "video/*" = ["mpv.desktop"];
        "image/*" = ["oculante.desktop"];
        "image/gif" = ["oculante.desktop"];
        "image/jpeg" = ["oculante.desktop"];
        "image/png" = ["oculante.desktop"];
        "image/webp" = ["oculante.desktop"];
      };
    };
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      configPackages = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
    userDirs = {
      enable = true;
      createDirectories = false;
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      publicShare = "/var/empty";
      templates = "/var/empty";
      videos = "$HOME/Videos";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}
