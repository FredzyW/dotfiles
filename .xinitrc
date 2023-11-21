#!/bin/sh

xrdb -merge ~/.Xresources
setxkbmap -option caps:swapescape
# if [ -f ~/.Xmodmap ]; then
#    xmodmap ~/.Xmodmap
# fi

feh --bg-scale /home/fwastring/Pictures/Skåne-Wallpaper.png
slstatus &
dunst &

xautolock -time 10 -locker slock
xbindkeys &
xbanish &

exec dwm
