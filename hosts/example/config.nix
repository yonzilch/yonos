{ config, host, lib, options, pkgs, username, ... }:
let
  inherit (import ./env.nix) gitUsername;
in
{
  imports = [
    ./hardware.nix
    ]
      ++ lib.filesystem.listFilesRecursive ../../modules
      ++ lib.filesystem.listFilesRecursive ../../packages;

  # Specific boot options
  boot = {
    initrd.kernelModules = [
      "amdgpu" # For AMD GPU
    ];
  };

  # Driver module options
  drivers = {
    amdgpu.enable = false;
    intel.enable = false;
    nvidia.enable = false;
    nvidia-prime = {
      enable = false;
      intelBusID = "";
      nvidiaBusID = "";
    };
  };

  # Define users
  users = {
    mutableUsers = true;
    users.root = {
      hashedPassword = "$y$j9T$mslKS512r42wFwuiLoXGi1$eZb49BpD4C8MLENkWhxyWtFj4hkQ1zVGKI4dVjYsH/D";
    };
    users."${username}" = {
      description = "${gitUsername}";
      extraGroups = [
        "libvirtd"
        "networkmanager"
        "wheel"
      ];
      homeMode = "755";
      ignoreShellProgramCheck = true;
      isNormalUser = true;
      shell = pkgs.nushell;
    };
    # users."another-user" = {
    #   description = "Another user account";
    #   extraGroups = [ "libvirtd" "networkmanager" "wheel" ];
    #   homeMode = "755";
    #   ignoreShellProgramCheck = true;
    #   isNormalUser = true;
    #   shell = "${shell}";
    # };
  };
}
