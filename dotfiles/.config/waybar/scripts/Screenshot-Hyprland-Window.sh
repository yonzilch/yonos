#!/usr/bin/env bash

grim -g "$(hyprctl clients -j | jq '.[] | select(.hidden | not) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' -r | slurp)" - | swappy -f -
