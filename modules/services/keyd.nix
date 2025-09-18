_: {
  environment.etc."/keyd/default.conf" = {
    mode = "0600";
    text = ''
      [ids]
      *

      [alt]
      c=backspace
      capslock=capslock
      d=delete
      e=enter
      h=left
      j=down
      k=up
      l=right

      [main]
      capslock=overload(alt, esc)
    '';
  };
  services.keyd = {
    enable = true;
    # keyboards = {
    #   default = {
    #     ids = [ "*" ];
    #     settings = {
    #       main = {
    #         capslock = "overload(alt, esc)";
    #       };
    #       "alt" = {
    #         c = "backspace";
    #         d = "delete";
    #         e = "enter";
    #         h = "left";
    #         j = "down";
    #         k = "up";
    #         l = "right";
    #         capslock = "capslock";
    #       };
    #     };
    #   };
    # };
  };
}
