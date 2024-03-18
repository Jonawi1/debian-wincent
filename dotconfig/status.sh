#!/bin/sh

TEMP_FILE=/sys/class/thermal/thermal_zone0/temp
BAT_FILE=/sys/class/power_supply/BAT0/capacity
ID=@DEFAULT_AUDIO_SINK@
TEMP=""
VOL=""
TIME=""
BAT=""
BRT=""

while (true) do
    if [ -f $TEMP_FILE ]; then
        TEMP="| CPU $(cat $TEMP_FILE | awk '{print $0 / 1000}')°C "
    fi

    VOL="| VOL $(wpctl get-volume $ID | awk '{print $2 * 100}')% "

    TIME="| $(date "+%F %T") "
    
    if [ -f $BAT_FILE ]; then
        if [ $(cat /sys/class/power_supply/BAT0/uevent | head -n 3 | tail -n 1 | awk -F = '{print $2}') = "Charging" ]; then
            BAT="| BAT ⌃$(cat $BAT_FILE)% "
        else
            BAT="| BAT ⌄$(cat $BAT_FILE)% "
        fi
    fi

    LIGHT_OUTPUT=$(light -G)
    if ! echo "$LIGHT_OUTPUT" | grep -q "No backlight controller was found"; then
        BRT="| BRT $(echo "$LIGHT_OUTPUT" | awk '{print int(($1 / 5) + 0.5) * 5}')% "
    fi

    dwm -s "$TEMP$BRT$VOL$TIME$BAT|"
    sleep 1
done
