width=3440
height=1440
refresh=144
modeline=$(cvt $width $height $refresh | sed -n 's/^\Modeline //p')
/bin/bash -c "sleep 0.1 && xrandr --newmode $modeline && xrandr --addmode Virtual-1 ${width}x${height}_${refresh}.00 && xrandr -s ${width}x${height}_${refresh}.00"

xrdb -load ~/.Xresources
~/.config/rand_wallpaper.sh
picom &
unclutter &
dunst &
#kmonad .config/miryoku_kmonad.kbd &
exec dwm
