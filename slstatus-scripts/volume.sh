#/bin/sh

VOL=$(amixer sget Master | tail -1 | awk '{print $4 $5}' | grep -o -P '(?<=\[).*(?=%)')

for x in $VOL;
do
	case $x in
		100|9[0-9]|8[0-9]|7[0-9])	echo "󰕾 $VOL% | " ;;
		6[0-9]|5[0-9]|4[0-9])		echo "󰖀 $VOL% | " ;;
		3[0-9]|2[0-9]|1[0-9]|[1-9])	echo "󰕿 $VOL% | " ;;
		*)				echo "󰖁 $VOL% | " ;;
	esac
done

