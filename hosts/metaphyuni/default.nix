{
  lib,
  pkgs,
  username,
  ...
}: {
  imports =
    [
      ./disko.nix
      ./hardware.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../../modules;

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
