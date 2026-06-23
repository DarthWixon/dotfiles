#!/usr/bin/env bash

wallpaper="$HOME/pictures/wallpapers/wallpaper_big.jpg"
lockimg="$HOME/.cache/i3lock-background.png"

mkdir -p "$HOME/.cache"

magick \
  -size 3640x1981 xc:black \
  \( "$wallpaper" -resize 2560x1440^ -gravity center -extent 2560x1440 \) \
  -gravity northwest \
  -geometry +1080+541 \
  -composite \
  "$lockimg"

i3lock -u -e -i "$lockimg"
