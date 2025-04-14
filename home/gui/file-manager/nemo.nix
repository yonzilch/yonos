{pkgs, ...}: {
  dconf.settings = {
    "org/nemo/preferences" = {
      "date-font-choice" = "no-mono";
      "date-format" = "iso";
      "default-folder-viewer" = "list-view";
      "show-hidden-files" = true;
    };
  };

  home.packages = with pkgs; [
    nemo
  ];
}
