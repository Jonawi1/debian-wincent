#/bin/sh

sleep 10

if ! [ -f $BAT ]; then
    exit
fi

while true; do
    BAT_STATE="grep "STATUS" /sys/class/power_supply/BAT0/uevent | awk -F = '{print $2}'"
    BAT_PERCENT=/sys/class/power_supply/BAT0/capacity

    if [ $BAT_STATE -eq "Discharging" ]; then
        if [ $BAT_PERCENT -lt 30 ]; then
            dunstify --urgency=CRITICAL "Battery Low" "Level: ${BAT_PERCENT}%"
        fi
    else
        if [ $BAT_PERCENT -ge 100 ]; then
            dunstify --urgency=NORMAL "Battery Full" "Level: ${BAT_PERCENT}%"
        fi
    fi

    sleep 10
done
