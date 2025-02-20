{ lib, ... }:
{
  # Minimize boot
  boot = {
    bcache.enable = lib.mkForce false;
    binfmt.addEmulatedSystemsToNixSandbox = lib.mkForce false;
  };

  # Disable unnecessary documentation
  documentation.enable = lib.mkForce  false;
  documentation.doc.enable = lib.mkForce false;
  documentation.info.enable = lib.mkForce false;
  documentation.man.enable = lib.mkForce false;
  documentation.nixos.enable = lib.mkForce false;

  # Minimize environment
  environment = {
    defaultPackages = lib.mkForce [ ];
  };

  # Disable unnecessary programs
  programs = {
    bash = {
      completion.enable = lib.mkForce false;
      enableLsColors = lib.mkForce false;
    };
    command-not-found.enable = lib.mkForce false;
    nano.enable = lib.mkForce false;
  };

  # Minimize services
  services = {
    gnome.gnome-keyring.enable = lib.mkForce false;
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

    resolved.enable = lib.mkForce false;
  };

  # Minimize systemd services
  systemd = {
    coredump.enable = lib.mkForce false;
    enableEmergencyMode = lib.mkForce false;
    oomd.enable = lib.mkForce false;
    services = {
      mount-pstore.enable = lib.mkForce false;
      systemd-bsod.enable = lib.mkForce false;
      systemd-importd.enable = lib.mkForce false;
      systemd-journal-flush.enable = lib.mkForce false;
      systemd-pstore.enable = lib.mkForce false;
      systemd-udev-settle.enable = lib.mkForce false;
    };
  };
  xdg = {
    autostart.enable = lib.mkForce false;
  };
}
