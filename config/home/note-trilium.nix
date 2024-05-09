{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup note-trilium; in
lib.mkIf (note-trilium == true) 
  {
  # Install Packages For The User
  home.packages = with pkgs; [
    trilium-desktop
    ];
}