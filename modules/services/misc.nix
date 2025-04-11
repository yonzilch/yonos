_: {
  services = {
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    gvfs.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
  };
}
