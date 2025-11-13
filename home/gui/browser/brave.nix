{pkgs, ...}: {
  programs.chromium = {
    commandLineArgs = [
      "--enable-wayland-ime"
      "--ozone-platform=wayland"
      "--ozone-platform-hint=auto"
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
