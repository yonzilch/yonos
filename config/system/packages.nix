{ pkgs, config, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    appimage-run
    bat
    bottom
    brightnessctl
    btop
    curl
    dust
    eza
    fastfetch
    fd
    git
    gitui
    gnumake
    go
    htop
    just
    libnotify
    libvirt
    lsd
    lshw
    material-icons
    meson
    neofetch
    networkmanagerapplet
    nushellFull
    nh
    ninja
    nodejs
    noto-fonts-color-emoji
    playerctl
    polkit_gnome
    ripgrep
    sd
    socat
    symbola
    swappy
    tealdeer
    termscp
    unzip
    unrar
    virt-viewer
    wget
    wl-clipboard
    ydotool
    zellij
    zoxide
  ];

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
  };

  virtualisation.libvirtd.enable = true;
}