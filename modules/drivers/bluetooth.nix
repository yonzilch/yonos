{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.drivers.bluetooth;
in
{
  options.drivers.bluetooth = {
    enable = mkEnableOption "Enable Bluetooth Support";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = lib.mkDefault true;
    hardware.bluetooth.powerOnBoot = lib.mkDefault true;
    services.blueman.enable = lib.mkDefault true;
  };
}
