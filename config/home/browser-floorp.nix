{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup browser-floorp; in
lib.mkIf (browser-floorp == "true") 
  {
  # Install Packages For The User
  home.packages = with pkgs; [
    floorp
    ];
}