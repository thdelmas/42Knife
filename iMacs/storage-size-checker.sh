#!/bin/bash

if [ ! "$USER" ]
then
	echo 'Please set USER Variable'
	exit 1
fi
echo
echo "Home folder report:"
echo
df -h ~ | sed 's/  */ /g' | cut -d' ' -f2,3,4,5
echo
echo

echo "Sgoinfre folder report:"
echo "$(du -d0 -h "/sgoinfre/goinfre/Perso/$USER" 2>&- | sed 's/G.*/G/g' ) / 30G"
