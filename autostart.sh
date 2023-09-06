#!/bin/bash
/bin/bash -c "sleep 0.1&&xrandr --newmode "3440x1440_30.00" 196.25 3440 3600 3952 4464 1440 1443 1453 1468 -hsync +vsync&&xrandr --addmode Virtual-1 3440x1440_30.00&&xrandr -s 3440x1440_30.00"
~/.fehbg
picom &
ststatus &
