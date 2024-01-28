#/bin/sh

sleep 10

if ! [ -f $BAT ]; then
    exit
fi

while true; do
    BAT_STATE="grep "STATUS" /sys/class/power_supply/BAT0/uevent | awk -F = '{print $2}'"
    BAT_PERCENT=/sys/class/power_supply/BAT0/capacity

    if [ $bat_state = 'Discharging' ]; then
        if [ $bat_percent -lt 30 ]; then
            dunstify --urgency=CRITICAL "Battery Low" "Level: ${bat_percent}%"
        fi
    else
        if [ $bat_percent -ge 100 ]; then
            dunstify --urgency=NORMAL "Battery Full" "Level: ${bat_percent}%"
        fi
    fi

    sleep 10
done
