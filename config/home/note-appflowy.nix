{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup note-appflowy; in
lib.mkIf (note-appflowy == true) 
  {
  # Install Packages For The User
  home.packages = with pkgs; [
    appflowy
    ];
}