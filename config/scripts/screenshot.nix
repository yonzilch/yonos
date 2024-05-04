{ pkgs }:

pkgs.writeShellScriptBin "screenshot" ''
  wayshot -s "$(slurp)" --stdout | satty --filename - --output-filename ~/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png
''
