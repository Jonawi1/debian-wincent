#!/bin/bash
width=2560
height=1600
refresh=120
modeline=$(cvt $width $height $refresh | sed -n 's/^\Modeline //p')
/bin/bash -c "sleep 0.1 && xrandr --newmode $modeline && xrandr --addmode Virtual-1 ${width}x${height}_${refresh}.00 && xrandr -s ${width}x${height}_${refresh}.00"
if test -f ~/.fehbg; then
	~/.fehbg
else
	feh --bg-fill debian-wincent/img/IMG_20230802_151507.jpg
fi
picom &
slstatus &
