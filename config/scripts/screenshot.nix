{ pkgs }:

pkgs.writeShellScriptBin "screenshootin" ''
  wayshot -s "$(slurp)" --stdout | satty --filename - --save-after-copy --output-filename ~/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png
''
