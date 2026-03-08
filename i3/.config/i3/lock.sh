#!/bin/bash

setxkbmap us
convert ~/Pictures/Wallpapers/nord_hill.png -resize 1920 /tmp/screenshotblur.png
i3lock -k -i /tmp/screenshotblur.png
rm /tmp/screenshotblur.png
xmodmap ~/.Xmodmap
