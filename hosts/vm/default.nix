{ lib, pkgs, username, ... }:
{
  imports = [
    ./disko.nix
    ./hardware.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../../modules;

  # Define users
  # If use nixos-anywhere to install, hashedPassword should be declared before installation
  users = {
    users.root = {
      hashedPassword = "$y$j9T$R3Yv9RtPiBY5UAI.pMU/w.$yp9hFWPZ0eVuNQBqrKpYwLYFU458gXEeZCQyvmHirr7";
    };
    users."${username}" = {
      extraGroups = [
        "libvirtd"
        "networkmanager"
        "wheel"
      ];
      hashedPassword = "$y$j9T$R3Yv9RtPiBY5UAI.pMU/w.$yp9hFWPZ0eVuNQBqrKpYwLYFU458gXEeZCQyvmHirr7";
      homeMode = "755";
      ignoreShellProgramCheck = true;
      isNormalUser = true;
      shell = pkgs.nushell;
    };
  };
}
