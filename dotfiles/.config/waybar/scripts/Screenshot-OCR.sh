#!/usr/bin/env bash

## only support EN
grim -g "$(slurp)" - | tesseract -l "eng" stdin stdout | wl-copy;notify-send "OCR content copied to clipboard"
