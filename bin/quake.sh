#!/bin/bash
namespace=quake_terminal
name=$(~/bin/get_name $@ -n $namespace)

notify-send -u Low "Triggered" "this is quake_terminal $@"
bspc rule -a URxvt:hiddenfloating state=floating hidden=on

if [[ -z $(xdotool search --classname '^'$name'$') ]]; then
	urxvtc -name hiddenfloating
	win=$(xdotool search --classname hiddenfloating)
	xdotool set_window --classname "forgotten" $win

	xy=$(get_end_pos $@ -n $namespace)
	x=$(echo $xy | awk '{print $1}')
	y=$(echo $xy | awk '{print $2}')

	xdotool windowsize $win 100 100
	xdotool windowmove $win $x $y

	bspc node $win -g hidden=off
	bspc rule -r URxvt:hiddenfloating state=floating hidden=on
fi
~/bin/quakify $@ -n $namespace -w $win
