linenum=$1
tabval=$(awk -v lnum="$linenum" 'NR==lnum{ print $1 }' /dev/shm/polybar-tabs)

if [ $tabval == 0 ]; then
	sed -i "${linenum}s/./1/" /dev/shm/polybar-tabs
	tabval=1
else
	sed -i "${linenum}s/./0/" /dev/shm/polybar-tabs
	tabval=0
fi

echo $tabval
