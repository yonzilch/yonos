{ config, lib, ... }:
with lib;
let
  cfg = config.drivers.bluetooth;
in
{
  options.drivers.bluetooth = {
    enable = mkEnableOption "Enable Bluetooth Support";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = lib.mkDefault true;
      powerOnBoot = lib.mkDefault true;
    };
    services.blueman.enable = lib.mkDefault true;
  };
}
