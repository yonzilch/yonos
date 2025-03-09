_: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(alt, esc)";
          };
          "alt" = {
            c = "backspace";
            d = "delete";
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            capslock = "capslock";
          };
        };
      };
    };
  };
}
