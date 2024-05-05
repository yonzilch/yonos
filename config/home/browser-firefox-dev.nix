{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup browser-firefox-dev; in
lib.mkIf (browser-firefox-dev == "true") 
  {
  # Install Packages For The User
  home.packages = with pkgs; [
    firefox-devedition
    ];
}