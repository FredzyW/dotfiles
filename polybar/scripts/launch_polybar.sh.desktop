#/bin/bash
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		bp="right"
		if (($m == "DP-2")); then
			bp="none"
		fi
		MONITOR=$m BARPOS=$bp polybar --reload mybar &
	done
else
	polybar --reload mybar &
fi
