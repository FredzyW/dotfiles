#!/bin/sh

xrdb -merge ~/.Xresources
setxkbmap -option caps:swapescape
# if [ -f ~/.Xmodmap ]; then
#    xmodmap ~/.Xmodmap
# fi

feh --bg-scale /home/fwastring/Pictures/Skåne_Landskap.png
slstatus &
dunst &

xautolock -time 10 -locker slock
xbindkeys &

exec dwm
