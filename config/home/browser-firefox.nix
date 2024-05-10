{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup browser-firefox; in
lib.mkIf (browser-firefox == true) 
  {
  # Install Packages For The User
  home.packages = with pkgs; [
    firefox
    ];
}