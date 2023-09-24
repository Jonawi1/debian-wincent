#/bin/sh

TEMP=/sys/class/thermal/thermal_zone0/temp

if ! [ -f $TEMP ]; then
	exit
fi

for x in $(cat $TEMP);
do
	case $x in
		100|9[0-9]|8[0-9]) 	echo " $(cat $TEMP)󰔄!" ;;
		*)			echo " $(cat $TEMP)󰔄" ;;
	esac
done

