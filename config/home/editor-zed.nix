{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup editor-zed; in
lib.mkIf (editor-zed == true) 
  {
  # Install Packages For The User
  home.packages = with pkgs; [
    zed-editor
    ];
}