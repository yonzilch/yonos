{ config, lib, ... }:
{
  # Minimize boot
  boot = {
    swraid.enable = lib.mkForce false;
  };

  # Disable unnecessary documentation
  documentation.enable =lib.mkForce  false;
  documentation.doc.enable =lib.mkForce  false;
  documentation.info.enable =lib.mkForce  false;
  documentation.man.enable =lib.mkForce  false;
  documentation.nixos.enable =lib.mkForce  false;

  # Minimize environment
  environment = {
    defaultPackages = lib.mkForce [ ];
  };

  # Disable unnecessary fonts
  fonts.fontconfig.enable =lib.mkForce false;

  # Remove useless package

  # Disable unnecessary programs
  programs = {
    bash = {
      completion.enable = lib.mkForce false;
      enableLsColors = lib.mkForce false;
    };
    command-not-found.enable = lib.mkForce false;
    nano.enable = lib.mkForce false;
  };

  # Minimize journal
  services.journald = {
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

  # Minimize services
  services = {
    pulseaudio.enable = false;
  };

  # Minimize systemd services
  systemd = {
    enableEmergencyMode = false;
    oomd.enable = false;
    services = {
      systemd-journal-flush.enable = false;
      systemd-udev-settle.enable = false;
    };
  };
}
