{ pkgs, config, ... }:

{
  # Starship Prompt
  programs.starship = {
    enable = true;
    
    enableBashIntegration = true;
    enableNushellIntegration = true;

    package = pkgs.starship;
  };
}
