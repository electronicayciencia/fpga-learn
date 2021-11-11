#!/bin/bash
# Convert hex from
# https://github.com/emaste/fontstuff/tree/master/syscons-fonts
# to Gowin Memory initialization file
# Null character is not included in ROM file.


maxchars=256
maxlines=$((maxchars*8))

if [ -z $1 ]
then
	echo "Usage: $0 cp437-8x8.hex > cp437-8x8.mi"
	exit 1
fi

cat << header
#File_format=Hex
#Address_depth=$maxlines
#Data_width=8
00
00
00
00
00
00
00
00
header
cat $1 | tail -n+3 | cut -d ':' -f 2 | fold -w 2 | head -n $((maxlines-8))
