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
        # Dark Mode
        id = "dmghijelimhndkbmpgbldicpogfkceaj";
      }
      {
        # ClearURLs
        id = "lckanjgmijmafbedllaakclkaicjfmnk";
      }
      {
        # Cookie-Editor
        id = "hlkenndednhfkekhgcdicdfddnkalmdm";
      }
      {
        # KeePassXC-Browser
        id = "oboonakemofpalcgghocfoadofidjkkk";
      }
      {
        # KISS Translator
        id = "bdiifdefkgmcblbcghdlonllpjhhjgof";
      }
      {
        # LocalCDN
        id = "njdfdhgcmkocbgbhcioffdbicglldapd";
      }
      {
        # MetaMask
        id = "nkbihfbeogaeaoehlefnkodbefgpgknn";
      }
      {
        # uBlock Origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
      {
        # User-Agent Switcher and Manager
        id = "bhchdcejhohfmigjafbampogmaanbfkg";
      }
      {
        # Vimium C
        id = "hfjbmagddngcpeloejdejnfgbamkjaeg";
      }
      {
        # Violentmonkey
        id = "jinjaccalgkegednnccohejagnlnfdag";
      }
      {
        # Wappalyzer
        id = "gppongmhjkpfnbhagpmjfkannfbllamg";
      }
    ];
    package = pkgs.brave;
  };
}
