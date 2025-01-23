{ pkgs, ...}:
{
  programs.chromium = {
    commandLineArgs = [
      "--enable-wayland-ime"
      "--ozone-platform=wayland"
      "--ozone-platform-hint=auto"
      "--password-store=basic"
    ];
    enable = true;
    extensions = [
      {
        # Dark Reader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      }
      {
        # KeePassXC-Browser
        id = "oboonakemofpalcgghocfoadofidjkkk";
      }
      {
        # kiss-translator
        id = "bdiifdefkgmcblbcghdlonllpjhhjgof";
      }
      {
        # Cookie-Editor
        id = "hlkenndednhfkekhgcdicdfddnkalmdm";
      }
      {
        # Wappalyzer - Technology profiler
        id = "gppongmhjkpfnbhagpmjfkannfbllamg";
      }
      {
        # LocalCDN
        id = "njdfdhgcmkocbgbhcioffdbicglldapd";
      }
      {
        # uBlock Origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
      {
        # ClearURLs
        id = "lckanjgmijmafbedllaakclkaicjfmnk";
      }
    ];
    package = pkgs.brave;
  };
}
