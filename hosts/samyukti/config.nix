{ config, host, lib, options, pkgs, username, ... }:
let
  inherit (import ./env.nix) gitUsername;
in
{
  imports = [
    ./hardware.nix
    ../../modules/drivers/amd-drivers.nix
    ../../modules/drivers/nvidia-drivers.nix
    ../../modules/drivers/nvidia-prime-drivers.nix
    ../../modules/drivers/intel-drivers.nix
    ../../modules/tweaks/locale-and-timezone.nix
    ../../modules/tweaks/minimalise.nix
    ../../modules/tweaks/network-and-ntp.nix
    ../../modules/tweaks/nix.nix
    ../../modules/tweaks/stylix.nix
    ../../modules/tweaks/system.nix
    ../../packages/essential-pkgs.nix
    ../../packages/misc-pkgs.nix
  ];

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
