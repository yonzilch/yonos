{ pkgs, ...}:
{
  programs.chromium = {
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
      "--wayland-text-input-v3=true"
    ];
    enable = true;
    extensions = [
      {
        id = "dcpihecpambacapedldabdbpakmachpb";
        updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
      }
    ];
    package = pkgs.brave;
  };
}
