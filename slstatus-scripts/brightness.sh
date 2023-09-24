#/bin/sh

BRT=$(light -G | awk '{print int(($1 / 5) + 0.5) *5 }')

for x in $BRT;
do
	case $x in
		100|9[0-9])	echo "󰃠 $BRT% | " ;;
		8[0-9]|7[0-9])	echo "󰃝 $BRT% | " ;;
		6[0-9]|5[0-9])	echo "󰃟 $BRT% | " ;;
		4[0-9]|3[0-9])	echo "󰃞 $BRT% | " ;;
		2[0-9]|1[0-9])	echo "󰃛 $BRT% | " ;;
		0)		echo ""	;;
		*)		echo "󰃜 $BRT% | " ;;
	esac
done

