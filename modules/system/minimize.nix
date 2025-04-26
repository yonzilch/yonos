{lib, ...}:
with lib; {
  # Minimize boot
  boot = {
    bcache.enable = mkForce false;
    binfmt.addEmulatedSystemsToNixSandbox = mkForce false;
  };

  # Disable unnecessary documentation
  documentation.enable = mkForce false;
  documentation.doc.enable = mkForce false;
  documentation.info.enable = mkForce false;
  documentation.man.enable = mkForce false;
  documentation.nixos.enable = mkForce false;

  # Minimize environment
  environment = {
    defaultPackages = mkForce [];
  };

  # Disable unnecessary programs
  programs = {
    bash = {
      completion.enable = mkForce false;
      enableLsColors = mkForce false;
    };
    command-not-found.enable = mkForce false;
    nano.enable = mkForce false;
  };

  # Minimize services
  services = {
    gnome.gnome-keyring.enable = mkForce false;
    journald = {
      extraConfig = ''
        Storage=volatile
        Compress=yes
        SystemMaxUse=50M
        RuntimeMaxUse=10M
        MaxFileSec=1day
        MaxRetentionSec=1month
        RateLimitInterval=30s
        RateLimitBurst=1000
      '';
    };
    resolved.enable = mkForce false;
    timesyncd.enable = mkForce false;
  };

  # Minimize systemd services
  systemd = {
    coredump.enable = mkForce false;
    enableEmergencyMode = mkForce false;
    network.wait-online.enable = mkForce false;
    oomd.enable = mkForce false;
    services = {
      mount-pstore.enable = mkForce false;
      NetworkManager-wait-online.enable = mkForce false;
      systemd-bsod.enable = mkForce false;
      systemd-importd.enable = mkForce false;
      systemd-journal-flush.enable = mkForce false;
      systemd-pstore.enable = mkForce false;
    };
  };

  # Disable xdg autostart
  xdg = {
    autostart.enable = mkForce false;
  };
}
