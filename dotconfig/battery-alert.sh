#/bin/sh

BAT=/sys/class/power_supply/BAT0

if ! [ -d $BAT ]; then
    exit
fi

BAT_STATE=$(grep 'STATUS' $BAT/uevent | awk -F = '{print $2}')
BAT_PERCENT=$(cat $BAT/capacity)

if [ $BAT_STATE = "Discharging" ]; then
    if [ $BAT_PERCENT -lt 20 ]; then
        dunstify --urgency=CRITICAL "Battery Low" "Level: ${BAT_PERCENT}%"
    fi
else
    if [ $BAT_PERCENT -ge 100 ]; then
        dunstify --urgency=LOW "Battery Full" "Level: ${BAT_PERCENT}%"
    fi
fi
