#!/bin/bash

sgoinfre_location='/sgoinfre/goinfre'
downloads_location="$HOME"'/Downloads'

if [ ! "$USER" ]
then
	echo 'Please set USER Variable'
	exit 1
fi
sgoinfre_user_location="$sgoinfre_location"'/Perso/'"$USER"

echo 'Welcome '"$USER"' !'

if [ ! -e "$sgoinfre_location" ]
then
	echo 'Sgoinfre not found 😿'
	exit 1
fi

if [ ! -e "$sgoinfre_user_location" ]
then
	echo "$sgoinfre_user_location"' not found 😿'
	echo "Creating $sgoinfre_user_location ..."
	mkdir -v "$sgoinfre_user_location"
	chmod -R 700 "$sgoinfre_user_location"
fi

if [ ! -L "$downloads_location" ]
then
	mkdir -p "$downloads_location"
	echo "$downloads_location is still a directory in your home"
	mv -v "$downloads_location" "$sgoinfre_user_location/"
	ln -s "$sgoinfre_user_location/Downloads" "$downloads_location"
fi
echo 'See you soon ☺️ '
