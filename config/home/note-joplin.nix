{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup note-joplin; in
lib.mkIf (note-joplin == true) 
  {
  # Install Packages For The User
  home.packages = with pkgs; [
    joplin-desktop
    ];
}