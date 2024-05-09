{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup note-anytype; in
lib.mkIf (note-anytype == true) 
  {
  # Install Packages For The User
  home.packages = with pkgs; [
    anytype
    ];
}