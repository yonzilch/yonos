# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS. 
# https://github.com/yonzilch/yonos/

let
  # THINGS YOU NEED TO CHANGE
  username = "admin";
  hostname = "yonos";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/yonos";
  waybarStyle = "simplebar"; # simplebar, slickbar, or default
in {
  # User Variables
  username = "admin";
  hostname = "yonos";
  gitUsername = "yonzilch";
  gitEmail = "github@yonzilch.com";
  theme = "tokyo-night-storm";
  slickbar = if waybarStyle == "slickbar" then true else false;
  simplebar = if waybarStyle == "simplebar" then true else false;
  bar-number = true; # Enable / Disable Workspace Numbers In Waybar
  borderAnim = true;
  wallpaperGit = "https://github.com/yonzilch/my-wallpapers.git"; # This will give you my wallpapers
  # ^ (use as is or replace with your own repo - removing will break the wallsetter script) 
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  screenshotDir = "${userHome}/Pictures/Screenshots";
  flakeDir = "${flakeDir}";
  flakePrev = "${userHome}/.yonos-previous";
  flakeBackup = "${userHome}/.yonos-backup";
  terminal = "alacritty"; # This sets the terminal that is used by the hyprland terminal keybinding

  # System Settings
  clock24h = true;
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "de";
  theKBDVariant = "";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "Asia/Shanghai";
  theShell = "nushell";
  theKernel = "xanmod"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "wayland"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "amd";
  gpuType = "amd";

  # Nvidia Hybrid Devices
  # ONLY NEEDED FOR HYBRID
  # SYSTEMS! 

  # Enable browsers
  browser-brave = "true";
  browser-floorp = "true";
  browser-firefox-dev = "true";

  # Enable / Setup NFS
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Flatpak & Larger Programs
  distrobox = false;
  flatpak = false;

  # Enable Printer & Scanner Support
  printer = false;
  
  # Enable Support For Logitech Devices
  logitech = false;

  # Enable Python & PyCharm
  python = false;


  # Enable editors
  editor-vscodium = true;

  # Enable terminal-emulators
  terminal-emulator-alacritty = true;
  terminal-emulator-rio = true;


}
