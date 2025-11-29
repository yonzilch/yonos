{pkgs, ...}: {
  programs.chromium = {
    commandLineArgs = [
      "--password-store=basic"
    ];
    enable = true;
    # extensions = [ # see https://mynixos.com/home-manager/option/programs.chromium.extensions
    #   {
    #     # Dark Reader
    #     id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
    #   }
    # ];
    package = pkgs.brave;
  };
}
