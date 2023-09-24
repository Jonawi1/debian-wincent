#/bin/sh

TEMP_FILE=/sys/class/thermal/thermal_zone0/temp

if ! [ -f $TEMP_FILE ]; then
	exit
fi

TEMP=$(cat $TEMP_FILE | awk '{print $0 / 1000}')

for x in $TEMP;
do
	case $x in
		1[0-9][0-9]|9[0-9]|8[0-9]) 	echo " / $TEMP󰔄!" ;;
		*)				echo " / $TEMP󰔄" ;;
	esac
done

