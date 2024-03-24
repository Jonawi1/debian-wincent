#width=2560
#height=1600
#refresh=120
#modeline=$(cvt $width $height $refresh | sed -n 's/^\Modeline //p')
#/bin/bash -c "sleep 0.1 && xrandr --newmode $modeline && xrandr --addmode Virtual-1 ${width}x${height}_${refresh}.00 && xrandr -s ${width}x${height}_${refresh}.00"

xset b off s off -dpms

~/.config/rand_wallpaper.sh &
~/.config/break.sh &
picom --experimental-backend &
unclutter &
dunst &
kmonad .config/keymap_4_beta_testing.kbd &
slstatus >/dev/null 2>&1 &
exec dwm
