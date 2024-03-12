#width=2560
#height=1600
#refresh=120
#modeline=$(cvt $width $height $refresh | sed -n 's/^\Modeline //p')
#/bin/bash -c "sleep 0.1 && xrandr --newmode $modeline && xrandr --addmode Virtual-1 ${width}x${height}_${refresh}.00 && xrandr -s ${width}x${height}_${refresh}.00"

xset b off s off -dpms

xrdb -load ~/.Xresources
~/.config/rand_wallpaper.sh
picom &
unclutter &
dunst &
kmonad .config/keymap.kbd &
exec dwm
