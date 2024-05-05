{ pkgs, config, lib, ... }:

let
  palette = config.colorScheme.palette;
  inherit (import ../../options.nix) terminal-emulator-rio;
in lib.mkIf (terminal-emulator-rio == true) {
  programs.rio = {
    enable = true;
  };
}
