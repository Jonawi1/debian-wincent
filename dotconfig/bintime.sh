#!/bin/sh
while (true) do
    H=$(echo "obase=2;$(date +%H)" | bc)
    M=$(echo "obase=2;$(date +%M)" | bc)
    S=$(echo "obase=2;$(date +%S)" | bc)
    dwm -s "$H:$M:$S"
    sleep 1
done
