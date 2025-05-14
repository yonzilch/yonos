{config, ...}: {
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = let
        archiver = ["peazip.desktop"];
        browser = ["brave-browser.desktop"];
        editor = ["nvim.desktop"];
        filemanager = ["nemo.desktop"];
        image-viewer = ["oculante.desktop"];
        media-player = ["mpv.desktop"];
      in {
        "application/x-bzip2" = archiver;
        "application/x-gzip" = archiver;
        "application/x-tar" = archiver;
        "application/x-7z-compressed" = archiver;
        "application/x-rar-compressed" = archiver;
        "application/x-ace-compressed" = archiver;

        "application/json" = browser;
        "application/pdf" = browser;
        "application/rdf+xml" = browser;
        "application/rss+xml" = browser;
        "application/xml" = browser;
        "application/xhtml+xml" = browser;
        "application/xhtml_xml" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "text/html" = browser;
        "text/xml" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/unknown" = browser;

        "application/x-wine-extension-ini" = editor;
        "text/plain" = editor;

        "x-scheme-handler/about" = filemanager;
        "x-scheme-handler/ftp" = filemanager;

        "image/*" = image-viewer;
        "image/avif" = image-viewer;
        "image/gif" = image-viewer;
        "image/jpeg" = image-viewer;
        "image/png" = image-viewer;
        "image/webp" = image-viewer;

        "audio/*" = media-player;
        "video/*" = media-player;

        "x-scheme-handler/tg" = ["io.github.kukuruzka165.materialgram.desktop"];
      };
    };
    portal = {
      config = {
        common = {
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
        };
      };
      enable = true;
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
